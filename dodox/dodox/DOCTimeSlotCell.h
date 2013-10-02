//
//  DOCTimeSlotCell.h
//  docxor
//
//  Created by Cui Wei on 9/25/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCTimeSlotCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *previousSlots;
@property (weak, nonatomic) IBOutlet UIButton *nextSlots;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;

@property int currentIndex;
@property int totalIndex;

@end
