//
//  DOCEnterPIView.m
//  docxor
//
//  Created by Cui Wei on 9/24/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCEnterPIView.h"

@implementation DOCEnterPIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)doneButtonPressed:(id)sender {
    
    [self.myDelegate removePIView];
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self.myDelegate removePIView];
}

-(NSString*)calculateUniqueIdentifier{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL,uuidRef));
    CFRelease(uuidRef);
    NSLog(@"%@",uuidString);
    return uuidString;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
