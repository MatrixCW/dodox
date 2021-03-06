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
#import "AMBlurView.h"
#import "DOCEnterPIView.h"
#import <QuartzCore/QuartzCore.h>

@interface DOCChooseSpecialityViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITableView *specialityTable;
@property UIView *coverView;
@property NSArray *specialities;
@property NSMutableArray *displayArray;
@property (weak, nonatomic) IBOutlet UILabel *specialityTitle;
- (IBAction)searchButtonPressed:(id)sender;

@property DOCEnterPIView *piView;
@property AMBlurView *blurView;
- (IBAction)historyButtonPressed:(id)sender;
- (IBAction)settingsButtonPressed:(id)sender;

@end

@implementation DOCChooseSpecialityViewController{
    UIColor *greyBGColor;
}

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

    greyBGColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    
    self.specialityTable.backgroundColor = greyBGColor;
    
    self.specialityTitle.numberOfLines = 0;
    self.specialityTitle.text = @"\nSpecialists";
    self.specialityTitle.backgroundColor = greyBGColor;
    
    self.searchField.backgroundColor = [UIColor whiteColor];
    [self.searchField.layer setMasksToBounds:YES];
    [self.searchField.layer setCornerRadius:5.0];
    self.searchField.returnKeyType = UIReturnKeyDone;
    self.searchField.delegate = self;
    
    [self.searchField addTarget:self action:@selector(searchSpecialists) forControlEvents:UIControlEventEditingChanged];

    self.view.backgroundColor = greyBGColor;

    DOCGlobalUtil *sharedUtil = [DOCGlobalUtil getSharedInstance];
    
    
    if(sharedUtil.firstTimeLaunch){
        sharedUtil.firstTimeLaunch = NO;
        [self setCoverImageViewMode:YES];
    }
    
    //[self performSegueWithIdentifier:@"ENTER_PI_FROM_SPECIALITY" sender:Nil];


   [self startMyJob];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)searchSpecialists{
    
    NSLog(@"%d",self.searchField.text.length);
    
    
    if(self.searchField.text.length == 0){
        
        self.displayArray = [NSMutableArray arrayWithArray:self.specialities];
        
        [self.specialityTable reloadData];
        
    }
    
    else{
        
        self.displayArray = [NSMutableArray array];
        
        for(DOCSpeciality *item in self.specialities){
            
            NSString *specialityName = item.specialityName;
            
            if([self string:specialityName containscharsFromString:self.searchField.text])
                
               [self.displayArray addObject: item];
            
        }
        
        [self.specialityTable reloadData];
    }
    
    
}


-(BOOL)string:(NSString*)receiver containscharsFromString:(NSString*)queryString{
    
    NSString *lowerQueryString = [queryString lowercaseString];
    NSString *lowerReceiver = [receiver lowercaseString];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [lowerQueryString length]; i++) {
        [array addObject:[NSString stringWithFormat:@"%C", [lowerQueryString characterAtIndex:i]]];
    }
    
    for(NSString *item in array){
        if ([lowerReceiver rangeOfString:item].location == NSNotFound)
            
            return FALSE;
    }
    
    return true;
    
    
    
}
-(void)performTaskAfterUserEnteringInfo{
    NSLog(@"dadadadad cancelled");

    [self startMyJob];
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
    
    
    if(!sharedUtil.storedSpecialities){
        [self populateSpecialities];
    }
    else
    {
        self.specialities = sharedUtil.storedSpecialities;
        self.displayArray = [NSMutableArray arrayWithArray:self.specialities];
    }
    
    
}


-(void)setCoverImageViewMode:(BOOL)createImgView{
    
    if(createImgView){
        
        
        [self.coverView removeFromSuperview];
        self.coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        int index = arc4random()%2+1;
        int screenSize = IS_IPHONE5?5:4;
        
        NSString *imgName = [NSString stringWithFormat:@"cover%diphone%d.png",index,screenSize];
        UIImage *img = [UIImage imageNamed:imgName];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.coverView.bounds];
        
        [imgView setImage:img];
        
        [self.coverView addSubview:imgView];
        [self.view addSubview:self.coverView];
        
        
    }
    else{
        
        [NSThread sleepForTimeInterval:1.0];
        
        [UIView animateWithDuration:1.0 animations:^{
            
            self.coverView.center = CGPointMake(self.coverView.center.x-320,
                                                self.coverView.center.y);
            self.coverView.alpha = 0.0;
                
        }completion:^(BOOL finished){
            
            [self.coverView removeFromSuperview];
            self.coverView = Nil;
            
        }];
        
        
    }
}

-(void)populateSpecialities{
    
    
    NSURL *url = [NSURL URLWithString:@"http://doxor.herokuapp.com/api/categories.json?lat=1.29135368&lng=103.779730"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            
                                                                                            for(NSDictionary *dic in JSON){
                                                                                                
                                                                                                NSString *specialityID = [dic objectForKey:@"id"];
                                                                                                
                                                                                                NSString *specialityName = [dic objectForKey:@"name"];
                                                                                                
                                                                                                NSString *imageUrl = [dic objectForKey:@"pic"];
                                                                                                
                                                                                                
                                                                                                NSString *numInThree = [dic objectForKey:@"doctors_within_three_km"];
                                                                                                
                                                                                                NSString *numInTen = [dic objectForKey:@"doctors_within_ten_km"];
                                                                                                
                                                                                                DOCSpeciality *tempSpeciality = [[DOCSpeciality alloc] init];
                                                                                                tempSpeciality.specialityID = [specialityID intValue];
                                                                                                tempSpeciality.specialityName = specialityName;
                                                                                                tempSpeciality.specialityImageURL = imageUrl;
                                                                                                tempSpeciality.numInThree = [numInThree intValue];
                                                                                                tempSpeciality.numInTen = [numInTen intValue];
                                                                                                
                                                                                                
                                                                                                [dataArray addObject:tempSpeciality];
                                                                                                
                                                                                            }
                                                                                            
                                                                                            [self formatRetrivedResults:dataArray];
                                                                                        }
                                                                                        failure:nil];
    
    
    [operation start];
    
    
    
    
}



-(void)formatRetrivedResults:(NSMutableArray *)dataArray{
    
    self.specialities = [dataArray sortedArrayUsingComparator:^NSComparisonResult(DOCSpeciality *first, DOCSpeciality *second) {
        return [first compare:second];
    }];
    
    self.displayArray = [NSMutableArray arrayWithArray:self.specialities];
    
    [self.specialityTable reloadData];
    
    
    
    
    DOCGlobalUtil *sharedUtil = [DOCGlobalUtil getSharedInstance];
    
    [sharedUtil storeSpecialities:self.specialities];
    
    [self setCoverImageViewMode:NO];
}



#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DOCSpecialityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMIZED_CELL_IDENTIFIER_FOR_SPECIALITY];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpecialityTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    DOCSpeciality *speciality = (DOCSpeciality*)[self.displayArray objectAtIndex:indexPath.row];
    cell.speciality.text = speciality.specialityName;
    cell.numberInfo.text = [NSString stringWithFormat:@"%d within 3km, %d within 10km", speciality.numInThree,speciality.numInTen];
    
    
    
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:speciality.specialityImageURL]
                            placeholderImage:[UIImage imageNamed:@"specialityHolder.jpg"]
                                   completed:^(UIImage *iamge, NSError *error, SDImageCacheType cachetype){
                                       
                                    }
                 usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    cell.speciality.font = [UIFont fontWithName:@"Avenir Next" size:14];
    cell.speciality.textColor = [UIColor colorWithRed:102.0/255 green:104.0/255 blue:107.0/255 alpha:1.0];
    
    cell.numberInfo.font = [UIFont fontWithName:@"Avenir Next" size:8];
    cell.numberInfo.textColor = [UIColor colorWithRed:102.0/255 green:104.0/255 blue:107.0/255 alpha:1.0];
    
    [cell.thumbnailImageView.layer setMasksToBounds:YES];
    [cell.thumbnailImageView.layer setCornerRadius:cell.thumbnailImageView.frame.size.width/2];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    
    DOCSpeciality *selectedSpeciality = [self.displayArray objectAtIndex:indexPath.row];
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

-(void)cancelInput{
    
    NSLog(@"dsfsdfdsg");
    
}


-(void)writeToPlist:(NSDictionary*)dict{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    [dict writeToFile:plistLocation atomically:YES];
    
    
}

-(NSDictionary*)readFromFile{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    NSLog(@"%@", plistDict);

    return plistDict;
}

- (IBAction)historyButtonPressed:(id)sender {
    
}

- (IBAction)settingsButtonPressed:(id)sender {
    
    
    
    NSLog(@"asjbajk6db");
    self.blurView = [AMBlurView new];
    [self.blurView setFrame:CGRectMake(30,1000,300.0f,500.0f)];
    self.blurView.center = CGPointMake(self.view.bounds.size.width/2, 1500);
    //self.blurView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    
    [self.view addSubview:self.blurView];
    
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"editPI" owner:self options:nil];
    self.piView = [nib objectAtIndex:0];
    self.piView.backgroundColor = [UIColor clearColor];
    self.piView.center = CGPointMake(self.view.bounds.size.width/2, 1500);
    
    [self.piView setUpView];
    [self.view addSubview:self.piView];
    self.piView.myDelegate = self;
    
    NSDictionary *dict = [self readFromFile];
    
    if(dict){
        
        NSString *uuid = [dict objectForKey:@"uid"];
        NSString *userName = [dict objectForKey:@"name"];
        NSString *phone = [dict objectForKey:@"phone"];
        
        self.piView.userEmailField.text = uuid;
        self.piView.userNameField.text = userName;
        self.piView.userPhoneField.text = phone;
        
        if([self.piView.userEmailField.text isEqualToString:@""] || self.piView.userEmailField.text == Nil)
            self.piView.userEmailField.text = [DOCEnterPIView calculateUniqueIdentifier];
    }
    
    if([self.piView.userEmailField.text isEqualToString:@""] || self.piView.userEmailField.text == Nil)
        self.piView.userEmailField.text = [DOCEnterPIView calculateUniqueIdentifier];
    
        
    [UIView animateWithDuration:0.5 animations:^{
        
        self.blurView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);

        self.piView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);

    }];
}


-(void)doneButtonPressed:(NSDictionary *)dict{
    NSLog(@"hahahahahahaha %@", dict);
    [self writeToPlist:dict];
    [self removePIView];
    [self readFromFile];
}
-(void)removePIView{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.piView.center = CGPointMake(self.piView.center.x, self.piView.center.x+700);
        self.blurView.center = CGPointMake(self.blurView.center.x, self.blurView.center.x+700);
    }completion:^(BOOL finished){
        [self.piView removeFromSuperview];
        self.piView = Nil;
        [self.blurView removeFromSuperview];
        self.blurView = Nil;
    }];
}

-(void)viewNeedMoveUp:(CGFloat)delta{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        self.piView.center = CGPointMake(self.piView.center.x, self.piView.center.y+delta);
        
    }];
    
    
}
- (IBAction)searchButtonPressed:(id)sender {
    
    [self.searchField becomeFirstResponder];
}

@end
