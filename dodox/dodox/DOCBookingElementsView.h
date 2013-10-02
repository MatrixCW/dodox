//
//  DOCBookingElementsView.h
//  docxor
//
//  Created by Cui Wei on 9/26/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCBookingElementsView : UIView

@property (weak, nonatomic) IBOutlet UILabel *bookingTitle;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameTag;
@property (weak, nonatomic) IBOutlet UIImageView *doctorAvator;
@property (weak, nonatomic) IBOutlet UILabel *doctoraAddress;
@property (weak, nonatomic) IBOutlet UILabel *timeMinute;
@property (weak, nonatomic) IBOutlet UILabel *dateTag;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property int currentIndex;

@end
