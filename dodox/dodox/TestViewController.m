//
//  TestViewController.m
//  docxor
//
//  Created by Cui Wei on 10/2/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "TestViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface TestViewController ()

@end

@implementation TestViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    NSMutableDictionary *booking = [[NSMutableDictionary alloc] init];
    
    
    NSMutableArray *myArray = [NSMutableArray array];
    
    [myArray addObject:@"1"];
    
    NSArray *myary = [NSArray arrayWithArray:myArray];

    [booking setValue:@"1" forKey:@"doctor_id"];
    [booking setValue:@"12345678" forKey:@"patient_phone"];
    [booking setValue:@"I am fucked" forKey:@"symptoms"];
    [booking setValue:myary forKey:@"timeslots"];
    
    NSLog(@"%@",booking);
    
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://doxor.herokuapp.com/"]];
    
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient postPath:@"api/bookings.json" parameters:booking success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"SUCCEEDED!");
        NSLog(@"Response: %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}
@end
