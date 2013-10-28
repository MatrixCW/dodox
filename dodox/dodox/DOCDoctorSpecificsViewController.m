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
#import "DOCGlobalUtil.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "DOCTimeSlotCell.h"
#import "DOCDate.h"
#import "DYRateView.h"

@interface DOCDoctorSpecificsViewController ()

@property DOCDoctor *currentDoctor;

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
    
    self.currentDoctor = sharedInstance.currentSelectedDoctor;
    
    self.doctorTitleLabel.numberOfLines = 0;
    self.doctorTitleLabel.text = @"\nAvailability";
    
    sharedInstance.currentDate = [self.currentDoctor.timeSlots objectAtIndex:0];
   
    /*
    self.doctorTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.doctorTitleLabel.numberOfLines = 0;
    self.doctorTitleLabel.backgroundColor = [UIColor whiteColor];
    
    NSRange stringLocation =[sharedInstance.currentSelectedDoctor.doctorName rangeOfString:@"Dr"];
    
    self.doctorInfoTable.separatorColor = [UIColor clearColor];
    if(stringLocation.location == NSNotFound)
        self.doctorTitleLabel.text = [NSString stringWithFormat:@"\nDr %@", sharedInstance.currentSelectedDoctor.doctorName];
    
    else
        self.doctorTitleLabel.text = [NSString stringWithFormat:@"\n%@", sharedInstance.currentSelectedDoctor.doctorName];
     */
    
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    
    self.doctorInfoTable.backgroundColor = self.view.backgroundColor;
    
    
}




#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
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
            
            UIImage *fullStar = [UIImage imageNamed:@"star_gold_half.png"];
            //fullStar = [self resizeImage:fullStar to:CGSizeMake(fullStar.size.width/2.0, fullStar.size.width/2.0)];
            UIImage *emptyStar = [UIImage imageNamed:@"star_none_half.png"];
            //emptyStar = [self resizeImage:emptyStar to:CGSizeMake(emptyStar.size.width/2.0, emptyStar.size.width/2.0)];
            
            DYRateView *rateView = [[DYRateView alloc] initWithFrame:cell.rateView.bounds fullStar:fullStar emptyStar:emptyStar];
            rateView.rate = currentDoctor.doctorRate;
            rateView.alignment = RateViewAlignmentCenter;
            [cell.rateView addSubview:rateView];
            
            cell.doctorName.font = [UIFont fontWithName:@"Avenir Next" size:20];
            cell.doctorName.textColor = [UIColor blackColor];
            cell.doctorName.text = currentDoctor.doctorName;
            
            cell.doctorCategpry.font = [UIFont fontWithName:@"Avenir Next" size:14];
            cell.doctorCategpry.textColor = [UIColor redColor];
            cell.doctorCategpry.text = currentDoctor.doctorSpeciality;
            
            cell.doctorSubCategory.font = [UIFont fontWithName:@"Avenir Next" size:10];
            cell.doctorSubCategory.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
            cell.doctorSubCategory.text = currentDoctor.subCategory;

            
            cell.doctorClinicName.font = [UIFont fontWithName:@"Avenir Next" size:9];
            cell.doctorClinicName.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
            cell.doctorClinicName.text = currentDoctor.clinicName;

            
            cell.doctorLocation.font = [UIFont fontWithName:@"Avenir Next" size:10];
            cell.doctorLocation.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
            cell.doctorLocation.text = currentDoctor.doctorAddress;




            
            /*
            NSURL *avatarThumbnail = [NSURL URLWithString:[currentDoctor.doctorAvatars objectForKey:@"original"]];
            
            [cell.doctorAvatar setImageWithURL:avatarThumbnail usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            
            cell.doctorName.text = currentDoctor.doctorSpeciality;
            
            [cell.doctorAvatar.layer setMasksToBounds:YES];
            [cell.doctorAvatar.layer setCornerRadius:8.0];
             */
            [cell.doctorAvatar.layer setMasksToBounds:YES];
            [cell.doctorAvatar.layer setCornerRadius:cell.doctorAvatar.bounds.size.width/2];
            
            NSString *imgUrlString = [currentDoctor.doctorAvatars valueForKey:@"original"];
            [cell.doctorAvatar setImageWithURL:[NSURL URLWithString:imgUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
        }
        
        return cell;
        
    }
    
    if(index == 1){
        
        
        DOCTimeSlotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeSlots"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AvailableSlots" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.slotPicker.delegate = self;
            cell.slotPicker.dataSource = self;
            /*
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
             */
            

        
        

            
        }
        
        return cell;
    }
    
    if(index == 2){
        
        
        DOCStartBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookAppointment"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookButtonCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            [cell.bookButton addTarget:self action:@selector(startBooking) forControlEvents:UIControlEventTouchUpInside];
            
            
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


/*
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
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    int height = 0;
    
    switch (indexPath.row) {
        case 0:
            height = 140;
            break;
        case 1:
            height = 275;
            break;
        case 2:
            height = 60;
            break;
        //case 3:
           // height = 320;
           // break;
        //case 3:
         //   height = 50;
          //  break;
        //case 4:
          //  height = 50;
            //break;
       // case 5:
          //  height = 630;
          //  break;

            
        default:
            break;
    }

    return height;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if(indexPath.row == 2){
        
        [self startBooking];
    }

    
}


-(void)startBooking{
    [self performSegueWithIdentifier:@"BOOK_DOCTOR_SEGUE" sender:self];
}

        



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component{
    
    return self.currentDoctor.timeSlots.count;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    DOCDate *date = [self.currentDoctor.timeSlots objectAtIndex: row];
    NSDate *myDate = date.myDate;
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSString *theDateString = [df stringFromDate:myDate];
    
    return theDateString;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        
        tView.font = [UIFont fontWithName:@"Arial" size:15];
        
        tView.textAlignment = NSTextAlignmentCenter;
    }
    
    DOCDate *date = [self.currentDoctor.timeSlots objectAtIndex: row];
    NSDate *myDate = date.myDate;
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSString *theDateString = [df stringFromDate:myDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSArray *daysOfWeek = @[@"",@"Sun",@"Mon",@"Tue",@"Wed",@"Thur",@"Fri",@"Sat"];
	[dateFormatter setDateFormat:@"e"];
	NSInteger weekdayNumber = (NSInteger)[[dateFormatter stringFromDate:myDate] integerValue];
	NSString *dayOfWeek = [daysOfWeek objectAtIndex:weekdayNumber];
    
    tView.text = [NSString stringWithFormat:@"%@   %@",theDateString,dayOfWeek];
    
    return tView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSLog(@"haha %d",row);
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    sharedInstance.currentDate = [self.currentDoctor.timeSlots objectAtIndex:row];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
