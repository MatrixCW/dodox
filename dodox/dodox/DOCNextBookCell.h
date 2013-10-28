//
//  DOCBextBookCell.h
//  docxor
//
//  Created by Cui Wei on 10/28/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCNextBookCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *doctorNameTag;
@property (weak, nonatomic) IBOutlet UILabel *slotTag;
@property (weak, nonatomic) IBOutlet UILabel *timeTag;
@property (weak, nonatomic) IBOutlet UILabel *locationTag;

@end
