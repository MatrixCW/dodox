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
#import <MapKit/MapKit.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "JSFlatButton.h"
#import "DOCEnterPIView.h"
#import "AMBlurView.h"


@interface DOCSelectDoctorViewController ()

//@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingChoice;

@property (weak, nonatomic) IBOutlet UILabel *currentSprciality;

@property (weak, nonatomic) IBOutlet UITableView *doctorTable;
@property NSMutableArray *doctors;

@property AMBlurView *blurView;
@property DOCEnterPIView *piView;

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
    
    self.currentSprciality.textAlignment = NSTextAlignmentCenter;
    self.currentSprciality.numberOfLines = 0;
    self.currentSprciality.text =[NSString stringWithFormat:@"\n%@", sharedInstance.currentSelectedSpeciality];
    
    self.currentSprciality.backgroundColor = [UIColor whiteColor];
    
    
    CALayer *leftBorder = [CALayer layer];
    leftBorder.borderColor = [UIColor colorWithRed:228.0/255 green:227.0/255 blue:230.0/255 alpha:1.0].CGColor;
    leftBorder.borderWidth = 2.0;
    leftBorder.frame = CGRectMake(-10, -2, self.currentSprciality.frame.size.width*2, self.currentSprciality.frame.size.height+3);
    
    [self.currentSprciality.layer addSublayer:leftBorder];
    
    self.doctorTable.backgroundColor =[UIColor colorWithRed:236.0/255 green:240.0/255 blue:243.0/255 alpha:1.0];
    NSLog(@"coming!!");
    
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255 green:240.0/255 blue:243.0/255 alpha:1.0];
    
    self.doctors = [NSMutableArray array];
    
    [self retriveDoctorUnderSpeciality];
    
    //[self.sortingChoice addTarget:self
      //                     action:@selector(pickOne:)
        //         forControlEvents:UIControlEventValueChanged];
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
    
    NSLog(@"%@", requestUrlString);
    
    NSURL *url = [NSURL URLWithString:requestUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            for(NSDictionary *dic in JSON){
                                                                                                
                                                                                                [self constructDoctorObjectFromDictionary:dic];
                                                                                                                                                                                                
                                                                                            }
                                                                                            
                                                                                            NSArray *dataArray = [self.doctors sortedArrayUsingComparator:^NSComparisonResult(DOCDoctor *first, DOCDoctor *second) {
                                                                                                return [first compareName:second];
                                                                                            }];
                                                                                            
                                                                                            self.doctors = [NSMutableArray arrayWithArray:dataArray];
                                                                                            
                                                                                            [self.doctorTable reloadData];
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
    NSArray *doctorGallery = [dict valueForKey:@"doctor_gallary_images"];
    NSDictionary *doctorAvatar = [dict valueForKey:@"pic"];
    NSDictionary *doctorCoordinate = [dict valueForKey:@"coorinate"];
    NSDictionary *doctorDescription = [dict valueForKey:@"description"];
    
    NSString *lat = [doctorCoordinate objectForKey:@"lat"];
    NSString *lng = [doctorCoordinate objectForKey:@"lng"];
    
    

    
    lat = @"123";
    lng = @"234";
    /*
    NSLog(@"%@ %@ %@ %@ %@ %@ %@ %@ %@ %@", doctorID, doctorName, doctorSpeciality, doctorAddress, doctorRate
          , doctorPhone, doctorGallery, doctorAvatar, doctorCoordinate, doctorDescription);
     */
    
    
   DOCDoctor *doctor = [[DOCDoctor alloc] initWithIdentity:[doctorID integerValue]
                                                       Name:doctorName
                                                 speciality:doctorSpeciality
                                                    address:doctorAddress
                                                       rate:[doctorRate floatValue]
                                                   position:CLLocationCoordinate2DMake([lat floatValue], [lng floatValue])
                                                      phone:doctorPhone
                                                    avatars:doctorAvatar
                                                description:doctorDescription
                                             andPictureURLs:doctorGallery];
    

        
    
    [doctor getMyTimeSlots];
    [self.doctors addObject:doctor];
    
 
    
    
    
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
    
    cell.doctorName.numberOfLines = 0;
    cell.doctorAddress.numberOfLines = 0;
    cell.doctorName.text = tempDoctor.doctorName;
    cell.doctorAddress.text = @"15:30";
    
    //DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
    //rateView.rate = tempDoctor.doctorRate;
    //rateView.alignment = RateViewAlignmentRight;
    //[cell.rate addSubview:rateView];
    
    cell.bookButton.associateCell = indexPath.row;
    cell.bookButton.buttonBackgroundColor = [UIColor colorWithRed:101.0/255 green:153.0/255 blue:255.0/255 alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    cell.bookButton.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    cell.bookButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [cell.bookButton setFlatTitle:@"Book now"];
    //[cell.bookButton setFlatImage:[UIImage imageNamed:@"play.png"]];
    
    
    //cell.bookButton.buttonBackgroundColor =  [UIColor colorWithRed:82 green:163 blue:82 alpha:1.0];
    //[cell.bookButton setFlatTitle:@"Bpmoniijb ook now"];
    
    NSURL *avatarThumbnail = [NSURL URLWithString:[tempDoctor.doctorAvatars objectForKey:@"medium"]];
    [cell.thumbnailImageView setImageWithURL:avatarThumbnail usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [cell.thumbnailImageView.layer setMasksToBounds:YES];
    [cell.thumbnailImageView.layer setCornerRadius:8.0];
    
    [cell.bookButton addTarget:self
                        action:@selector(book:)
              forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}



-(void)book:(JSFlatButton*) buttom{
    
    assert(buttom != nil);
    
    NSLog(@"%d", buttom.associateCell);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    sharedInstance.currentSelectedDoctor = [self.doctors objectAtIndex:buttom.associateCell];
    
    [self performSegueWithIdentifier:@"BOOK_DIRECTLY" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    sharedInstance.currentSelectedDoctor = [self.doctors objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"DOCTOR_SPECIFICS" sender:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
