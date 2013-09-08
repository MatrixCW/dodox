//
//  DDXViewController.m
//  dodox
//
//  Created by Cui Wei on 9/8/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXViewController.h"

@interface DDXViewController ()

@end

@implementation DDXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self performSelector:@selector(goToNextSceneWithIdentifier:)
               withObject:SEGUE_FROM_START_TO_CHOOSE_SPECIAL
               afterDelay:3.0];
    

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
