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
#import <QuartzCore/QuartzCore.h>
#import "DYRateView.h"
#import "DOCDate.h"

@interface DOCSelectDoctorViewController ()

//@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingChoice;
- (IBAction)searchButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UILabel *currentSpeciality;
@property (weak, nonatomic) IBOutlet UITableView *doctorTable;
@property NSMutableArray *doctors;

@property NSMutableArray *displayDoctors;

@property AMBlurView *blurView;
@property DOCEnterPIView *piView;

@end

@implementation DOCSelectDoctorViewController{
    UIColor *greyBGColor;
}


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
    
    self.searchField.returnKeyType = UIReturnKeyDone;
    self.searchField.delegate = self;
    
    greyBGColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    self.currentSpeciality.textAlignment = NSTextAlignmentCenter;
    self.currentSpeciality.numberOfLines = 0;
    self.currentSpeciality.text =[NSString stringWithFormat:@"\n%@", sharedInstance.currentSelectedSpeciality];
    
    self.currentSpeciality.backgroundColor = greyBGColor;
    
    self.searchField.backgroundColor = [UIColor whiteColor];
    [self.searchField.layer setMasksToBounds:YES];
    [self.searchField.layer setCornerRadius:5.0];
    

    self.doctorTable.backgroundColor =greyBGColor;
    
    self.view.backgroundColor = greyBGColor;
    
    self.doctors = [NSMutableArray array];
    
    [self retriveDoctorUnderSpeciality];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)searchSpecialists{
    
    
    if(self.searchField.text.length == 0){
        
        self.displayDoctors = [NSMutableArray arrayWithArray:self.doctors];
        
        [self.doctorTable reloadData];
        
    }
    
    else{
        
       // self.displayArray = [NSMutableArray array];
        
       // for(DOCSpeciality *item in self.specialities){
            
          //  NSString *specialityName = item.specialityName;
            
           /// if([self string:specialityName containscharsFromString:self.searchField.text])
                
                //[self.displayArray addObject: item];
            
       // }
        
       // [self.specialityTable reloadData];
    }
    
    
}

-(BOOL)string:(NSString*)receiver containscharsFromString:(NSString*)queryString{
    
    NSString *lowerQueryString = [queryString lowercaseString];
    NSString *lowerReceiver = [receiver lowercaseString];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [lowerQueryString length]; i++) {
        [array addObject:[NSString stringWithFormat:@"%C", [lowerQueryString characterAtIndex:i]]];
    }
    
    for(NSString *item in array){
        if ([lowerReceiver rangeOfString:item].location == NSNotFound)
            
            return FALSE;
    }
    
    return true;
    
    
    
}





-(void)retriveDoctorUnderSpeciality{
    
    NSString *queryUrl = @"http://doxor.herokuapp.com/api/categories/%d/doctors.json?lat=1.29135368&lng=103.779730";
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    int specialityID = sharedInstance.currentSelectedSpecialityID;
    
    NSString *requestUrlString = [NSString stringWithFormat:queryUrl,specialityID];
    
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
                                                                                            
                                                                                            self.displayDoctors = [NSMutableArray arrayWithArray:dataArray];
                                                                                            
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
    NSString *subCategory = [dict valueForKey:@"subcategory"];
    NSString *clinicName = [dict valueForKey:@"clinic_name"];
    NSString *postCode = [dict valueForKey:@"post"];

    //NSArray *doctorGallery = [dict valueForKey:@"doctor_gallary_images"];
    NSDictionary *doctorAvatar = [dict valueForKey:@"pic"];
    NSArray *timeslots = [dict valueForKey:@"timeslots"];
    //NSDictionary *doctorCoordinate = [dict valueForKey:@"coorinate"];
    //NSDictionary *doctorDescription = [dict valueForKey:@"description"];
    
    //NSString *lat = [doctorCoordinate objectForKey:@"lat"];
    //NSString *lng = [doctorCoordinate objectForKey:@"lng"];
    
    DOCDoctor *doctor = [[DOCDoctor alloc] init];
    
    doctor.doctorID = [doctorID intValue];
    doctor.doctorName = doctorName;
    doctor.doctorAddress = doctorAddress;
    doctor.doctorPhoneNumber = doctorPhone;
    doctor.doctorRate = [doctorRate floatValue];
    doctor.doctorSpeciality = doctorSpeciality;
    doctor.doctorAvatars = doctorAvatar;
    doctor.timeSlots = timeslots;
    doctor.subCategory = subCategory;
    doctor.clinicName = clinicName;
    doctor.postCode = postCode;
    
    
    [doctor parseTime];
    
    [self.doctors addObject:doctor];
    
 
    
    
    
}

#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.doctors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DOCDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMIZED_CELL_IDENTIFIER_FOR_DOCTOR];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
       DOCDoctor *tempDoctor = [self.doctors objectAtIndex:indexPath.row];
    
    /*
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
     */
    
    cell.doctorName.font = [UIFont fontWithName:@"Avenir Next" size:14];
    cell.doctorName.text = tempDoctor.doctorName;
    cell.doctorName.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
    
    cell.doctorAddress.font = [UIFont fontWithName:@"Avenir Next" size:8];
    cell.doctorAddress.text = tempDoctor.doctorAddress;
    cell.doctorAddress.textColor = [UIColor colorWithRed:102.0/255 green:104.0/255 blue:107.0/255 alpha:1.0];
    
    
    DOCDate *firstSlot;
    
    if(tempDoctor.timeSlots.count  > 0)
        firstSlot = [tempDoctor.timeSlots objectAtIndex:0];
    NSDate *firstDate = firstSlot.myDate;
    
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSArray *daysOfWeek = @[@"",@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
	[dateFormatter setDateFormat:@"e"];
	NSInteger weekdayNumber = (NSInteger)[[dateFormatter stringFromDate:firstDate] integerValue];
    
    cell.dayLabel.backgroundColor = [UIColor colorWithRed:254.0/255 green:252.0/255 blue:157.0/255 alpha:1.0];
    cell.dayLabel.text = [daysOfWeek objectAtIndex:weekdayNumber];
    cell.dayLabel.font = [UIFont fontWithName:@"Avenir Next" size:8];
    cell.dayLabel.textColor = [UIColor colorWithRed:157.0/255 green:160.0/255 blue:145.0/255 alpha:1.0];
    [cell.dayLabel.layer setMasksToBounds:YES];
    [cell.dayLabel.layer setCornerRadius:2.0];

    cell.atLabel.font = [UIFont fontWithName:@"Avenir Next" size:8];
    cell.atLabel.textColor = [UIColor colorWithRed:157.0/255 green:160.0/255 blue:145.0/255 alpha:1.0];
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];

    NSString *timeString = [df stringFromDate:firstDate];
    
    cell.timeLabel.backgroundColor = [UIColor colorWithRed:107.0/255 green:189.0/255 blue:156.0/255 alpha:1.0];
    cell.timeLabel.text = timeString;
    cell.timeLabel.font = [UIFont fontWithName:@"Avenir Next" size:8];
    cell.timeLabel.textColor = [UIColor whiteColor];
    [cell.timeLabel.layer setMasksToBounds:YES];
    [cell.timeLabel.layer setCornerRadius:2.0];
    
    [cell.thumbnailImageView.layer setMasksToBounds:YES];
    [cell.thumbnailImageView.layer setCornerRadius:cell.thumbnailImageView.frame.size.width/2];
    
    NSString *imgUrlString = [tempDoctor.doctorAvatars valueForKey:@"medium"];
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:imgUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    UIImage *fullStar = [UIImage imageNamed:@"star_gold_half.png"];
    //fullStar = [self resizeImage:fullStar to:CGSizeMake(fullStar.size.width/2.0, fullStar.size.width/2.0)];
    UIImage *emptyStar = [UIImage imageNamed:@"star_none_half.png"];
    //emptyStar = [self resizeImage:emptyStar to:CGSizeMake(emptyStar.size.width/2.0, emptyStar.size.width/2.0)];

    DYRateView *rateView = [[DYRateView alloc] initWithFrame:cell.rateView.bounds fullStar:fullStar emptyStar:emptyStar];
    rateView.rate = tempDoctor.doctorRate;
    rateView.alignment = RateViewAlignmentCenter;
    [cell.rateView addSubview:rateView];
    
    [cell.bookButton addTarget:self action:@selector(book:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}



-(void)book:(id)sender{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.doctorTable];
    
    NSIndexPath *indexPath = [self.doctorTable indexPathForRowAtPoint:buttonPosition];
    
    NSLog(@"%d",indexPath.row);
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    sharedInstance.currentSelectedDoctor = [self.doctors objectAtIndex:indexPath.row];
    sharedInstance.currentDate = [sharedInstance.currentSelectedDoctor.timeSlots objectAtIndex:0];
    assert(sharedInstance.currentDate.slotIdentifier != nil);

 
    [self performSegueWithIdentifier:@"BOOK_DIRECTLY" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
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

- (IBAction)searchButtonPressed:(id)sender {
}
@end
