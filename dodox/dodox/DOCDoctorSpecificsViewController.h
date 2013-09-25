//
//  DOCDoctorSpecificsViewController.h
//  docxor
//
//  Created by Enravi on 9/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCDoctorSpecificsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *doctorTitleLabel;

@property (weak, nonatomic) IBOutlet UITableView *doctorInfoTable;


@end
