//
//  DDXSpeciality.h
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOCSpeciality : NSObject

@property NSString *specialityName;
@property int specialityID;
@property int numInThree;
@property int numInTen;

@property NSString *specialityImageURL;

@property UIImage *specialityImage;



- (NSComparisonResult)compare:(DOCSpeciality *)otherObject;

@end
