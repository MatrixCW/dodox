//
//  DDXDoctor.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCDoctor.h"
#import "DOCGlobalUtil.h"
#import "AFJSONRequestOperation.h"
#import "DOCDate.h"

@interface DOCDoctor ()

@end


@implementation DOCDoctor



- (NSComparisonResult)compareName:(DOCDoctor *)otherObject{
    
    return [self.doctorName compare:otherObject.doctorName];
    
}

- (NSComparisonResult)compareRate:(DOCDoctor *)otherObject{
    
    return [[NSNumber numberWithDouble:self.doctorRate] compare:[NSNumber numberWithDouble:otherObject.doctorRate]];
    
}
- (NSComparisonResult)compareDistance:(DOCDoctor *)otherObject{
    
    return [[NSNumber numberWithDouble:self.distance] compare:[NSNumber numberWithDouble:otherObject.distance]];
    
}



-(void)getMyTimeSlots{
    
    NSString *urlPrefix = @"http://doxor.herokuapp.com/api/doctors/%d/timeslots.json";
    
    
    int doctorID = self.doctorID;
    
    NSString *requestUrlString = [NSString stringWithFormat:urlPrefix,doctorID];
    
    NSLog(@"%@", requestUrlString);
    
    NSURL *url = [NSURL URLWithString:requestUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            NSLog(@"dadada%@",JSON);
                                                                                            
                                                                                            if(!self.timeSlots)
                                                                                                self.timeSlots = [NSMutableArray array];
                                                                                            
                                                                                            [self.timeSlots removeAllObjects];
                                                                                            
                                                                                            for(NSDictionary *dict in JSON){
                                                                                                
                                                                                                NSString *bookingID = [dict valueForKey:@"booking_id"];
                                                                                                
                                                                                                //NSLog(@"the id %@",bookingID);
                                                                                                
                                                                                                
                                                                                                
                                                                                                if([bookingID isKindOfClass:[NSNull class]]){
                                                                                                   // NSLog(@"dadadadadad");
                                                                                                    [self.timeSlots addObject:dict];
                                                                                                }
                                                                                                
                                                                                                
                                                                                            }
                                                                                            
                                                                                           // NSLog(@"total %d",self.timeSlots.count);
                                                                                            
                                                                                            [self sortDate];
                                                                                        }
                                                                                        failure:nil];
    [operation start];
    

    
}


-(void)sortDate{
    
    NSMutableArray *ary = [NSMutableArray array];
    
    for(NSDictionary *dict in self.timeSlots){
        
        NSString *date = [dict valueForKey:@"slotdate"];
        NSString *time = [dict valueForKey:@"time_slot"];
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
       // NSLog(@"date string: %@", finalDate);
       // NSLog(@"date: %@", theDate);
        
        DOCDate *dateToAdd = [[DOCDate alloc] init];
        dateToAdd.myDate = theDate;
        dateToAdd.slotID = slotID;
        [ary addObject:dateToAdd];
        
       
        
    }
    
    self.timeSlots = [NSMutableArray arrayWithArray:ary];
    
    NSArray *dataArray = [self.timeSlots sortedArrayUsingComparator:^NSComparisonResult(DOCDate *first, DOCDate *second) {
        return [first.myDate compare:second.myDate];
    }];
    
    self.timeSlots = [NSMutableArray arrayWithArray:dataArray];
    
    NSLog(@"%@", self.timeSlots);
    
    
    
    
}
@end
