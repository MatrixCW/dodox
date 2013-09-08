//
//  DDXChooseSpecialityViewController.m
//  dodox
//
//  Created by Cui Wei on 9/8/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXChooseSpecialityViewController.h"
#import "DDXSpecialityTableViewCell.h"
#import "DDXConstants.h"
#import "DDXGlobalUtil.h"

@interface DDXChooseSpecialityViewController ()

@property (weak, nonatomic) IBOutlet UITableView *specialityTable;

@property NSArray *specialities;
@property NSMutableArray *specialityImages;

@end

@implementation DDXChooseSpecialityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self.specialityTable setContentInset:UIEdgeInsetsMake(0, 0, 85, 0)];
    
    [self populateSpecialities];
    [self addSpecialityImages];
    
    self.specialityTable.dataSource = self;
    self.specialityTable.delegate = self;

}


-(void)populateSpecialities{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [dataArray addObject:@"Dentist"];
    [dataArray addObject:@"Aesthetic Medine Doctor"];
    [dataArray addObject:@"Cancer Specialist"];
    [dataArray addObject:@"Cardiologist"];
    [dataArray addObject:@"Cardiothoracic Surgeon"];
    [dataArray addObject:@"Chiropractor"];
    [dataArray addObject:@"Psychologist"];
    
    self.specialities = [dataArray sortedArrayUsingComparator:^NSComparisonResult(NSString *first, NSString *second) {
        return [first compare:second];
    }];
}


-(void)addSpecialityImages{
    
    if(self.specialityImages == NULL ){
        self.specialityImages = [NSMutableArray array];
    }
    
    [self.specialityImages removeAllObjects];
    
    [self.specialityImages addObject:[UIImage imageNamed:@"aesthetic medicine doctor.jpg"]];
    [self.specialityImages addObject:[UIImage imageNamed:@"cancer specialist.jpg"]];
    [self.specialityImages addObject:[UIImage imageNamed:@"cardiologist.jpg"]];
    [self.specialityImages addObject:[UIImage imageNamed:@"cardiothoracic surgeon.jpg"]];
    [self.specialityImages addObject:[UIImage imageNamed:@"chiropracter.jpg"]];
    [self.specialityImages addObject:[UIImage imageNamed:@"dentist.jpg"]];
    [self.specialityImages addObject:[UIImage imageNamed:@"psychologist.jpg"]];
    
    for(UIImage *img in self.specialityImages){
        assert(img != NULL);
    }

    
}


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
    
    DDXSpecialityTableViewCell *cell = (DDXSpecialityTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    [[DDXGlobalUtil getSharedInstance] saveSpeciality:cell.speciality.text];
    
    [self performSegueWithIdentifier:SEGUE_FROM_SPECIALITY_TO_CHOOSE_DOCTOR sender:Nil];
    
}

-(void)go{
    
    [self performSegueWithIdentifier:SEGUE_FROM_SPECIALITY_TO_CHOOSE_DOCTOR sender:Nil];
    
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
