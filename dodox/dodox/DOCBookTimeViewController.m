//
//  DOCBookTimeViewController.m
//  docxor
//
//  Created by Chen Zeyu on 13-9-17.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import "DOCBookTimeViewController.h"
#import "DOCGlobalUtil.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "SVProgressHUD.h"
#import "DOCBookingElementsView.h"
#import "DOCBookConfirmedView.h"
#import "DOCGlobalUtil.h"
#import "DOCDoctor.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AFJSONRequestOperation.h"
#import "DOCDate.h"

@interface DOCBookTimeViewController ()

@property DOCBookingElementsView *bookingStartView;
@property DOCBookConfirmedView *bookingConfirmedView;
@property int confirmedID;


@end

@implementation DOCBookTimeViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255 green:240.0/255 blue:243.0/255 alpha:1.0];
	// Do any additional setup after loading the view.
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *doctor =  sharedInstance.currentSelectedDoctor;
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookElements" owner:self options:nil];
    self.bookingStartView = [nib objectAtIndex:0];
    self.bookingStartView.backgroundColor = [UIColor clearColor];
    self.bookingStartView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    self.bookingStartView.confirmButton.backgroundColor = [UIColor colorWithRed:68.0/255 green:149.0/255 blue:85.0/255 alpha:1.0];
    
    self.bookingStartView.confirmButton.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bookingStartView];
    
    
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
    

    
}


-(void)previousSlot{
    
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
    
}


-(void)nextSlot{
    
    
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

    
}

-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:Nil];
}


-(void)makeABook{
    
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
    

    
    
}
-(void)saveAndExit{
    
    
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
    
}




@end
