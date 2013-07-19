//
//  HRViewController.h
//  CaseSearch
//
//  Created by rang on 13-4-15.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUISelect.h"
#import "HRBirthView.h"
#import "HRMarryView.h"
#import "HRDieView.h"
#import "ServiceHelper.h"
#import "BasicTableViewController.h"
@interface HRViewController : BasicTableViewController<ServiceHelperDelegate,CVUISelectDelegate>{
    int orginItem;
}
@property (retain, nonatomic) IBOutlet UITableViewCell *cellItem;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellBirth;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellMarry;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellDie;

@property(retain,nonatomic) CVUISelect *ddlApplyItem;
@property(nonatomic,retain) HRBirthView *hrBirth;
@property(nonatomic,retain) HRMarryView *hrMarray;
@property(nonatomic,retain) HRDieView *hrDie;
@property (retain, nonatomic) IBOutlet UIButton *buttonSubmit;

@property (retain, nonatomic) IBOutlet UITextField *txtApplyName;
@property (retain, nonatomic) IBOutlet UITextField *txtApplyAddress;
@property (retain, nonatomic) IBOutlet UITextField *txtApplyTel;
@property (retain, nonatomic) IBOutlet UITextField *txtApplyMobile;
@property (retain, nonatomic) IBOutlet UITextField *txtApplyEmail;
@property (retain, nonatomic) IBOutlet UITextField *txtApplyMemo;
@property (retain, nonatomic) IBOutlet UITextField *txtPWD;
- (IBAction)buttonSubmit:(id)sender;
- (IBAction)textExitToEdit:(id)sender;


@end
