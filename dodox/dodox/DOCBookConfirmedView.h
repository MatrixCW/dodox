//
//  DOCBookConfirmedView.h
//  docxor
//
//  Created by Cui Wei on 9/27/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCBookConfirmedView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *doctorAvatar;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameTag;
@property (weak, nonatomic) IBOutlet UILabel *doctorAddress;
@property (weak, nonatomic) IBOutlet UILabel *minuteHour;
@property (weak, nonatomic) IBOutlet UILabel *dateDay;
@property (weak, nonatomic) IBOutlet UIButton *addCalendarButton;

@end
