//
//  DDXSpeciality.h
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOCSpeciality : NSObject

@property (readonly) NSString *specialityName;
@property (readonly) int numberOfDoctors;
@property UIImage *specialityImage;


- (NSComparisonResult)compare:(DOCSpeciality *)otherObject;

@end
