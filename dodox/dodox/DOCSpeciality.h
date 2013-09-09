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
@property (readonly) int specialityID;
@property (readonly) int numberOfDoctors;
@property (readonly) NSString *specialityImageURL;

@property UIImage *specialityImage;


-(id)initWithName:(NSString*)specialityName identity:(int)specialityID number:(int)numberOfDoctors andImageURL:(NSString*)url;
- (NSComparisonResult)compare:(DOCSpeciality *)otherObject;

@end
