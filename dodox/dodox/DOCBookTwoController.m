//
//  DOCBookTwoController.m
//  docxor
//
//  Created by Cui Wei on 10/16/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCBookTwoController.h"
#import "DOCBookForCell.h"
#import "DOCSimpleDoctorCell.h"
#import "DOCLocationCell.h"
#import "DOCTimeCell.h"
#import "DOCContinueCell.h"

@interface DOCBookTwoController ()

@end

@implementation DOCBookTwoController

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
    
    self.titleLabel.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];;
    
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = @"\nPlease Verify";
    
    self.bookTable.delegate = self;
    self.bookTable.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            height = 82;
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
        
        DOCContinueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"continuecell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"continuecell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSLog(@"3333333333");
        return cell;

        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
