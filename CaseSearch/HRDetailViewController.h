//
//  HRDetailViewController.h
//  CaseSearch
//
//  Created by rang on 13-4-17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircular.h"
#import "basicDetailViewController.h"
@interface HRDetailViewController:basicDetailViewController


@property (retain, nonatomic) IBOutlet UITableViewCell *cellCase;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellItem;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellDate;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellStatus;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellHandler;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellMemo;

@property (retain, nonatomic) IBOutlet UITextView *txtView;


@property(nonatomic,retain) VCircular *ItemCircular;
@property(nonatomic,retain) NSString *CircularPWD;
@end
