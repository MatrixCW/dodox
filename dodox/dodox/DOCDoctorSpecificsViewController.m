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
#import "DOCGlobalUtil.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "DOCTimeSlotCell.h"
#import "DOCDate.h"

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
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    self.doctorTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.doctorTitleLabel.numberOfLines = 0;
    self.doctorTitleLabel.backgroundColor = [UIColor whiteColor];
    
    NSRange stringLocation =[sharedInstance.currentSelectedDoctor.doctorName rangeOfString:@"Dr"];
    
    self.doctorInfoTable.separatorColor = [UIColor clearColor];
    if(stringLocation.location == NSNotFound)
        self.doctorTitleLabel.text = [NSString stringWithFormat:@"\nDr %@", sharedInstance.currentSelectedDoctor.doctorName];
    
    else
        self.doctorTitleLabel.text = [NSString stringWithFormat:@"\n%@", sharedInstance.currentSelectedDoctor.doctorName];
    
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255 green:240.0/255 blue:243.0/255 alpha:1.0];
    
    self.doctorInfoTable.backgroundColor = self.view.backgroundColor;
    
    
}




#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoctor = sharedInstance.currentSelectedDoctor;
    
    int index = indexPath.row;
    
    if(index == 0){
        
        DOCDoctorGeneralInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorGeneral"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellGeneral" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            NSURL *avatarThumbnail = [NSURL URLWithString:[currentDoctor.doctorAvatars objectForKey:@"original"]];
            
            [cell.doctorAvatar setImageWithURL:avatarThumbnail usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            
            cell.doctorCategory.text = currentDoctor.doctorSpeciality;
            
            [cell.doctorAvatar.layer setMasksToBounds:YES];
            [cell.doctorAvatar.layer setCornerRadius:8.0];
        }
        
        return cell;
        
    }
    
    if(index == 1){
        
        
        DOCTimeSlotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeSlots"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AvailableSlots" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            [cell.previousSlots addTarget:self action:@selector(previousTimeSlot:) forControlEvents:UIControlEventTouchUpInside];
            [cell.nextSlots addTarget:self action:@selector(nextTimeSlot:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.currentIndex = 0;
            
            if(currentDoctor.timeSlots.count % 4 == 0)
                cell.totalIndex =currentDoctor.timeSlots.count/4-1;
            else
                cell.totalIndex = currentDoctor.timeSlots.count/4;
            
            NSMutableArray *ary = [NSMutableArray array];
            [ary addObject:cell.labelOne];
            [ary addObject:cell.labelTwo];
            [ary addObject:cell.labelThree];
            [ary addObject:cell.labelFour];
            
            for(int i = 0; i <= 3; i++){
                
                UILabel *tempLabel = [ary objectAtIndex:i];
                tempLabel.hidden = NO;
                
            }
            
            int startIndex = 0;
            int endIndex = startIndex + 3;
            
            if(endIndex > (currentDoctor.timeSlots.count -1))
                endIndex = (currentDoctor.timeSlots.count -1);
            
            NSDateFormatter * df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
            
            
            for(int i=startIndex;i<=endIndex;i++){
                
                int markDownIndex = i - startIndex;
                
                UILabel *tempLabel = [ary objectAtIndex:markDownIndex];
                DOCDate *tempDate = (DOCDate*)[currentDoctor.timeSlots objectAtIndex:i];
                tempLabel.text = [df stringFromDate:tempDate.myDate];
                
                
            }
            
            if(endIndex - startIndex < 3){
                
                int totalNumOfDate = endIndex - startIndex + 1;
                int left = 4 - totalNumOfDate;
                
                for(int j = 3; j > (3-left); j--){
                    
                    UILabel *tempLabel = [ary objectAtIndex:j];
                    tempLabel.hidden = YES;
                    
                }
                
            }
            

        
        

            
        }
        
        return cell;
    }
    
    if(index == 2){
        
        
        DOCStartBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookAppointment"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookButtonCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            
            
        }
        
        return cell;
    }
    
    /*
    if(index == 3){
        
        DOCDoctorGalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorGallery"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellPhotos" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            [cell setImages:currentDoctor.doctorPictureURLs];

        }
        
        
        return cell;
        
    }
     */

    
    if(index == 3){
        
        DOCDoctorLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorLocation"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellLocation" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            cell.address.numberOfLines = 0;
            cell.address.text = currentDoctor.doctorAddress;
        }
        
        return cell;
        
    }

    
    if(index == 4){
        
        DOCDoctorPhoneNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorPhoneNumber"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellPhone" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            cell.doctorPhoneNumber.numberOfLines = 0;
            cell.doctorPhoneNumber.text = currentDoctor.doctorPhoneNumber;
        }
        
        return cell;
        
    }

    
    assert(index == 5);
        
        DOCDoctorDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorDescription"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DoctorSpecificsTableViewCellDescription" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            
            NSDictionary *dict = currentDoctor.doctorDescription;
            NSArray *languages = [dict objectForKey:@"spoken_language"];
            NSString *clinicName = [dict objectForKey:@"clinic_name"];
            NSString *doctorDetailedInfo = [dict objectForKey:@"desc"];
            NSString *doctorQualification = [dict objectForKey:@"qualification"];
            NSString *additionalInfo = [dict objectForKey:@"add"];
            
            cell.languages.text = [languages componentsJoinedByString: @", "];
            cell.practiceName.text = clinicName;
            cell.qualifications.text = doctorQualification;
            cell.detailedInformation.text = doctorDetailedInfo;
            cell.additionalInformation.text = additionalInfo;
        }
        
        return cell;
        
}

-(void)previousTimeSlot:(UIButton*)button{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    DOCTimeSlotCell *cell = (DOCTimeSlotCell*)[self.doctorInfoTable cellForRowAtIndexPath:indexPath];
    
    NSLog(@"%d",cell.currentIndex);
    
    if(cell.currentIndex == 0)
        return;
    
    NSMutableArray *ary = [NSMutableArray array];
    [ary addObject:cell.labelOne];
    [ary addObject:cell.labelTwo];
    [ary addObject:cell.labelThree];
    [ary addObject:cell.labelFour];
    
    for(int i = 0; i <= 3; i++){
        
        UILabel *tempLabel = [ary objectAtIndex:i];
        tempLabel.hidden = NO;
        
    }
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoctor = sharedInstance.currentSelectedDoctor;
    
    cell.currentIndex --;
    
    int startIndex = cell.currentIndex * 4;
    int endIndex = startIndex + 3;
    
    if(endIndex > (currentDoctor.timeSlots.count -1))
        endIndex = (currentDoctor.timeSlots.count -1);
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];

    
    for(int i=startIndex;i<=endIndex;i++){
        
        int markDownIndex = i - startIndex;
        
        UILabel *tempLabel = [ary objectAtIndex:markDownIndex];
        DOCDate *tempDate = (DOCDate*)[currentDoctor.timeSlots objectAtIndex:i];
        tempLabel.text = [df stringFromDate:tempDate.myDate];
        
        
    }
    
    if(endIndex - startIndex < 3){
        
        int totalNumOfDate = endIndex - startIndex + 1;
        int left = 4 - totalNumOfDate;
        
        for(int j = 3; j > (3-left); j--){
            
            UILabel *tempLabel = [ary objectAtIndex:j];
            tempLabel.hidden = YES;
            
        }
    }
    
    NSLog(@"previous!");
    
}

-(void)nextTimeSlot:(UIButton*)button{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    DOCTimeSlotCell *cell = (DOCTimeSlotCell*)[self.doctorInfoTable cellForRowAtIndexPath:indexPath];
    
    NSLog(@"%d",cell.currentIndex);
    
    if(cell.currentIndex == cell.totalIndex)
        return;
    
    NSMutableArray *ary = [NSMutableArray array];
    [ary addObject:cell.labelOne];
    [ary addObject:cell.labelTwo];
    [ary addObject:cell.labelThree];
    [ary addObject:cell.labelFour];
    
    for(int i = 0; i <= 3; i++){
        
        UILabel *tempLabel = [ary objectAtIndex:i];
        tempLabel.hidden = NO;
        
    }
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoctor = sharedInstance.currentSelectedDoctor;
    
    cell.currentIndex ++;
    
    int startIndex = cell.currentIndex * 4;
    int endIndex = startIndex + 3;
    
    if(endIndex > (currentDoctor.timeSlots.count -1))
        endIndex = (currentDoctor.timeSlots.count -1);
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    
    for(int i=startIndex;i<=endIndex;i++){
        
        int markDownIndex = i - startIndex;
        
        UILabel *tempLabel = [ary objectAtIndex:markDownIndex];
        DOCDate *tempDate = (DOCDate*)[currentDoctor.timeSlots objectAtIndex:i];
        tempLabel.text = [df stringFromDate:tempDate.myDate];
        
        
    }
    
    if(endIndex - startIndex < 3){
        
        int totalNumOfDate = endIndex - startIndex + 1;
        int left = 4 - totalNumOfDate;
        
        for(int j = 3; j > (3-left); j--){
            
            UILabel *tempLabel = [ary objectAtIndex:j];
            tempLabel.hidden = YES;
            
        }
    }
    
    NSLog(@"next!");


    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    int height = 0;
    
    switch (indexPath.row) {
        case 0:
            height = 120;
            break;
        case 1:
            height = 140;
            break;
        case 2:
            height = 60;
            break;
        //case 3:
           // height = 320;
           // break;
        case 3:
            height = 50;
            break;
        case 4:
            height = 50;
            break;
        case 5:
            height = 630;
            break;

            
        default:
            break;
    }

    return height;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 4){
        
        NSLog(@"phone phone phone");
        
        DOCDoctorPhoneNumberCell *cell = (DOCDoctorPhoneNumberCell*)[self.doctorInfoTable cellForRowAtIndexPath:indexPath];
        
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",cell.doctorPhoneNumber.text];
        
        
        NSLog(@"%@",phoneNumber);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    
    if(indexPath.row == 2){
        
        [self performSegueWithIdentifier:@"BOOK_DOCTOR_SEGUE" sender:self];
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
