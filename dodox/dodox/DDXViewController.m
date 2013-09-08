//
//  DDXViewController.m
//  dodox
//
//  Created by Cui Wei on 9/8/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXViewController.h"
#import "DDXGlobalUtil.h"

@interface DDXViewController ()

@end

@implementation DDXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    DDXGlobalUtil *sharedUtil = [DDXGlobalUtil getSharedInstance];
    
    if([sharedUtil isNetworkActive]){
    
        NSLog(@"%@",[sharedUtil findMyCurrentLocation]);
    //[self performSelector:@selector(goToNextSceneWithIdentifier:)
      //         withObject:SEGUE_FROM_START_TO_CHOOSE_SPECIAL
        //       afterDelay:1.5];
    }
    else{
        
        [sharedUtil alertNoNetwork];
        
    }
    

}


-(void)goToNextSceneWithIdentifier:(NSString *)identifier{
    
    [self performSegueWithIdentifier:identifier sender:self];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
