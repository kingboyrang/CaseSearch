//
//  BusinessAreaViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/13.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "BasicTableViewController.h"
@interface BusinessAreaViewController : BasicTableViewController<UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITableViewCell *cellEqIdentifier;

@property(nonatomic,retain) UITextField *txtUser;
@property(nonatomic,retain) UITextField *txtPWD;
- (IBAction)buttonSyncClick:(id)sender;
@end
