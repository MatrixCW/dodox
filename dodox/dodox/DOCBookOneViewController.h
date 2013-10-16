//
//  DOCBookTimeViewController.h
//  docxor
//
//  Created by Chen Zeyu on 13-9-17.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCBookOneViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *infoTable;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
