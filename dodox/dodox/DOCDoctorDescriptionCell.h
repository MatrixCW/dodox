//
//  DOCDoctorDescriptionCell.h
//  docxor
//
//  Created by Enravi on 13/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCDoctorDescriptionCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *languages;

@property (weak, nonatomic) IBOutlet UILabel *practiceName;

@property (weak, nonatomic) IBOutlet UITextView *qualifications;

@property (weak, nonatomic) IBOutlet UITextView *detailedInformation;

@property (weak, nonatomic) IBOutlet UITextView *additionalInformation;


@end
