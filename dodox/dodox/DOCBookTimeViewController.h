//
//  DOCBookTimeViewController.h
//  docxor
//
//  Created by Chen Zeyu on 13-9-17.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCBookTimeViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextView *symptonField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameTag;
@property (strong, nonatomic) IBOutlet UILabel *textViewPlaceHolder;

@end
