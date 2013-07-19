//
//  TaxViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "CircularTax.h"
#import "CVUISelect.h"
#import "BasicTableViewController.h"
@interface TaxViewController : BasicTableViewController<UITextViewDelegate,CVUISelectDelegate,ServiceHelperDelegate>{
    CircularTax *tax;
}
@property (retain, nonatomic) IBOutlet UITextView *txtMatter;
//@property (retain, nonatomic) IBOutlet UITableViewCell *cellCity;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory1;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory2;
@property (retain, nonatomic) IBOutlet UITextField *txtAddress;
@property (retain, nonatomic) IBOutlet UITextField *txtPWD;
@property (retain, nonatomic) IBOutlet UIButton *buttonSubmit;



@property(nonatomic,retain) CVUISelect *ddlCategory1;
@property(nonatomic,retain) CVUISelect *ddlCategory2;
//退出编辑
-(IBAction)textEditExitbg:(id)sender;
//提交
- (IBAction)buttonSubmitClick:(id)sender;
//提交验证
-(BOOL)formSubmit;
@end
