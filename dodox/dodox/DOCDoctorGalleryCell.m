//
//  DOCDoctorGallery.m
//  docxor
//
//  Created by Enravi on 13/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCDoctorGalleryCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@implementation DOCDoctorGalleryCell

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

-(void)setImages:(NSArray*)imageUrls{
    
    if(imageUrls.count == 0){
        
        UIImage* img = [UIImage imageNamed:@"placeholder.jpg"];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
        imgView.center = self.imageGallery.center;
        
        [imgView setImage:img];
        
        [self.imageGallery addSubview:imgView];
        
        return;
        
        
    }
    
    self.imageGallery.scrollEnabled = YES;
    self.imageGallery.pagingEnabled = YES;
    
    CGFloat imageSize = 280;
    CGFloat seperatSpace = 20;
    int totalNumberOfImages = imageUrls.count;
    
    CGFloat currentCenterX = seperatSpace + imageSize/2;
    
    for(int i = 0; i < totalNumberOfImages; i++){
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, imageSize, imageSize)];
        imgView.center = CGPointMake(currentCenterX, imgView.center.y);
        
        currentCenterX = currentCenterX + seperatSpace * 2 + imageSize;
        
        self.imageGallery.frame = CGRectMake(self.imageGallery.frame.origin.x, self.imageGallery.frame.origin.y, self.imageGallery.frame.size.width + imageSize + seperatSpace, self.imageGallery.frame.size.height);
        
        [self.imageGallery addSubview:imgView];
        
        NSURL *url = [NSURL URLWithString:[imageUrls objectAtIndex:i]];
        [imgView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        
        
    }
    
    self.imageGallery.contentSize = CGSizeMake(totalNumberOfImages * (imageSize + seperatSpace * 2), 280);
    
    
}
@end
