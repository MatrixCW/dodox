//
//  DDXChooseSpecialityViewController.m
//  dodox
//
//  Created by Cui Wei on 9/8/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXChooseSpecialityViewController.h"
#import "DDXCustomizedTableViewCell.h"
#import "DDXConstants.h"

@interface DDXChooseSpecialityViewController ()

@property (weak, nonatomic) IBOutlet UITableView *specialityTable;

@property NSMutableArray *specialities;

@end

@implementation DDXChooseSpecialityViewController

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
    
    self.specialities = [NSMutableArray array];
    
    [self populateSpecialities];
    
    self.specialityTable.dataSource = self;
    self.specialityTable.delegate = self;

}


-(void)populateSpecialities{
    
    [self.specialities addObject:@"Aesthetic Medine Doctor"];
    [self.specialities addObject:@"Cancer Specialist"];
    [self.specialities addObject:@"Cardiologist"];
    [self.specialities addObject:@"Cardiothoracic Surgeon"];
    [self.specialities addObject:@"Chiropractor"];
    [self.specialities addObject:@"Counsellor/Psychologist"];
    

   

}

#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.specialities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DDXCustomizedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMIZED_CELL_IDENTIFIER];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpecialityTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.speciality.text = [self.specialities objectAtIndex:indexPath.row];
    cell.numberOfSpecialists.text = [NSString stringWithFormat:@"Number of doctors: %@", @"99"];
    
    [cell.speciality sizeToFit];
    [cell.numberOfSpecialists sizeToFit];
    
    cell.thumbnailImageView.image = [UIImage imageNamed:@"dental.jpg"];

    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
