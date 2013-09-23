//
//  DOCEnterPIViewController.h
//  docxor
//
//  Created by Cui Wei on 9/23/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol userFinishedEnteringData

-(void)performTaskAfterUserEnteringInfo;

@end


@interface DOCEnterPIViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *deviceIdentifier;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneNumber;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@property (weak) id<userFinishedEnteringData> myDelgate;

@end
