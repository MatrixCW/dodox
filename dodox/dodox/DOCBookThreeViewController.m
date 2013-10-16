//
//  DOCBookThreeViewController.m
//  docxor
//
//  Created by Cui Wei on 10/16/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCBookThreeViewController.h"
#import "DOCBookForCell.h"
#import "DOCSimpleDoctorCell.h"
#import "DOCLocationCell.h"
#import "DOCTimeCell.h"
#import "DOCAddCalCell.h"

@interface DOCBookThreeViewController ()

@end

@implementation DOCBookThreeViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];;
    
    self.confirmLabel.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];;
    
    self.confirmLabel.numberOfLines = 0;
    self.confirmLabel.text = @"\nDr. Simon Chua";
    
    self.confirmTable.delegate = self;
    self.confirmTable.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int height = 0;
    
    switch (indexPath.row) {
        case 0:
            height = 80;
            break;
        case 1:
            height = 111;
            break;
        case 2:
            height = 110;
            break;
        case 3:
            height = 100;
            break;
        case 4:
            height = 128;
            break;
        default:
            break;
    }
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = indexPath.row;
    
    if(index == 0){
        
        DOCBookForCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookfor"];
        
        if (cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"bookfor" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSLog(@"0");
        return cell;
        
    }
    else if(index == 1){
        
        DOCSimpleDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpledoctor"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"simpledoctor" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSLog(@"1");
        return cell;
        
        
    }
    else if(index == 2){
        
        DOCLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationcell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"locationcell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        
        NSLog(@"2");
        return cell;
        
        
    }
    else if(index == 3){
        
        DOCTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ddddd"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"booktwotimeslot" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSLog(@"3333333333");
        return cell;
        
        
    }
    else{
        
        DOCAddCalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"addCalCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSLog(@"3333333333");
        return cell;
        
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
