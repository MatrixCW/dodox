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



-(void)parseTime{
    
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
    
    
    
}
@end
