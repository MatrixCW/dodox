//
//  DDXDoctorTableViewCell.h
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSFlatButton.h"

@interface DOCDoctorTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *doctorName;
@property (nonatomic, weak) IBOutlet UILabel *doctorAddress;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@property (weak, nonatomic) IBOutlet JSFlatButton *bookButton;

- (IBAction)bookButtonPressed:(id)sender;

@end
