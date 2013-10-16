//
//  DOCLocationCell.h
//  docxor
//
//  Created by Cui Wei on 10/16/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationTag;
@property (weak, nonatomic) IBOutlet UILabel *clinicName;
@property (weak, nonatomic) IBOutlet UILabel *addressTag;
@property (weak, nonatomic) IBOutlet UILabel *postCodeTag;

@end
