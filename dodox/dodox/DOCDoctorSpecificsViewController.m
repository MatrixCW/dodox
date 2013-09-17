//
//  DOCDoctorSpecificsViewController.m
//  docxor
//
//  Created by Enravi on 9/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCDoctorSpecificsViewController.h"
#import "DOCConstants.h"
#import "DOCDoctorGeneralInfoCell.h"
#import "DOCDoctorGalleryCell.h"
#import "DOCDoctorLocationCell.h"
#import "DOCDoctorPhoneNumberCell.h"
#import "DOCDoctorDescriptionCell.h"
#import "DOCStartBookCell.h"
#import "DOCTimeSlotPicker.h"

@interface DOCDoctorSpecificsViewController ()


@property UIView *blackView;

@end

@implementation DOCDoctorSpecificsViewController

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
    
    self.doctorInfoTable.delegate = self;
    self.doctorInfoTable.dataSource = self;
    
}




#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return NUMBER_OF_CELLS_IN_DOCTOR_SPECIFICS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = indexPath.row;
    
    if(index == 0){
        
        DOCDoctorGeneralInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorGeneral"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellGeneral" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        return cell;
        
    }
    
    if(index == 1){
        
        DOCDoctorGalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorGallery"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellPhotos" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        return cell;
        
    }

    
    if(index == 2){
        
        DOCDoctorLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorLocation"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellLocation" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        return cell;
        
    }

    
    if(index == 3){
        
        DOCDoctorPhoneNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorPhoneNumber"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellPhone" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        return cell;
        
    }

    
    if(index == 4){
        
        DOCDoctorDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorDescription"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellDescription" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        return cell;
        
    }

    
    assert(index == 5);
    
        
        DOCStartBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookAppointment"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookButtonCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        return cell;
        


}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    int height = 0;
    
    switch (indexPath.row) {
        case 0:
            height = 120;
            break;
        case 1:
            height = 320;
            break;
        case 2:
            height = 50;
            break;
        case 3:
            height = 50;
            break;
        case 4:
            height = 420;
            break;
        case 5:
            height = 60;
            break;
            
        default:
            break;
    }

    return height;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 3){
        
        NSLog(@"phone phone phone");
        
        DOCDoctorPhoneNumberCell *cell = (DOCDoctorPhoneNumberCell*)[self.doctorInfoTable cellForRowAtIndexPath:indexPath];
        
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",cell.doctorPhoneNumber.text];
        
        
        NSLog(@"%@",phoneNumber);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    
    if(indexPath.row == 5){
        
        [self showPicker];
    }

    
}

- (void)showPicker {
    
    self.blackView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.blackView.center = CGPointMake(self.blackView.center.x, self.blackView.center.y+600);
    
    
    self.blackView.backgroundColor = [UIColor whiteColor];
    self.blackView.alpha = 0.90;
    [self.view addSubview:self.blackView];
    
        
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 330, 320, 100)];
    picker.dataSource = self;
    picker.delegate = self;
    [self.blackView addSubview:picker];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 300, 320, 50);
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(cancelPicker)];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:Nil];
    
    [items addObject:cancelButton];
    [items addObject:flexible];

    [items addObject:doneButton];
    [toolbar setItems:items animated:NO];
    [self.blackView addSubview:toolbar];
    
    [UIView animateWithDuration:1.5
                     animations:^{
                         self.blackView.center = CGPointMake(self.blackView.center.x, self.blackView.center.y-600);
                     }];
    
    
        
    
}


-(void)cancelPicker{
    [self.blackView removeFromSuperview];
    self.blackView = Nil;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
    
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component{
    
    return 5;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if(component == 0)
    return @"Oct";
    if(component == 1)
        return @"10th";
    return @"10am";
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSLog(@"haha");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
