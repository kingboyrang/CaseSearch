//
//  RoadDetailViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/7.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircular.h"
#import "basicDetailViewController.h"

@interface RoadDetailViewController : basicDetailViewController

@property (retain, nonatomic) IBOutlet UITableViewCell *cellBulletNO;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellDate;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellStatus;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellHandlerStatus;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellMemo;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCity;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellAddress;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellImages;



@property(nonatomic,retain) VCircular *ItemCircular;
@property(nonatomic,retain) NSString *CircularPWD;

@end
