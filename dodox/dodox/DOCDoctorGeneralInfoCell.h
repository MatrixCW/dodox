//
//  DOCDoctorGeneralInfoCell.h
//  docxor
//
//  Created by Enravi on 13/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCDoctorGeneralInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *doctorAvatar;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *doctorCategpry;
@property (weak, nonatomic) IBOutlet UILabel *doctorSubCategory;
@property (weak, nonatomic) IBOutlet UILabel *doctorClinicName;

@property (weak, nonatomic) IBOutlet UILabel *doctorLocation;
@property (weak, nonatomic) IBOutlet UIView *rateView;

@end
