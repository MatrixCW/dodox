//
//  DOCCommentCell.h
//  docxor
//
//  Created by Cui Wei on 31/10/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentTitle;
@property (weak, nonatomic) IBOutlet UITextView *commentContent;

@end
