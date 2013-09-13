//
//  DOCDoctorSpecificsViewController.h
//  docxor
//
//  Created by Enravi on 9/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCDoctorSpecificsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *doctorTitleBar;

@property (weak, nonatomic) IBOutlet UITableView *doctorInfoTable;


@end
