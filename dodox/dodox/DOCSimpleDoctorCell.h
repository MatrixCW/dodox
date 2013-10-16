//
//  DOCSimpleDoctorCell.h
//  docxor
//
//  Created by Cui Wei on 10/16/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCSimpleDoctorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *doctorAvatar;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;

@property (weak, nonatomic) IBOutlet UILabel *doctorCategory;
@property (weak, nonatomic) IBOutlet UILabel *subCategory;

@property (weak, nonatomic) IBOutlet UILabel *clinicName;


@end
