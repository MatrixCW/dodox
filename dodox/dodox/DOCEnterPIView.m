//
//  DOCEnterPIView.m
//  docxor
//
//  Created by Cui Wei on 9/24/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCEnterPIView.h"


@interface DOCEnterPIView ()

@property BOOL viewHasMovedUp;


@end


@implementation DOCEnterPIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)doneButtonPressed:(id)sender {
    
    [self.myDelegate removePIView];
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self.myDelegate removePIView];
}


-(void)setUpView{
    self.userNameField.returnKeyType = UIReturnKeyDone;
    self.userPhoneField.returnKeyType = UIReturnKeyDone;
    self.userNameField.delegate = self;
    self.userPhoneField.delegate = self;
    self.deviceIDField.text = [self calculateUniqueIdentifier];
    self.deviceIDField.userInteractionEnabled = NO;
}

-(NSString*)calculateUniqueIdentifier{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL,uuidRef));
    CFRelease(uuidRef);
    NSLog(@"%@",uuidString);
    return uuidString;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self animateTextField:textField up:NO];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"fuck you!");
    
    [self animateTextField:textField up:YES];
    
}


-(void)textViewDidEndEditing:(UITextField *)textfield{
    
    NSLog(@"fuck you end!");
    [self animateTextField:textfield up:NO];
    
}


- (void) animateTextField: (UITextField*) textView up: (BOOL) up
{
    
    if(self.viewHasMovedUp && up){
        
        return;
        
    }
    
    if(!up){
        self.viewHasMovedUp = NO;
    }
    
    if(up){
        self.viewHasMovedUp = YES;
    }
    
    const int movementDistance = 120; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);

    [self.myDelegate viewNeedMoveUp:movement];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
