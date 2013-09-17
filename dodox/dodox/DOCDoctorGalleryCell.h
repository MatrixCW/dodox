//
//  DOCDoctorGallery.h
//  docxor
//
//  Created by Enravi on 13/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCDoctorGalleryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *imageGallery;


-(void)setImages:(NSArray*)imageUrls;

@end
