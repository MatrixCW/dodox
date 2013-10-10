//
//  TestViewController.m
//  docxor
//
//  Created by Cui Wei on 10/2/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "TestViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import <EventKit/EventKit.h>

@interface TestViewController ()

@end

@implementation TestViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        // iOS 6 and later
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted){
                //---- codes here when user allow your app to access theirs' calendar.
                [self performCalendarActivity:eventStore];
            }else
            {
                //----- codes here when user NOT allow your app to access the calendar.
            }
        }];
    }
    else {
        //---- codes here for IOS < 6.0.
        [self performCalendarActivity:eventStore];
    }
    
}


-(void)performCalendarActivity:(EKEventStore*)eventStore{
    NSLog(@"hahahahaha");
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    NSDate *date = [[NSDate alloc ]init];//today,s date
    event.title = @"remainder";//title for your remainder
    event.notes = @"see a doctor";
    
    event.location = @"here!";
    event.startDate=date;//start time of your remainder
    event.endDate = [[NSDate alloc] initWithTimeInterval:1800 sinceDate:event.startDate];//end time of your remainder
    
    NSTimeInterval interval = (60 *60)* -3 ;
    EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:interval]; //Create object of alarm
    
    [event addAlarm:alarm]; //Add alarm to your event
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    NSString *ical_event_id;
    //save your event
    if([eventStore saveEvent:event span:EKSpanThisEvent error:&err]){
        ical_event_id = event.eventIdentifier;
        NSLog(@"%@",ical_event_id);
    }

}
@end
