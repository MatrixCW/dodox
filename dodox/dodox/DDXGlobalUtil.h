//
//  DDXGlobalUtil.h
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DDXGlobalUtil : NSObject

@property (readonly) CLLocationCoordinate2D myCurrentPosotion;

- (NSString *)findMyCurrentLocation;
-(void)alertNoNetwork;
-(BOOL)isNetworkActive;
+(id)getSharedInstance;

@end
