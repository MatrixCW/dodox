//
//  DOCEnterPIViewController.m
//  docxor
//
//  Created by Cui Wei on 9/23/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCEnterPIViewController.h"

@interface DOCEnterPIViewController ()

@property BOOL viewHasMovedUp;
@end

@implementation DOCEnterPIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.userName.returnKeyType = UIReturnKeyDone;
    self.userPhoneNumber.returnKeyType = UIReturnKeyDone;
    self.userName.delegate = self;
    self.userPhoneNumber.delegate = self;
    self.deviceIdentifier.text = [self calculateUniqueIdentifier];
    self.deviceIdentifier.textAlignment = NSTextAlignmentCenter;
}


-(NSString*)calculateUniqueIdentifier{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL,uuidRef));
    CFRelease(uuidRef);
    NSLog(@"%@",uuidString);
    return uuidString;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    NSLog(@"cancelled");
    [self.myDelgate performTaskAfterUserEnteringInfo];

    [self dismissViewControllerAnimated:YES completion:Nil];
    
}

- (IBAction)doneButtonPressed:(id)sender{
    
    [self.myDelgate performTaskAfterUserEnteringInfo];
    
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
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UITextField beginAnimations: @"anim" context: nil];
    [UITextField setAnimationBeginsFromCurrentState: YES];
    [UITextField setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
