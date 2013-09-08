//
//  DDXSelectDoctorViewController.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXSelectDoctorViewController.h"
#import "DDXDoctorTableViewCell.h"
#import "DDXConstants.h"

@interface DDXSelectDoctorViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingChoice;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITableView *doctorTable;
@property NSMutableArray *doctors;
@property NSMutableArray *doctorAvatars;

@end

@implementation DDXSelectDoctorViewController

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
    [self.sortingChoice addTarget:self
                         action:@selector(pickOne:)
               forControlEvents:UIControlEventValueChanged];
}

-(void) pickOne:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
}

/*
#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.specialities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DDXSpecialityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMIZED_CELL_IDENTIFIER_FOR_SPECIALITY];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpecialityTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.speciality.text = [self.specialities objectAtIndex:indexPath.row];
    cell.numberOfSpecialists.text = [NSString stringWithFormat:@"Number of doctors: %@", @"99"];
    
    [cell.speciality sizeToFit];
    [cell.numberOfSpecialists sizeToFit];
    
    cell.thumbnailImageView.image = [self.specialityImages objectAtIndex:indexPath.row];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
