//
//  DDXChooseSpecialityViewController.m
//  dodox
//
//  Created by Cui Wei on 9/8/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCChooseSpecialityViewController.h"
#import "DOCSpecialityTableViewCell.h"
#import "DOCConstants.h"
#import "DOCGlobalUtil.h"
#import "DOCSpeciality.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "Reachability.h"

@interface DOCChooseSpecialityViewController ()

@property (weak, nonatomic) IBOutlet UITableView *specialityTable;
@property UIView *coverView;
@property NSArray *specialities;

@end

@implementation DOCChooseSpecialityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.


    
    NSLog(@"coming!!");
    
    DOCGlobalUtil *sharedUtil = [DOCGlobalUtil getSharedInstance];
    
    
    if(sharedUtil.firstTimeLaunch){
        sharedUtil.firstTimeLaunch = NO;
        [self setCoverImageViewMode:YES];
    }
    
    [self performSegueWithIdentifier:@"ENTER_PI_FROM_SPECIALITY" sender:Nil];


    
}


-(void)performTaskAfterUserEnteringInfo{
    NSLog(@"dadadadad cancelled");

    [self startMyJob];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"ENTER_PI_FROM_SPECIALITY"]){
        DOCEnterPIViewController *vc = (DOCEnterPIViewController*)segue.destinationViewController;
        vc.myDelgate = self;
    }
}
-(void)startMyJob{
    
    DOCGlobalUtil *sharedUtil = [DOCGlobalUtil getSharedInstance];

    
    if([sharedUtil isNetworkActive]){
        
        //NSLog(@"%@",[sharedUtil findMyCurrentLocation]);
        
    }
    else{
        
        [sharedUtil alertNoNetwork];
        
    }
    
    
    self.specialityTable.dataSource = self;
    self.specialityTable.delegate = self;
    
    if(sharedUtil.firstTimeLaunch){
        sharedUtil.firstTimeLaunch = NO;
        [self setCoverImageViewMode:YES];
    }
    
    NSLog(@"s;dvdfvnfjdnjdf %d", sharedUtil.storedSpecialities.count);
    
    if(!sharedUtil.storedSpecialities){
        NSLog(@"i am here");
        [self populateSpecialities];
    }
    else
    {
        self.specialities = sharedUtil.storedSpecialities;
    }
    
    
}


-(void)setCoverImageViewMode:(BOOL)createImgView{
    
    if(createImgView){
        
        
        NSLog(@"%f %f", self.view.bounds.size.width, self.view.bounds.size.height);
        [self.coverView removeFromSuperview];
        self.coverView = Nil;
        self.coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.coverView.backgroundColor = [UIColor whiteColor];
        self.coverView.alpha = 1.0;
        
        UIImage *img = [UIImage imageNamed:@"doctor.jpg"];
        CGFloat imgWidth = img.size.width;
        CGFloat imgHeight = img.size.height;
        
        CGFloat referenceWidth = self.view.bounds.size.width;
        
        if(IS_IPHONE5)
            referenceWidth *=1.03;
        
        CGFloat correspondingHeight = imgHeight/imgWidth*referenceWidth;
        
        if(IS_IPHONE5)
            correspondingHeight *=1.1;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:
                                CGRectMake(0, 0, referenceWidth, correspondingHeight)];
        
        [imgView setImage:img];
        imgView.center = CGPointMake(self.coverView.bounds.size.width/2,
                                     self.coverView.bounds.size.height-correspondingHeight/2);
        
        [self.coverView addSubview:imgView];
        
        UILabel *title = [[UILabel alloc] init];
        [title setFrame:CGRectMake(0,0,320,100)];
        title.backgroundColor=[UIColor clearColor];
        title.textColor=[UIColor blackColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.numberOfLines = 0;
        title.text= @"Doxor\n\nEasy appointment, like never before";
        
        CGFloat adjustment;
        
        if(IS_IPHONE5)
            adjustment = 50;
        else
            adjustment = 35;
        title.center = CGPointMake(self.coverView.bounds.size.width/2,
                                   (imgView.center.y - correspondingHeight/2 -adjustment));
            
        
        [self.coverView addSubview:title];
        
        [self.view addSubview:self.coverView];
        
        
    }
    else{
        
        [NSThread sleepForTimeInterval:3];
        
            [UIView animateWithDuration:0.6 animations:^{
            
            self.coverView.center = CGPointMake(self.coverView.center.x-300,
                                                self.coverView.center.y);
            
        }completion:^(BOOL finished){
            
            [self.coverView removeFromSuperview];
            self.coverView = Nil;
            
        }];
        
        
    }
}

-(void)populateSpecialities{
    
    NSURL *url = [NSURL URLWithString:@"http://doxor.herokuapp.com/api/categories.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            NSLog(@"ddddsdfsdfsdf");
                                                                                            
                                                                                            for(NSDictionary *dic in JSON){
                                                                                                
                                                                                                NSString *specialityID = [dic objectForKey:@"id"];
                                                                                                
                                                                                                NSString *specialityName = [dic objectForKey:@"name"];
                                                                                                
                                                                                                NSString *imageUrl = [dic objectForKey:@"pic"];
                                                                                                
                                                                                                                                                                                                NSString *numberOfDoctors = [dic objectForKey:@"number_of_doctors"];
                                                                                                
                                                                                                DOCSpeciality *tempSpeciality = [[DOCSpeciality alloc] initWithName:specialityName
                                                                                                                                                           identity:[specialityID intValue]
                                                                                                                                                             number:[numberOfDoctors intValue]
                                                                                                                                                        andImageURL:imageUrl];
                                                                                                
                                                                                        [dataArray addObject:tempSpeciality];
                                                                                                
                                                                                            }
                                                                                            
                                                                                            [self formarRetrivedResults:dataArray];
                                                                                        }
                                                                                        failure:nil];
    [operation start];
    
    
    
    
}


-(void)setCategoryImage{
    
}
-(void)formarRetrivedResults:(NSMutableArray *)dataArray{
    
    self.specialities = [dataArray sortedArrayUsingComparator:^NSComparisonResult(DOCSpeciality *first, DOCSpeciality *second) {
        return [first compare:second];
    }];
    
    [self.specialityTable reloadData];
    
    NSLog(@"I am done!!");
    
    
    
    DOCGlobalUtil *sharedUtil = [DOCGlobalUtil getSharedInstance];
    
    [sharedUtil storeSpecialities:self.specialities];
    
    [self setCoverImageViewMode:NO];
}



#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.specialities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DOCSpecialityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMIZED_CELL_IDENTIFIER_FOR_SPECIALITY];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpecialityTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    DOCSpeciality *speciality = (DOCSpeciality*)[self.specialities objectAtIndex:indexPath.row];
    cell.speciality.text = speciality.specialityName;
    cell.numberOfSpecialists.text = [NSString stringWithFormat:@"Number of doctors: %d", speciality.numberOfDoctors];
    
    [cell.speciality sizeToFit];
    [cell.numberOfSpecialists sizeToFit];
    
    
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:speciality.specialityImageURL]
                            placeholderImage:[UIImage imageNamed:@"specialityHolder.jpg"]
                                   completed:^(UIImage *iamge, NSError *error, SDImageCacheType cachetype){
                                       
                                       NSLog(@"loading image");
                                    }
                 usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    

    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    DOCSpeciality *selectedSpeciality = [self.specialities objectAtIndex:indexPath.row];
     sharedInstance.currentSelectedSpeciality = selectedSpeciality.specialityName;
     sharedInstance.currentSelectedSpecialityID = selectedSpeciality.specialityID;
    
    [self performSegueWithIdentifier:SEGUE_FROM_SPECIALITY_TO_CHOOSE_DOCTOR sender:Nil];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewDidDisappear:(BOOL)animated{
    
}
@end
