//
//  DOCBookObject.m
//  docxor
//
//  Created by Cui Wei on 10/30/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCBookObject.h"

@implementation DOCBookObject


- (NSComparisonResult)compare:(DOCBookObject *)otherObject{
    
    return [self.bookDate.myDate compare:otherObject.bookDate.myDate];
    
}

@end
