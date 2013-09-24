//
//  DOCEnterPIView.h
//  docxor
//
//  Created by Cui Wei on 9/24/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EnterPIProtocol

-(void)removePIView;

@end

@interface DOCEnterPIView : UIView
@property (weak, nonatomic) IBOutlet UITextField *deviceIDField;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneField;
@property (weak) id<EnterPIProtocol> myDelegate;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

-(NSString*)calculateUniqueIdentifier;
@end
