//
//  DDXSpeciality.h
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDXSpeciality : NSObject

@property (readonly) NSString *specialityName;
@property (readonly) int numberOfDoctors;
@property UIImage *specialityImage;


- (NSComparisonResult)compare:(DDXSpeciality *)otherObject;

@end
