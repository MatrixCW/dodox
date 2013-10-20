//
//  DOCBookTwoController.m
//  docxor
//
//  Created by Cui Wei on 10/16/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCBookTwoController.h"
#import "DOCBookForCell.h"
#import "DOCSimpleDoctorCell.h"
#import "DOCLocationCell.h"
#import "DOCTimeCell.h"
#import "DOCConfirmCell.h"
#import "DOCGlobalUtil.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface DOCBookTwoController ()

@property NSString *userName;
@property NSString *userPhone;
@property NSString *userEmail;

@end

@implementation DOCBookTwoController

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
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];;
    
    self.titleLabel.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];;
    
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = @"\nPlease Verify";
    
    self.bookTable.delegate = self;
    self.bookTable.dataSource = self;
    
    NSDictionary *dict = [self readFromFile];
    self.userName = [dict valueForKey:@"user_name"];
    self.userPhone = [dict valueForKey:@"user_phone"];
    self.userEmail = [dict valueForKey:@"user_email"];
}



-(NSDictionary*)readFromFile{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    NSLog(@"%@", plistDict);
    
    return plistDict;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int height = 0;
    
    switch (indexPath.row) {
        case 0:
            height = 80;
            break;
        case 1:
            height = 111;
            break;
        case 2:
            height = 110;
            break;
        case 3:
            height = 100;
            break;
        case 4:
            height = 82;
            break;
        default:
            break;
    }
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = indexPath.row;
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoc = sharedInstance.currentSelectedDoctor;
    DOCDate *currentDate = sharedInstance.currentDate;
    
    if(!currentDate)
        currentDate = [currentDoc.timeSlots objectAtIndex:0];
    
    if(index == 0){
        
        DOCBookForCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookfor"];
        
        if (cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"bookfor" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.bookNameTitle.text = self.userName;
            cell.confirmLabel.hidden = YES;
        }
        
        NSLog(@"0");
        return cell;
        
    }
    else if(index == 1){
        
        DOCSimpleDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpledoctor"];
        
        
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"simpledoctor" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            
            cell.doctorName.font = [UIFont fontWithName:@"Avenir Next" size:20];
            cell.doctorName.textColor = [UIColor blackColor];
            cell.doctorName.text = currentDoc.doctorName;
            
            cell.doctorCategory.font = [UIFont fontWithName:@"Avenir Next" size:14];
            cell.doctorCategory.textColor = [UIColor redColor];
            cell.doctorCategory.text = currentDoc.doctorSpeciality;
            
            cell.subCategory.font = [UIFont fontWithName:@"Avenir Next" size:10];
            cell.subCategory.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
            cell.subCategory.text = currentDoc.subCategory;
            
            cell.clinicName.font = [UIFont fontWithName:@"Avenir Next" size:9];
            cell.clinicName.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
            cell.clinicName.text = currentDoc.clinicName;
            
        
            [cell.doctorAvatar.layer setMasksToBounds:YES];
            [cell.doctorAvatar.layer setCornerRadius:cell.doctorAvatar.bounds.size.width/2];
            
            NSString *imgUrlString = [currentDoc.doctorAvatars valueForKey:@"original"];
            [cell.doctorAvatar setImageWithURL:[NSURL URLWithString:imgUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            
        }
        
        return cell;
        
        
    }
    else if(index == 2){
        
        DOCLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationcell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"locationcell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.clinicName.text = currentDoc.clinicName;
            cell.addressTag.text = currentDoc.doctorAddress;
            cell.postCodeTag.text = currentDoc.postCode;
            
        }
        
        return cell;
        
        
    }
    else if(index == 3){
        
        DOCTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ddddd"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"booktwotimeslot" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSString *dayOfWeek = [self extractDayOfWeek:currentDate.myDate];
        NSString *dateString = [self extractDate:currentDate.myDate];
        NSString *timeString = [self extractTime:currentDate.myDate];
        
        cell.dateLabel.text = [NSString stringWithFormat:@"%@, %@",dayOfWeek,dateString];
        cell.timeLabel.text = timeString;
        
        [cell.rightButton addTarget:self action:@selector(nextSlot) forControlEvents:UIControlEventTouchUpInside];
        [cell.leftButton addTarget:self action:@selector(previousSlot) forControlEvents:UIControlEventTouchUpInside];
    
        return cell;

        
    }
    else{
        
        DOCConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"confirmcell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"confirmcell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [cell.confirmButton addTarget:self action:@selector(makeABook) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;

        
    }
    
}


-(NSString*)extractDayOfWeek:(NSDate *)dt{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSArray *daysOfWeek = @[@"",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
	[dateFormatter setDateFormat:@"e"];
	NSInteger weekdayNumber = (NSInteger)[[dateFormatter stringFromDate:dt] integerValue];
    
    return [daysOfWeek objectAtIndex:weekdayNumber];
    
}

-(NSString*)extractDate:(NSDate *)dt{
    
    NSLog(@"the date is %@",dt);
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSString *theDateString = [df stringFromDate:dt];
    
    NSArray *ary = [theDateString componentsSeparatedByString:@"-"];
    
    NSString *year = [ary objectAtIndex:0];
    
    NSString *month = [ary objectAtIndex:1];
    int monthInt = [month intValue];
    
    NSArray *months = @[@"January", @"February", @"Marth",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"december"];
    
    month = [months objectAtIndex:(monthInt - 1)];
    
    
    
    NSString *day = [ary objectAtIndex:2];
    int dayInt = [day intValue];
    NSString *postFix;
    
    switch (dayInt%10) {
        case 1:
            postFix = @"st";
            break;
        case 2:
            postFix = @"nd";
            break;
        case 3:
            postFix = @"rd";
            break;
            
        default:
            postFix = @"th";
            break;
    }
    
    day = [day stringByAppendingString:postFix];
    
    return [NSString stringWithFormat:@"%@ %@ %@", day,month,year];
    
    
}

-(NSString*)extractTime:(NSDate *)dt{
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSString *timeString = [df stringFromDate:dt];
    
    return timeString;

    
}


-(void)nextSlot{
    
    int currentIndex = 0;
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoc = sharedInstance.currentSelectedDoctor;
    DOCDate *currentDate = sharedInstance.currentDate;
    
    for(int i = 0; i<currentDoc.timeSlots.count;i++){
        
        if([currentDoc.timeSlots objectAtIndex:i] == currentDate){
            currentIndex = i;
            break;
        }
            
    }
    
    currentIndex ++;
    
    if(currentIndex >= currentDoc.timeSlots.count)
        return;
    else{
        
        currentDate = [currentDoc.timeSlots objectAtIndex:currentIndex];
        sharedInstance.currentDate = currentDate;
        
        DOCTimeCell *cell = (DOCTimeCell*)[self.bookTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];;
        
        NSString *dayOfWeek = [self extractDayOfWeek:currentDate.myDate];
        NSString *dateString = [self extractDate:currentDate.myDate];
        NSString *timeString = [self extractTime:currentDate.myDate];
        
        cell.dateLabel.text = [NSString stringWithFormat:@"%@, %@",dayOfWeek,dateString];
        cell.timeLabel.text = timeString;
        
        
    }
    
}

-(void)previousSlot{
    
    int currentIndex = -1;
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoc = sharedInstance.currentSelectedDoctor;
    DOCDate *currentDate = sharedInstance.currentDate;
    
    for(int i = 0; i<currentDoc.timeSlots.count;i++){
        
        if([currentDoc.timeSlots objectAtIndex:i] == currentDate){
            currentIndex = i;
            break;
        }
        
    }
    
    currentIndex --;
    
    if(currentIndex < 0)
        return;
    else{
        
        currentDate = [currentDoc.timeSlots objectAtIndex:currentIndex];
        sharedInstance.currentDate = currentDate;
        
        DOCTimeCell *cell = (DOCTimeCell*)[self.bookTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];;
        
        NSString *dayOfWeek = [self extractDayOfWeek:currentDate.myDate];
        NSString *dateString = [self extractDate:currentDate.myDate];
        NSString *timeString = [self extractTime:currentDate.myDate];
        
        cell.dateLabel.text = [NSString stringWithFormat:@"%@, %@",dayOfWeek,dateString];
        cell.timeLabel.text = timeString;
        
    }

    
}


-(void)makeABook{
    
    
    NSMutableDictionary *booking = [[NSMutableDictionary alloc] init];
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoctor =  sharedInstance.currentSelectedDoctor;
    DOCDate *currentDate = sharedInstance.currentDate;
    
    NSMutableDictionary *b = [[NSMutableDictionary alloc] init];
    
    NSArray *ary = [NSArray arrayWithObjects:currentDate.slotIdentifier, nil];
    assert(currentDate.slotIdentifier!=nil);
    NSString *doctorID = [[NSNumber numberWithInt:currentDoctor.doctorID] stringValue];
    [booking setValue:doctorID forKey:@"doctor_id"];
    [booking setValue:self.userPhone forKey:@"patient_phone"];
    [booking setValue:self.userName forKey:@"patient_name"];
    [booking setValue:self.userEmail forKey:@"patient_email"];
    [booking setValue:@"" forKey:@"symptoms"];
    [b setValue:ary forKey:@"timeslots"];
    [b setObject:booking forKey:@"booking"];
    NSLog(@"the b is %@",b);
    
    
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://doxor.herokuapp.com/"]];
    
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    
    [httpClient postPath:@"api/bookings.json" parameters:b success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"SUCCEEDED!");
        NSLog(@"Response: %@",responseObject);
        
        [self performSegueWithIdentifier:@"TWO_TO_THREE" sender:self];
        //[currentDoctor getMyTimeSlots];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
