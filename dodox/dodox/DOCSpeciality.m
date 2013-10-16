//
//  DDXSpeciality.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCSpeciality.h"


@interface DOCSpeciality ()

@end

@implementation DOCSpeciality


- (NSComparisonResult)compare:(DOCSpeciality *)otherObject{
    
    return [self.specialityName compare:otherObject.specialityName];
    
}

@end
