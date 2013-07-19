//
//  basicDetailViewController.m
//  CaseSearch
//
//  Created by rang on 13-4-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "basicDetailViewController.h"

@interface basicDetailViewController ()

@end

@implementation basicDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)autolabelSize:(UITableViewCell*)cell withText:(NSString*)txt{
    cell.detailTextLabel.numberOfLines=0;
    cell.detailTextLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.detailTextLabel.textAlignment=NSTextAlignmentLeft;
    cell.detailTextLabel.font=[UIFont systemFontOfSize:17];
    cell.detailTextLabel.textColor=[UIColor colorWithRed:0.25098 green:0.501961 blue:0 alpha:1];
    cell.detailTextLabel.text=txt;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
