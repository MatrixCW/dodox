//
//  DOCViewPreviousBooksViewController.m
//  docxor
//
//  Created by Cui Wei on 31/10/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCViewPreviousBooksViewController.h"
#import "DOCBookForCell.h"
#import "DOCSimpleDoctorCell.h"
#import "DOCRateCell.h"
#import "DOCCommentCell.h"
#import "DOCRateButtonCell.h"
#import "DOCGlobalUtil.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "DYRateView.h"

@interface DOCViewPreviousBooksViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rateTitle;
@property (weak, nonatomic) IBOutlet UITableView *rateTable;
@property NSString *userName;
@property NSString *userPhone;
@property NSString *userEmail;

@end

@implementation DOCViewPreviousBooksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];;
    
    self.rateTitle.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];;
    
    self.rateTitle.numberOfLines = 0;
    
    self.rateTitle.text = [NSString stringWithFormat:@"\nPlease Rate"];
    
    self.rateTable.delegate = self;
    self.rateTable.dataSource = self;
    
    NSDictionary *dict = [self readFromFile];
    self.userName = [dict valueForKey:@"user_name"];
    self.userPhone = [dict valueForKey:@"user_phone"];
    self.userEmail = [dict valueForKey:@"user_email"];

}

-(NSDictionary*)readFromFile{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    NSLog(@"%@", plistDict);
    
    return plistDict;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = indexPath.row;
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    DOCDoctor *currentDoc = sharedInstance.currentSelectedDoctor;    
    
    
    if(index == 0){
        
        DOCBookForCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookfor"];
        
        if (cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"bookfor" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            cell.bookNameTitle.text = self.userName;
            cell.confirmLabel.textColor = [UIColor redColor];
            cell.confirmLabel.backgroundColor = [UIColor yellowColor];
        }
        
        return cell;
        
    }
    else if(index == 1){
        
        DOCSimpleDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpledoctor"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"simpledoctor" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"simpledoctor" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        cell.doctorName.font = [UIFont fontWithName:@"Avenir Next" size:20];
        cell.doctorName.textColor = [UIColor blackColor];
        cell.doctorName.text = currentDoc.doctorName;
        
        cell.doctorCategory.font = [UIFont fontWithName:@"Avenir Next" size:14];
        cell.doctorCategory.textColor = [UIColor redColor];
        cell.doctorCategory.text = currentDoc.doctorSpeciality;
        
        cell.subCategory.font = [UIFont fontWithName:@"Avenir Next" size:10];
        cell.subCategory.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
        cell.subCategory.text = currentDoc.subCategory;
        
        cell.clinicName.font = [UIFont fontWithName:@"Avenir Next" size:9];
        cell.clinicName.textColor = [UIColor colorWithRed:113.0/255 green:115.0/255 blue:117.0/255 alpha:1.0];
        cell.clinicName.text = currentDoc.clinicName;
        
        
        [cell.doctorAvatar.layer setMasksToBounds:YES];
        [cell.doctorAvatar.layer setCornerRadius:cell.doctorAvatar.bounds.size.width/2];
        
        NSString *imgUrlString = [currentDoc.doctorAvatars valueForKey:@"original"];
        [cell.doctorAvatar setImageWithURL:[NSURL URLWithString:imgUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        
        return cell;
        
        
    }
    else if(index == 2){
        
        DOCRateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rateDoctor"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"rateDoctor" owner:self options:nil];
            cell = [nib objectAtIndex:0];

            
        }
        
        
        UIImage *fullStar = [UIImage imageNamed:@"star_gold_half.png"];
        //fullStar = [self resizeImage:fullStar to:CGSizeMake(fullStar.size.width/2.0, fullStar.size.width/2.0)];
        UIImage *emptyStar = [UIImage imageNamed:@"star_none_half.png"];
        //emptyStar = [self resizeImage:emptyStar to:CGSizeMake(emptyStar.size.width/2.0, emptyStar.size.width/2.0)];
        
        DYRateView *rateView = [[DYRateView alloc] initWithFrame:cell.rateView.bounds fullStar:fullStar emptyStar:emptyStar];
        rateView.editable = YES;
        rateView.alignment = RateViewAlignmentCenter;
        [cell.rateView addSubview:rateView];
        
        
        
        return cell;
        
        
    }
    else if(index == 3){
        
        DOCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ddddd"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"commentDoctor" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            
        }
        
        cell.commentContent.layer.borderWidth = 0.8f;
       
        cell.commentContent.layer.borderColor = [[UIColor redColor] CGColor];
        cell.commentContent.delegate = self;
        cell.commentContent.returnKeyType = UIReturnKeyDone;
        return cell;
        
        
    }
    else{
        
        DOCRateButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"rateButton" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
           
        }
        
        return cell;
        
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int height = 0;
    
    switch (indexPath.row) {
        case 0:
            height = 80;
            break;
        case 1:
            height = 111;
            break;
        case 2:
            height = 109;
            break;
        case 3:
            height = 120;
            break;
        case 4:
            height = 44;
            break;
        default:
            break;
    }
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
       
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.rateTable.center = CGPointMake(self.rateTable.center.x, self.rateTable.center.y-250);
        
    }];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.rateTable.center = CGPointMake(self.rateTable.center.x, self.rateTable.center.y+250);
        
    }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
