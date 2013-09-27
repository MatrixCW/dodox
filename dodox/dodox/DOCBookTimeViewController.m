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
#import "DOCBookConfirmedView.h"
@interface DOCBookTimeViewController ()

@property DOCBookingElementsView *bookingStartView;
@property DOCBookConfirmedView *bookingConfirmedView;

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
    self.bookingStartView = [nib objectAtIndex:0];
    self.bookingStartView.backgroundColor = [UIColor clearColor];
    self.bookingStartView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    self.bookingStartView.confirmButton.backgroundColor = [UIColor colorWithRed:68.0/255 green:149.0/255 blue:85.0/255 alpha:1.0];
    
    self.bookingStartView.confirmButton.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bookingStartView];
    
    
    [self.bookingStartView.cancelButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bookingStartView.confirmButton addTarget:self action:@selector(saveAndExit) forControlEvents:UIControlEventTouchUpInside];

    
}

-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

-(void)saveAndExit{
    
    
    [UIView animateWithDuration:0.8
                     animations:^{
                         
                         self.bookingStartView.center  = CGPointMake(self.bookingStartView.center.x,self.bookingStartView.center.y+1000);
                    
                     }
                     completion:^(BOOL finished){
                         
                         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookingConfirmed" owner:self options:nil];
                         self.bookingConfirmedView = [nib objectAtIndex:0];
                         self.bookingConfirmedView.backgroundColor = [UIColor clearColor];
                         self.bookingConfirmedView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2+1000);
                         
                         [self.bookingConfirmedView.addCalendarButton addTarget:self
                                                                         action:@selector(dismissView)
                                                               forControlEvents:UIControlEventTouchUpInside];
                         
                         [self.view addSubview:self.bookingConfirmedView];
                         
                         [UIView animateWithDuration:0.8 animations:^{
                             
                             self.bookingConfirmedView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
                         }];
     }];
    
    
    
    //[self dismissViewControllerAnimated:YES completion:Nil];
    
}




@end
