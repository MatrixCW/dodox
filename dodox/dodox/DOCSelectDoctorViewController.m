//
//  DDXSelectDoctorViewController.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCSelectDoctorViewController.h"
#import "DOCDoctorTableViewCell.h"
#import "DOCConstants.h"
#import "DOCGlobalUtil.h"
#import "AFJSONRequestOperation.h"
#import "DOCDoctor.h"
#import "DYRateView.h"

@interface DOCSelectDoctorViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingChoice;
@property (weak, nonatomic) IBOutlet UINavigationBar *titleBar;

@property (weak, nonatomic) IBOutlet UITableView *doctorTable;
@property NSMutableArray *doctors;

@end

@implementation DOCSelectDoctorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.doctorTable.delegate = self;
    self.doctorTable.dataSource = self;
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    self.titleBar.topItem.title = sharedInstance.currentSelectedSpeciality;
    
    self.doctors = [NSMutableArray array];
    
    [self retriveDoctorUnderSpeciality];
    
    /*
    NSArray *dataArray = [self.doctors sortedArrayUsingComparator:^NSComparisonResult(DOCDoctor *first, DOCDoctor *second) {
        return [first compareName:second];
    }];
    
    self.doctors = [NSMutableArray arrayWithArray:dataArray];
    
    [self.sortingChoice addTarget:self
                           action:@selector(pickOne:)
                 forControlEvents:UIControlEventValueChanged];
     */

    
}

-(void) pickOne:(id)sender{
   UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    NSLog(@"%ld",(long)segmentedControl.selectedSegmentIndex);

    
    if(segmentedControl.selectedSegmentIndex == 0){
        
        
        NSArray *dataArray = [self.doctors sortedArrayUsingComparator:^NSComparisonResult(DOCDoctor *first, DOCDoctor *second) {
            return [first compareName:second];
        }];
        
        self.doctors = [NSMutableArray arrayWithArray:dataArray];
        
        [self.doctorTable reloadData];
        
    }
    
    if(segmentedControl.selectedSegmentIndex == 1){
        
        NSArray *dataArray = [self.doctors sortedArrayUsingComparator:^NSComparisonResult(DOCDoctor *first, DOCDoctor *second) {
            return [first compareDistance:second];
        }];
        
        self.doctors = [NSMutableArray arrayWithArray:dataArray];
        
        [self.doctorTable reloadData];
        
    }
    
    if(segmentedControl.selectedSegmentIndex == 2){
        
        NSArray *dataArray = [self.doctors sortedArrayUsingComparator:^NSComparisonResult(DOCDoctor *first, DOCDoctor *second) {
            return [first compareRate:second];
        }];
        
        self.doctors = [NSMutableArray arrayWithArray:dataArray];
        
        [self.doctorTable reloadData];
        
    }
}



-(void)retriveDoctorUnderSpeciality{
    
    NSString *urlPrefix = @"http://doxor.herokuapp.com/api/categories/%d/doctors.json";
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    int specialityID = sharedInstance.currentSelectedSpecialityID;
    
    NSString *requestUrlString = [NSString stringWithFormat:urlPrefix,specialityID];
    
    NSLog(@"%@", requestUrlString);
    
    NSURL *url = [NSURL URLWithString:requestUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            for(NSDictionary *dic in JSON){
                                                                                                
                                                                                                [self constructDoctorObjectFromDictionary:dic];
                                                                                                                                                                                                
                                                                                            }
                                                                                        }
                                                                                        failure:nil];
    [operation start];
    
}


-(void)constructDoctorObjectFromDictionary:(NSDictionary *)dict{
    
    NSString *doctorID = [dict valueForKey:@"id"];
    NSString *doctorName = [dict valueForKey:@"name"];
    NSString *doctorSpeciality = [dict valueForKey:@"category_name"];
    NSString *doctorAddress = [dict valueForKey:@"address"];
    NSString *doctorRate = [dict valueForKey:@"rate"];
    NSString *doctorPhone = [dict valueForKey:@"phone"];
    NSDictionary *doctorGallery = [dict valueForKey:@"doctor_gallary_images"];
    NSDictionary *doctorAvatar = [dict valueForKey:@"pic"];
    NSDictionary *doctorCoordinate = [dict valueForKey:@"coorinate"];
    NSDictionary *doctorDescription = [dict valueForKey:@"description"];
    
    NSLog(@"%@ %@ %@ %@ %@ %@ %@ %@ %@ %@", doctorID, doctorName, doctorSpeciality, doctorAddress, doctorRate
          , doctorPhone, doctorGallery, doctorAvatar, doctorCoordinate, doctorDescription);
    
    
    
    
}
#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.doctors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DOCDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMIZED_CELL_IDENTIFIER_FOR_DOCTOR];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    DOCDoctor *tempDoctor = [self.doctors objectAtIndex:indexPath.row];
    
    cell.doctorName.text = tempDoctor.doctorName;
    cell.doctorAddress.text = tempDoctor.doctorAddress;
    
    [cell.doctorName sizeToFit];
    [cell.doctorAddress sizeToFit];
    
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(0, 10, 100, 14)];
    rateView.rate = tempDoctor.doctorRate;
    rateView.alignment = RateViewAlignmentRight;
    [cell.rate addSubview:rateView];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"DOCTOR_SPECIFICS" sender:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
