//
//  DDXDoctor.h
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DOCDoctor : NSObject

@property (readonly) int doctorID;
@property (readonly) NSString *doctorName;
@property (readonly) NSString *doctorSpeciality;
@property (readonly) NSString *doctorAddress;
@property (readonly) CGFloat doctorRate;
@property (readonly) CGFloat distance;
@property (readonly) CLLocationCoordinate2D doctorPosition;
@property (readonly) NSString *doctorPhoneNumber;

@property (readonly) NSDictionary *doctorAvatars;
@property (readonly) NSDictionary *doctorDescription;
@property (readonly) NSArray *doctorPictureURLs;



-(id)initWithIdentity:(int)doctorID
                 Name:(NSString*)doctorName
           speciality:(NSString*)doctorSpeciality
              address:(NSString*)doctorAddress
                 rate:(CGFloat)rate
             position:(CLLocationCoordinate2D) position
                phone:(NSString*) phoneNumber
              avatars:(NSDictionary*)avatarUrls
          description:(NSDictionary*)description
       andPictureURLs:(NSArray*)pictureURLs;


- (NSComparisonResult)compareName:(DOCDoctor *)otherObject;
- (NSComparisonResult)compareRate:(DOCDoctor *)otherObject;
- (NSComparisonResult)compareDistance:(DOCDoctor *)otherObject;


@end