//
//  SystemUserViewController.h
//  CaseSearch
//
//  Created by aJia on 12/11/27.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemUserViewController : UITableViewController<UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UITextField *txtName;
@property (retain, nonatomic) IBOutlet UITextField *txtTel;
@property (retain, nonatomic) IBOutlet UITextField *txtEmail;
@property (retain, nonatomic) IBOutlet UITextField *txtNick;

-(BOOL)validateEmail:(NSString *)email;
- (IBAction)editFieldExit:(id)sender;
- (IBAction)buttonSubmit:(id)sender;
@end
