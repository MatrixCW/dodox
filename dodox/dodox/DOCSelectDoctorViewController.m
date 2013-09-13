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
    
    DOCDoctor *myDoctorOne = [[DOCDoctor alloc] initWithIdentity:1
                                                         Name:@"Michael Yeong"
                                                      address:@"NUS SOC"
                                                         rate:4.6
                                                     position:CLLocationCoordinate2DMake(123.0, 23.4)
                                                        phone:@"12345678"
                                                  description:Nil
                                               andPictureURLs:Nil];
    
    DOCDoctor *myDoctorTwo = [[DOCDoctor alloc] initWithIdentity:1
                                                         Name:@"Koh Zi Chun"
                                                      address:@"usa"
                                                         rate:4.3
                                                     position:CLLocationCoordinate2DMake(34.0, 13.4)
                                                        phone:@"12345678"
                                                  description:Nil
                                               andPictureURLs:Nil];
    
    DOCDoctor *myDoctorThree = [[DOCDoctor alloc] initWithIdentity:1
                                                         Name:@"Lin WeiQuan"
                                                      address:@"com1"
                                                         rate:3.5
                                                     position:CLLocationCoordinate2DMake(23.0, 53.4)
                                                        phone:@"12345678"
                                                  description:Nil
                                               andPictureURLs:Nil];
    
    DOCDoctor *myDoctorFour = [[DOCDoctor alloc] initWithIdentity:1
                                                         Name:@"Jiang Yanxuan"
                                                      address:@"sheares"
                                                         rate:2.9
                                                     position:CLLocationCoordinate2DMake(3.0, 3.4)
                                                        phone:@"12345678"
                                                  description:Nil
                                               andPictureURLs:Nil];
    
    DOCDoctor *myDoctorFive = [[DOCDoctor alloc] initWithIdentity:1
                                                         Name:@"Yang ManSheng"
                                                      address:@"pgp"
                                                         rate:5.0
                                                     position:CLLocationCoordinate2DMake(13.0, 1.4)
                                                        phone:@"12345678"
                                                  description:Nil
                                               andPictureURLs:Nil];
    
    [self.doctors addObject:myDoctorOne];
    [self.doctors addObject:myDoctorTwo];
    [self.doctors addObject:myDoctorThree];
    [self.doctors addObject:myDoctorFour];
    [self.doctors addObject:myDoctorFive];
    
    NSArray *dataArray = [self.doctors sortedArrayUsingComparator:^NSComparisonResult(DOCDoctor *first, DOCDoctor *second) {
        return [first compareName:second];
    }];
    
    self.doctors = [NSMutableArray arrayWithArray:dataArray];
    
    [self.sortingChoice addTarget:self
                           action:@selector(pickOne:)
                 forControlEvents:UIControlEventValueChanged];
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

/*

-(void)retriveDoctorUnderSpeciality{
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    int specialityID = sharedInstance.currentSelectedSpecialityID;
    
    NSURL *url = [NSURL URLWithString:@"http://docxor.heroku.com/api/categories.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            for(NSDictionary *dic in JSON){
                                                                                                
                                                                                                NSString *specialityID = [dic objectForKey:@"id"];
                                                                                                
                                                                                                NSString *specialityName = [dic objectForKey:@"name"];
                                                                                                
                                                                                                NSString *imageUrl = [dic objectForKey:@"imageUrl"];
                                                                                                
                                                                                                NSString *numberOfDoctors = [dic objectForKey:@"number"];
                                                                                                
                                                                                                NSLog(@"%@ %@ %@ %@", specialityID, specialityName, imageUrl, numberOfDoctors);
                                                                                                
                                                                                                DOCSpeciality *tempSpeciality = [[DOCSpeciality alloc] initWithName:specialityName
                                                                                                                                                           identity:[specialityID intValue]
                                                                                                                                                             number:[numberOfDoctors intValue]
                                                                                                                                                        andImageURL:imageUrl];
                                                                                                
                                                                                                [self.specialities addObject:tempSpeciality];
                                                                                                
                                                                                            }
                                                                                        }
                                                                                        failure:nil];
    [operation start];
    
}
 */


//-(void) pickOne:(id)sender{
 //   UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
//}


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
