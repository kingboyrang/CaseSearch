//
//  TaxDetailViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/7.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircular.h"
#import "basicDetailViewController.h"
@interface TaxDetailViewController : basicDetailViewController

@property (retain, nonatomic) IBOutlet UITableViewCell *cellBulletNO;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellDate;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellStatus;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellHandleStatus;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellCity;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellLocation;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellMatter;

@property(nonatomic,retain) VCircular *ItemCircular;
@property(nonatomic,retain) NSString *CircularPWD;
@end
