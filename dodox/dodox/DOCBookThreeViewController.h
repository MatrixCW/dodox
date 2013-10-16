//
//  DOCBookThreeViewController.h
//  docxor
//
//  Created by Cui Wei on 10/16/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCBookThreeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;
@property (weak, nonatomic) IBOutlet UITableView *confirmTable;

@end
