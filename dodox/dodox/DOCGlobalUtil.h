//
//  DDXGlobalUtil.h
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DOCGlobalUtil : NSObject


@property (readonly) CLLocationCoordinate2D myCurrentPosotion;

@property (readonly) NSString *currentSelectedSpeciality;

- (NSString *)findMyCurrentLocation;
-(void)alertNoNetwork;
-(BOOL)isNetworkActive;
+(id)getSharedInstance;

-(void)saveSpeciality:(NSString*)speciality;

@end