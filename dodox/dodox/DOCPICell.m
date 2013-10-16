//
//  DOCPICell.m
//  docxor
//
//  Created by Cui Wei on 10/16/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCPICell.h"

@implementation DOCPICell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setBorderColor{
    
    self.nameField.layer.borderColor=[[UIColor redColor]CGColor];
    self.nameField.layer.borderWidth= 1.0f;
    
    self.phoneField.layer.borderColor=[[UIColor redColor]CGColor];
    self.phoneField.layer.borderWidth= 1.0f;

    
    self.emailField.layer.borderColor=[[UIColor redColor]CGColor];
    self.emailField.layer.borderWidth= 1.0f;

}


-(void)setFont{
    
    self.nameTitle.font = [UIFont fontWithName:@"Avenir Next" size:17];
    self.phoneTitle.font = [UIFont fontWithName:@"Avenir Next" size:17];
    self.emailTitle.font = [UIFont fontWithName:@"Avenir Next" size:17];

    
}
@end
