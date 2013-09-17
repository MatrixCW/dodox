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

@interface DOCChooseSpecialityViewController ()

@property (weak, nonatomic) IBOutlet UITableView *specialityTable;

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

    //[self.specialityTable setContentInset:UIEdgeInsetsMake(0, 0, 85, 0)];
    
    [self populateSpecialities];
    
    self.specialityTable.dataSource = self;
    self.specialityTable.delegate = self;
    
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
                 usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
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
