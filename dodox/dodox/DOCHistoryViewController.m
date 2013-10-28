//
//  DOCHistoryViewController.m
//  docxor
//
//  Created by Cui Wei on 10/28/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCHistoryViewController.h"
#import "DOCPreviousBookCell.h"
#import "DOCNextBookCell.h"

@interface DOCHistoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *dataTable;

@end

@implementation DOCHistoryViewController{
    UIColor *greyBGColor;
}

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
    
    
    greyBGColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    self.view.backgroundColor = greyBGColor;
    self.titleLabel.backgroundColor = greyBGColor;
    self.titleLabel.text = @"\nMy Bookings";
    self.dataTable.dataSource = self;
    self.dataTable.delegate = self;

    [self readFromFile];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Next";
            break;
        case 1:
            sectionName = @"Last";
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0)
        return 1;
    else
        return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        DOCNextBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"nextBook" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.doctorNameTag.font = [UIFont fontWithName:@"Avenir Next" size:12];
        
        cell.slotTag.font = [UIFont fontWithName:@"Avenir Next" size:13];
        cell.slotTag.textColor = [UIColor colorWithRed:200.0/255 green:58.0/255 blue:24.0/255 alpha:1.0];

        
        cell.timeTag.font = [UIFont fontWithName:@"Avenir Next" size:20];

        
        cell.locationTag.font = [UIFont fontWithName:@"Avenir Next" size:17];
        cell.locationTag.textColor = [UIColor colorWithRed:165.0/255 green:169.0/255 blue:171.0/255 alpha:1.0];

        
        
    
        return cell;
    }
    
    else{
        
        DOCPreviousBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"previousBook" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.doctorNameTag.font = [UIFont fontWithName:@"Avenir Next" size:12];
        cell.timeTag.font = [UIFont fontWithName:@"Avenir Next" size:15];
        cell.timeTag.textColor = [UIColor colorWithRed:200.0/255 green:58.0/255 blue:24.0/255 alpha:1.0];

        
        return cell;

        
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section == 0){
        
        return 100;
    }
    
    else{
        
        return 60;
        
    }
    
    
}
-(NSDictionary*)readFromFile{
    
    NSLog(@"hhhdddfdf");

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"myplist.plist"];
    
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLocation];
    NSLog(@"%@", plistDict);
    
    return plistDict;
}

@end
