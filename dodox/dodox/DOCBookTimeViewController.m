//
//  DOCBookTimeViewController.m
//  docxor
//
//  Created by Chen Zeyu on 13-9-17.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import "DOCBookTimeViewController.h"
#import "DOCGlobalUtil.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "SVProgressHUD.h"
#import "DOCBookingElementsView.h"

@interface DOCBookTimeViewController ()

@end

@implementation DOCBookTimeViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255 green:240.0/255 blue:243.0/255 alpha:1.0];
	// Do any additional setup after loading the view.
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookElements" owner:self options:nil];
    DOCBookingElementsView *piView = [nib objectAtIndex:0];
    piView.backgroundColor = [UIColor clearColor];
    piView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    piView.confirmButton.backgroundColor = [UIColor colorWithRed:68.0/255 green:149.0/255 blue:85.0/255 alpha:1.0];
    
    piView.confirmButton.tintColor = [UIColor whiteColor];
    //[self.piView setUpView];
    
    [self.view addSubview:piView];
    
    self.phoneNumberField.delegate = self;
    self.symptonField.delegate = self;
    
    self.phoneNumberField.returnKeyType = UIReturnKeyDone;
    self.symptonField.returnKeyType = UIReturnKeyDone;
    
    [self.phoneNumberField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    self.doctorNameTag.text = [NSString stringWithFormat:@"Dr %@", sharedInstance.currentSelectedDoctor.doctorName];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    
    if(![self checkPhoneNumber]){
        
        UILabel *warningLabel = [[UILabel alloc] initWithFrame:self.phoneNumberField.bounds];
        warningLabel.text = @"Invalid phone number";
        warningLabel.textColor = [UIColor redColor];
        warningLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.phoneNumberField addSubview:warningLabel];
        return;
        
    }
        
        
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    NSString *doctorID = [[NSNumber numberWithInt:sharedInstance.currentSelectedDoctor.doctorID] stringValue];
    
    NSString *symptons;
    NSArray* words = [self.symptonField.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString:@""];
    
    if([nospacestring isEqualToString:@""]){
        symptons = @"The patient did not enter any information";
    }
    else{
        symptons = self.symptonField.text;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:doctorID forKey:@"doctor_id"];
    [dic setObject:self.phoneNumberField.text forKey:@"patient_phone"];
    [dic setObject:@"1,3,4444,5" forKey:@"slots"];
    [dic setObject:self.symptonField.text forKey:@"symptoms"];
    
    NSMutableDictionary *bk = [NSMutableDictionary dictionary];
    [bk setObject:dic forKey:@"booking"];
   
    NSURL *requestUrl = [NSURL URLWithString:@"http://doxor.herokuapp.com/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:requestUrl];
    [httpClient postPath:@"/api/bookings.json"
              parameters:bk
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     NSLog(@"Response: %@", text);
                     
                     [SVProgressHUD showSuccessWithStatus:@"Booking succeeded!"];
                     
                     
                     [self dismissViewControllerAnimated:YES completion:Nil];
                     
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     
                     NSLog(@"%@", operation.request.URL);
                     NSLog(@"ccdscds %@", [error localizedDescription]);
                 }];
 
              
}



-(BOOL)checkPhoneNumber{
    
    NSArray* words = [self.phoneNumberField.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString:@""];
    
    if([nospacestring isEqualToString:@""]){
        return FALSE;
    }
    else
        return TRUE;
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSArray *array = textField.subviews;
    
    for(UIView *view in array){
        if([view isKindOfClass:[UILabel class]])
            [view removeFromSuperview];
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self animateTextField:textView up:YES];
    
    self.textViewPlaceHolder.hidden = YES;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    
    [self animateTextField:textView up:NO];
    
    NSArray* words = [textView.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString:@""];
    
    if([nospacestring isEqualToString:@""]){
        self.textViewPlaceHolder.hidden = NO;
    }
}


- (void) animateTextField: (UITextView*) textField up: (BOOL) up
{
    const int movementDistance = 100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
