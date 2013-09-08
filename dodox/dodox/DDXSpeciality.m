//
//  DDXSpeciality.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXSpeciality.h"


@interface DDXSpeciality ()

@property (readwrite) NSString *specialityName;
@property (readwrite) int numberOfDoctors;

@end

@implementation DDXSpeciality


-(id)initWithName:(NSString*)specialityName number:(int)numberOfDoctors andImage:(UIImage*)image{
    
    self = [super init];
    if (self) {
        self.specialityName = specialityName;
        self.numberOfDoctors = numberOfDoctors;
        self.specialityImage = image;
    }
    return self;
    
}


- (NSComparisonResult)compare:(DDXSpeciality *)otherObject{
    
    return [self.specialityName compare:otherObject.specialityName];
    
}

@end
