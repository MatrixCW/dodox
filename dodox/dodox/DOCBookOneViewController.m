//
//  DOCBookTimeViewController.m
//  docxor
//
//  Created by Chen Zeyu on 13-9-17.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import "DOCBookOneViewController.h"
#import "DOCGlobalUtil.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "SVProgressHUD.h"
#import "DOCGlobalUtil.h"
#import "DOCDoctor.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AFJSONRequestOperation.h"
#import "DOCDate.h"
#import "DOCDoctorGeneralInfoCell.h"
#import "DYRateView.h"
#import "DOCPICell.h"

@interface DOCBookOneViewController ()


@property int confirmedID;
@property BOOL tableDidMoveup;

@end

@implementation DOCBookOneViewController

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
    
    self.infoTable.delegate = self;
    self.infoTable.dataSource = self;
    
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    
    self.titleLabel.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    self.titleLabel.text = @"\nPatient";
    self.titleLabel.numberOfLines = 0;
    /*
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *doctor =  sharedInstance.currentSelectedDoctor;
    
    
    
    self.bookingStartView.confirmButton.backgroundColor = [UIColor colorWithRed:68.0/255 green:149.0/255 blue:85.0/255 alpha:1.0];
    
    self.bookingStartView.confirmButton.tintColor = [UIColor whiteColor];
    
    
    
    
    [self.bookingStartView.cancelButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bookingStartView.confirmButton addTarget:self action:@selector(makeABook) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.bookingStartView.currentIndex = 0 ;
    
    DOCDate *tempDate = [doctor.timeSlots objectAtIndex:self.bookingStartView.currentIndex];
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    [df setDateFormat:@"HH:mm"];
    NSString *theTime = [df stringFromDate:tempDate.myDate];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [df stringFromDate:tempDate.myDate];
    
    self.bookingStartView.timeMinute.text = theTime;
    self.bookingStartView.dateTag.text = theDate;

    
    [self.bookingStartView.previousButton addTarget:self action:@selector(previousSlot) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bookingStartView.nextButton addTarget:self action:@selector(nextSlot) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.bookingStartView.doctorAvator setImageWithURL:[doctor.doctorAvatars objectForKey:@"medium"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.bookingStartView.doctorNameTag.text = doctor.doctorName;
    
    self.bookingStartView.doctoraAddress.text = doctor.doctorAddress;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    
    NSString *name = [plistDict objectForKey:@"name"];
    
    self.bookingStartView.bookingTitle.text = [NSString stringWithFormat:@"Booking for %@ with:",name];
     */
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int height = 0;
    
    switch (indexPath.row) {
        case 0:
            height = 140;
            break;
        case 1:
            height = 350;
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
        
        DOCDoctorGeneralInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorGeneral"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellGeneral" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            UIImage *fullStar = [UIImage imageNamed:@"star_gold_half.png"];
            //fullStar = [self resizeImage:fullStar to:CGSizeMake(fullStar.size.width/2.0, fullStar.size.width/2.0)];
            UIImage *emptyStar = [UIImage imageNamed:@"star_none_half.png"];
            //emptyStar = [self resizeImage:emptyStar to:CGSizeMake(emptyStar.size.width/2.0, emptyStar.size.width/2.0)];
            
            DYRateView *rateView = [[DYRateView alloc] initWithFrame:cell.rateView.bounds fullStar:fullStar emptyStar:emptyStar];
            rateView.rate = currentDoc.doctorRate;
            rateView.alignment = RateViewAlignmentCenter;
            [cell.rateView addSubview:rateView];
            
            cell.doctorName.font = [UIFont fontWithName:@"Avenir Next" size:20];
            cell.doctorName.textColor = [UIColor blackColor];
            cell.doctorName.text = currentDoc.doctorName;
            
            cell.doctorCategpry.font = [UIFont fontWithName:@"Avenir Next" size:14];
            cell.doctorCategpry.textColor = [UIColor redColor];
            cell.doctorCategpry.text = currentDoc.doctorSpeciality;

            cell.doctorSubCategory.font = [UIFont fontWithName:@"Avenir Next" size:10];
            cell.doctorSubCategory.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
            cell.doctorSubCategory.text = currentDoc.subCategory;
            
            cell.doctorClinicName.font = [UIFont fontWithName:@"Avenir Next" size:9];
            cell.doctorClinicName.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
            cell.doctorClinicName.text = currentDoc.clinicName;
            
            cell.doctorLocation.font = [UIFont fontWithName:@"Avenir Next" size:10];
            cell.doctorLocation.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
            cell.doctorLocation.text = currentDoc.doctorAddress;
            
            
            
            
            /*
             NSURL *avatarThumbnail = [NSURL URLWithString:[currentDoctor.doctorAvatars objectForKey:@"original"]];
             
             [cell.doctorAvatar setImageWithURL:avatarThumbnail usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
             
             
             cell.doctorName.text = currentDoctor.doctorSpeciality;
             
             [cell.doctorAvatar.layer setMasksToBounds:YES];
             [cell.doctorAvatar.layer setCornerRadius:8.0];
             */
            [cell.doctorAvatar.layer setMasksToBounds:YES];
            [cell.doctorAvatar.layer setCornerRadius:cell.doctorAvatar.bounds.size.width/2];
            
            NSString *imgUrlString = [currentDoc.doctorAvatars valueForKey:@"original"];
            [cell.doctorAvatar setImageWithURL:[NSURL URLWithString:imgUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
        }
        
        return cell;
        
    }
    else{
        
        DOCPICell *cell = [tableView dequeueReusableCellWithIdentifier:@"PICELL"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"personalInfo" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setBorderColor];
        
        cell.nameField.delegate = self;
        cell.phoneField.delegate = self;
        cell.emailField.delegate = self;
        
        cell.nameField.returnKeyType = UIReturnKeyDone;
        cell.phoneField.returnKeyType = UIReturnKeyDone;
        cell.emailField.returnKeyType = UIReturnKeyDone;
        
        NSDictionary *dict = [self readFromFile];
        
        if(dict.allValues.count > 0){
            cell.nameField.text = [dict valueForKey:@"user_name"];
            cell.phoneField.text = [dict valueForKey:@"user_phone"];
            cell.emailField.text = [dict valueForKey:@"user_email"];
        }
        
        [cell.continueButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];

               
        return cell;
        
        
    }
}


-(void)nextStep{
    
    DOCPICell *cell = (DOCPICell*)[self.infoTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *userName = cell.nameField.text;
    NSString *userPhone = cell.phoneField.text;
    NSString *userEmail = cell.emailField.text;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:userName, @"user_name",userPhone,@"user_phone",userEmail,@"user_email",nil];
    NSLog(@"%@",dict);
    [self writeToPlist:dict];
    [self performSegueWithIdentifier:@"ONE_TO_TWO" sender:self];
    
}


-(void)writeToPlist:(NSDictionary*)dict{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    [dict writeToFile:plistLocation atomically:YES];
    
    
}

-(NSDictionary*)readFromFile{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    NSLog(@"%@", plistDict);
    
    return plistDict;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    if(self.tableDidMoveup){
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.infoTable.center = CGPointMake(self.infoTable.center.x, self.infoTable.center.y+186);
            
        }];
        
        self.tableDidMoveup = FALSE;
    }
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if(!self.tableDidMoveup){
        [UIView animateWithDuration:0.2 animations:^{
            
            self.infoTable.center = CGPointMake(self.infoTable.center.x, self.infoTable.center.y-186);
            
        }];
        self.tableDidMoveup = TRUE;
    }
    
}

-(void)previousSlot{
    
    /*
    if(self.bookingStartView.currentIndex == 0)
        return;
    
    self.bookingStartView.currentIndex --;
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoctor =  sharedInstance.currentSelectedDoctor;
    
    DOCDate *tempDate = [currentDoctor.timeSlots objectAtIndex:self.bookingStartView.currentIndex];
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];

    [df setDateFormat:@"HH:mm"];
    NSString *theTime = [df stringFromDate:tempDate.myDate];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [df stringFromDate:tempDate.myDate];
    
    self.bookingStartView.timeMinute.text = theTime;
    self.bookingStartView.dateTag.text = theDate;
    
    NSLog(@"previous!");
     */
    
}


-(void)nextSlot{
    
    /*
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoctor =  sharedInstance.currentSelectedDoctor;
    
    if(self.bookingStartView.currentIndex == (currentDoctor.timeSlots.count - 1))
        return;
    
    self.bookingStartView.currentIndex ++;
    
    
    
    DOCDate *tempDate = [currentDoctor.timeSlots objectAtIndex:self.bookingStartView.currentIndex];
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    [df setDateFormat:@"HH:mm"];
    NSString *theTime = [df stringFromDate:tempDate.myDate];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [df stringFromDate:tempDate.myDate];
    
    self.bookingStartView.timeMinute.text = theTime;
    self.bookingStartView.dateTag.text = theDate;
    
    NSLog(@"next!");
     */

    
}

-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:Nil];
}


-(void)makeABook{
    
    /*
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    NSLog(@"%@", plistDict);
    
    NSString *phoneNumber = [plistDict objectForKey:@"phone"];
    
    NSMutableDictionary *booking = [[NSMutableDictionary alloc] init];
    NSMutableArray *myArray = [NSMutableArray array];
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoctor =  sharedInstance.currentSelectedDoctor;
    
    DOCDate *selectedDate = (DOCDate*)[currentDoctor.timeSlots objectAtIndex:self.bookingStartView.currentIndex];
    
    NSString *slotID = selectedDate.slotID;
    
    self.confirmedID = self.bookingStartView.currentIndex;
    
    [myArray addObject:slotID];
    
    NSArray *myary = [NSArray arrayWithArray:myArray];
    
    NSString *doctorID = [[NSNumber numberWithInt:currentDoctor.doctorID] stringValue];
    [booking setValue:doctorID forKey:@"doctor_id"];
    [booking setValue:phoneNumber forKey:@"patient_phone"];
    [booking setValue:@"I am painful" forKey:@"symptoms"];
    [booking setValue:myary forKey:@"timeslots"];
    
    NSLog(@"%@",booking);

    
    
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://doxor.herokuapp.com/"]];
    
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    
    [httpClient postPath:@"api/bookings.json" parameters:booking success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"SUCCEEDED!");
        NSLog(@"Response: %@",responseObject);
        //[currentDoctor getMyTimeSlots];
        [self saveAndExit];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    */
    
    /*
    [UIView animateWithDuration:0.8
                     animations:^{
                         
                         self.bookingStartView.center  = CGPointMake(self.bookingStartView.center.x,self.bookingStartView.center.y+1000);
                         
                     }
                     completion:^(BOOL finished){
                         
                         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookingConfirmed" owner:self options:nil];
                         self.bookingConfirmedView = [nib objectAtIndex:0];
                         self.bookingConfirmedView.backgroundColor = [UIColor clearColor];
                         self.bookingConfirmedView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2+1000);
                         
                         [self.bookingConfirmedView.addCalendarButton addTarget:self
                                                                         action:@selector(dismissView)
                                                               forControlEvents:UIControlEventTouchUpInside];
                         
                         [self.view addSubview:self.bookingConfirmedView];
                         
                                                  
                         
                         [UIView animateWithDuration:0.8 animations:^{
                             self.bookingConfirmedView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
                         }];
                     }];

    
   */
}
-(void)saveAndExit{
    
    /*
    [UIView animateWithDuration:0.8
                     animations:^{
                         
                         self.bookingStartView.center  = CGPointMake(self.bookingStartView.center.x,self.bookingStartView.center.y+1000);
                    
                     }
                     completion:^(BOOL finished){
                         
                         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookingConfirmed" owner:self options:nil];
                         self.bookingConfirmedView = [nib objectAtIndex:0];
                         self.bookingConfirmedView.backgroundColor = [UIColor clearColor];
                         self.bookingConfirmedView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2+1000);
                         
                         [self.bookingConfirmedView.addCalendarButton addTarget:self
                                                                         action:@selector(dismissView)
                                                               forControlEvents:UIControlEventTouchUpInside];
                         
                         [self.view addSubview:self.bookingConfirmedView];
                         
                         DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
                         DOCDoctor *doctor =  sharedInstance.currentSelectedDoctor;
                         
                         [self.bookingConfirmedView.doctorAvatar setImageWithURL:[doctor.doctorAvatars objectForKey:@"medium"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                         
                         self.bookingConfirmedView.doctorNameTag.text = doctor.doctorName;
                         
                         self.bookingConfirmedView.doctorAddress.text = doctor.doctorAddress;
                         
                         DOCDate *tempDate = [doctor.timeSlots objectAtIndex:self.confirmedID];
                         
                         NSDateFormatter * df = [[NSDateFormatter alloc] init];
                         [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
                         [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
                         
                         [df setDateFormat:@"HH:mm"];
                         NSString *theTime = [df stringFromDate:tempDate.myDate];
                         
                         [df setDateFormat:@"yyyy-MM-dd"];
                         NSString *theDate = [df stringFromDate:tempDate.myDate];
                         
                         self.bookingConfirmedView.minuteHour.text = theTime;
                         self.bookingConfirmedView.dateDay.text = theDate;
                         
                         
                         [UIView animateWithDuration:0.8 animations:^{
                                                          self.bookingConfirmedView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
                         }];
     }];
    
    
    
    //[self dismissViewControllerAnimated:YES completion:Nil];
     */
    
}




@end
