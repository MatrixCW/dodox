//
//  DOCViewHistoryViewController.m
//  docxor
//
//  Created by Cui Wei on 10/5/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCViewHistoryViewController.h"
#import "DOCBookingHistoryCell.h"

@interface DOCViewHistoryViewController ()

@end

@implementation DOCViewHistoryViewController

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
    
    self.bookingHistoryTabel.delegate = self;
    self.bookingHistoryTabel.dataSource = self;
    
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255 green:240.0/255 blue:243.0/255 alpha:1.0];
    self.bookingHistoryTabel.backgroundColor = [UIColor colorWithRed:236.0/255 green:240.0/255 blue:243.0/255 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DOCBookingHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BOOKING_HISTORY"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ViewBookingHistory" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
        return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
@end
