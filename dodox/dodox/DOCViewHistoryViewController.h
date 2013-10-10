//
//  DOCViewHistoryViewController.h
//  docxor
//
//  Created by Cui Wei on 10/5/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCViewHistoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *bookingHistoryTabel;

@end
