//
//  DDXSpeciality.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCSpeciality.h"


@interface DOCSpeciality ()

@property (readwrite) NSString *specialityName;
@property (readwrite) int numberOfDoctors;
@property (readwrite) int specialityID;
@property (readwrite) NSString *specialityImageURL;


@end

@implementation DOCSpeciality


-(id)initWithName:(NSString*)specialityName identity:(int)specialityID number:(int)numberOfDoctors andImageURL:(NSString*)url{
    
    self = [super init];
    if (self) {
        self.specialityName = specialityName;
        self.specialityID = specialityID;
        self.numberOfDoctors = numberOfDoctors;
        self.specialityImageURL = url;
    }
    return self;
    
}


- (NSComparisonResult)compare:(DOCSpeciality *)otherObject{
    
    return [self.specialityName compare:otherObject.specialityName];
    
}

@end
