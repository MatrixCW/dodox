//
//  DOCHistoryViewController.m
//  docxor
//
//  Created by Cui Wei on 10/28/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCHistoryViewController.h"
#import "DOCPreviousBookCell.h"
#import "DOCNextBookCell.h"
#import "AFJSONRequestOperation.h"
#import "DOCBookObject.h"
#import "AFHTTPClient.h"
#import "DOCDoctor.h"
#import "DOCGlobalUtil.h"

@interface DOCHistoryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *dataTable;

@property NSMutableArray *nextBookings;
@property NSMutableArray *previousBookings;

@property NSMutableArray *nextdoctors;
@property NSMutableArray *previousDoctors;

@property int totalBooking;
@end

@implementation DOCHistoryViewController{
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
	// Do any additional setup after loading the view.
    
    
    greyBGColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    self.view.backgroundColor = greyBGColor;
    self.titleLabel.backgroundColor = greyBGColor;
    self.titleLabel.text = @"\nMy Bookings";
    self.dataTable.dataSource = self;
    self.dataTable.delegate = self;
    self.totalBooking = 0;

    [self getDataForBookings];
    
    
    
}


-(void)getDataForBookings{
    
    
    NSDictionary *dict = [self readFromFile];
    NSString *userEmail = [dict valueForKey:@"user_email"];
    NSString *urlString = [NSString stringWithFormat:@"http://doxor.herokuapp.com/api/bookings.json?email=%@",userEmail];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            
                                                                                            for(NSDictionary *dic in JSON){
                                                                                            
                                                                                                
                                                                                                NSArray *timeslot = [dic objectForKey:@"timeslots"];
                                                                                                
                                                                                                
                                                                                                if (timeslot.count != 0){
                                                                                                    
                                                                                                    [self parseTime:[timeslot objectAtIndex:0]];
                                                                                                    
                                                                                                    self.totalBooking++;
                                                                                                    
                                                                                                }
                                                                                                    
                                                                                                
                                                                                                
                                                                                            }
                                                                                            
                                                                                            
                                                                                            NSLog(@"totally: %d", self.totalBooking);
                                                                                            
                                                                                            NSArray *ary = [self.previousBookings sortedArrayUsingComparator:^NSComparisonResult(DOCBookObject *first, DOCBookObject *second) {
                                                                                                return [first compare:second];
                                                                                            }];
                                                                                            
                                                                                            self.previousBookings = [NSMutableArray arrayWithArray:ary];
                                                                                            
                                                                                            NSArray *aryTwo = [self.nextBookings sortedArrayUsingComparator:^NSComparisonResult(DOCBookObject *first, DOCBookObject *second) {
                                                                                                return [first compare:second];
                                                                                            }];
                                                                                            
                                                                                            self.nextBookings = [NSMutableArray arrayWithArray:aryTwo];
                                                                                            
                                                                                            for (DOCBookObject *obj in self.nextBookings){
                                                                                                NSLog(@"next %@",obj.bookDate.myDate);
                                                                                            }
                                                                                            
                                                                                            for (DOCBookObject *obj in self.previousBookings){
                                                                                                NSLog(@"previous %@",obj.bookDate.myDate);
                                                                                            }


                                                                                            
                                                                                            [self getDoctors];
                                                                                            
                                                                                          
                                                                                        }
                                                                                        failure:nil];
    
    
    [operation start];

    
}


-(void)getDoctors{
    
    
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"whatever"]];
    [httpClient.operationQueue setMaxConcurrentOperationCount:1];
    
    for (DOCBookObject *obj in self.nextBookings) {
        
        int doctorID = obj.doctorID;
        
        NSString *requestString = [NSString stringWithFormat:@"http://doxor.herokuapp.com/api/doctors/%d.json",doctorID];
        
        NSURL *requestUrl = [NSURL URLWithString:requestString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                                
                                                                                                DOCDoctor *doc = [self constructDoctorObjectFromDictionary:JSON];
                                                                                                
                                                                                                if(!self.nextdoctors)
                                                                                                    self.nextdoctors = [NSMutableArray array];
                                                                                                
                                                                                                [self.nextdoctors addObject:doc];
                                                                                                
                                                                                                [self getDataFinished];
                                                                                                
                                                                                                
                                                                                                                                                                       }
                                                                                            failure:nil];

        
        [httpClient enqueueHTTPRequestOperation:operation];
    
    
    }
    
    
    AFHTTPClient *httpClientTwo = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"whatever"]];
    [httpClientTwo.operationQueue setMaxConcurrentOperationCount:1];
    
    for (DOCBookObject *obj in self.previousBookings) {
        
        int doctorID = obj.doctorID;
        
        NSString *requestString = [NSString stringWithFormat:@"http://doxor.herokuapp.com/api/doctors/%d.json",doctorID];
        
        NSURL *requestUrl = [NSURL URLWithString:requestString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                                
                                                                                                DOCDoctor *doc = [self constructDoctorObjectFromDictionary:JSON];
                                                                                                
                                                                                                if(!self.previousDoctors)
                                                                                                    self.previousDoctors = [NSMutableArray array];
                                                                                                
                                                                                                [self.previousDoctors addObject:doc];
                                                                                                
                                                                                                [self getDataFinished];
                                                                                                
                                                                                                
                                                                                            }
                                                                                            failure:nil];
        
        
        [httpClientTwo enqueueHTTPRequestOperation:operation];
        
        
    }

    
}


-(void)getDataFinished{
    
    if(self.nextdoctors.count + self.previousDoctors.count == self.totalBooking){
        NSLog(@"finished!");
        
        [self.dataTable reloadData];
    }
    
}

-(DOCDoctor*)constructDoctorObjectFromDictionary:(NSDictionary *)dict{
    
    NSLog(@"dict is %@", dict);
    
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
    
    return doctor;
    
    
    
}


-(void)parseTime:(NSDictionary*)dict{
    
    
    NSString *date = [dict valueForKey:@"slotdate"];
    NSString *time = [dict valueForKey:@"time_slot"];
    NSString *doctorID = [dict valueForKey:@"doctor_id"];
    NSString *slotID = [dict valueForKey:@"id"];
    
        
    int timeID = [time intValue];
    int finalTime = 8 + timeID;
        
    NSString *timeString = [[NSNumber numberWithInt:finalTime] stringValue];
    timeString = [timeString stringByAppendingString:@":00:00"];
        
    NSString *finalDate = [date stringByAppendingString:@" "];
    finalDate = [finalDate stringByAppendingString:timeString];
        
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
        
    NSDate *theDate = [df dateFromString:finalDate];
    
    DOCBookObject *bookObj = [[DOCBookObject alloc] init];
    DOCDate *bookDate = [[DOCDate alloc] init];
    
    bookDate.slotIdentifier = slotID;
    bookDate.myDate = theDate;
    
    bookObj.doctorID = [doctorID intValue];
    bookObj.bookDate = bookDate;
    
    
    if([theDate timeIntervalSinceDate:[self getCurrentDate]] < 0.0){
        
        if(!self.previousBookings)
            self.previousBookings = [NSMutableArray array];
        
        [self.previousBookings addObject:bookObj];
    }else{
        
        if(!self.nextBookings)
            self.nextBookings = [NSMutableArray array];
        
        [self.nextBookings addObject:bookObj];
        
    }
    
    
    
}

-(NSDate*)getCurrentDate{
    
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    return destinationDate;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Next";
            break;
        case 1:
            sectionName = @"Last";
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0)
        return self.nextBookings.count;
    else
        return self.previousBookings.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        DOCNextBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        DOCDoctor *doc = [self.nextdoctors objectAtIndex:indexPath.row];
        DOCBookObject *bookObj = [self.nextBookings objectAtIndex:indexPath.row];
        NSDate *dt = bookObj.bookDate.myDate;
    
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"nextBook" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.doctorNameTag.font = [UIFont fontWithName:@"Avenir Next" size:12];
        cell.doctorNameTag.text = doc.doctorName;
        
        cell.slotTag.font = [UIFont fontWithName:@"Avenir Next" size:13];
        cell.slotTag.textColor = [UIColor colorWithRed:200.0/255 green:58.0/255 blue:24.0/255 alpha:1.0];
        cell.slotTag.text = [NSString stringWithFormat:@"%@ %@",[self extractDayOfWeek:dt],[self extractDate:dt]];

        
        cell.timeTag.font = [UIFont fontWithName:@"Avenir Next" size:20];
        cell.timeTag.text = [self extractTime:dt];

        
        cell.locationTag.font = [UIFont fontWithName:@"Avenir Next" size:17];
        cell.locationTag.textColor = [UIColor colorWithRed:165.0/255 green:169.0/255 blue:171.0/255 alpha:1.0];
        cell.locationTag.text = doc.doctorAddress;

        
        
    
        return cell;
    }
    
    else{
        
        DOCPreviousBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        DOCDoctor *doc = [self.previousDoctors objectAtIndex:indexPath.row];
        DOCBookObject *bookObj = [self.previousBookings objectAtIndex:indexPath.row];
        NSDate *dt = bookObj.bookDate.myDate;
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"previousBook" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.doctorNameTag.font = [UIFont fontWithName:@"Avenir Next" size:12];
        cell.doctorNameTag.text = doc.doctorName;
        
        cell.timeTag.font = [UIFont fontWithName:@"Avenir Next" size:13];
        cell.timeTag.textColor = [UIColor colorWithRed:200.0/255 green:58.0/255 blue:24.0/255 alpha:1.0];
        cell.timeTag.text = [NSString stringWithFormat:@"%@ %@",[self extractDayOfWeek:dt],[self extractDate:dt]];
        
        return cell;

        
    }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    if(indexPath.section == 0){
        sharedInstance.currentSelectedDoctor = [self.nextdoctors objectAtIndex:indexPath.row];
        sharedInstance.currentDate = ((DOCBookObject*)[self.nextBookings objectAtIndex:indexPath.row]).bookDate;
        
        [self performSegueWithIdentifier:@"HISTORY_NEXT_BOOK" sender:self];
     }
    else{
        
        sharedInstance.currentSelectedDoctor = [self.previousDoctors objectAtIndex:indexPath.row];
        sharedInstance.currentDate = ((DOCBookObject*)[self.previousBookings objectAtIndex:indexPath.row]).bookDate;
        
        [self performSegueWithIdentifier:@"HOSTORY_TO_PREVIOUS" sender:self];
        
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section == 0){
        
        return 100;
    }
    
    else{
        
        return 60;
        
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
-(NSDictionary*)readFromFile{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    
    return plistDict;
}

@end
