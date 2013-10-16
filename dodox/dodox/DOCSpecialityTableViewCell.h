//
//  DDXCustomizedTableViewCell.h
//  dodox
//
//  Created by Cui Wei on 9/8/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCSpecialityTableViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *speciality;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *numberInfo;


@end
