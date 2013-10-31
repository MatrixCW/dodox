//
//  DOCRateCell.h
//  docxor
//
//  Created by Cui Wei on 31/10/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCRateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rateTitle;
@property (weak, nonatomic) IBOutlet UILabel *rateQuestion;
@property (weak, nonatomic) IBOutlet UIImageView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *rateInfo;

@end
