//
//  DOCTimeSlotPicker.h
//  docxor
//
//  Created by Enravi on 16/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCTimeSlotPicker : UIView


- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *timeSlots;

@end
