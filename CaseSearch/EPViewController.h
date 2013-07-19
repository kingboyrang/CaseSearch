//
//  EPViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularEP.h"
#import "ServiceHelper.h"
#import "CVUISelect.h"
#import "BasicTableViewController.h"
@interface EPViewController : BasicTableViewController<CVUISelectDelegate,ServiceHelperDelegate,UITextViewDelegate>{
    int changeImgTag;
    int cameraAlbumTag;
     
    CircularEP *ep;
    
}
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory2;

@property (retain, nonatomic) IBOutlet UITextView *txtMemo;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCity;
@property (retain, nonatomic) IBOutlet UITextField *txtAddress;
@property (retain, nonatomic) IBOutlet UITextField *txtPWD;
@property (retain, nonatomic) IBOutlet UIButton *buttonSubmit;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellPhoto;

@property(nonatomic,retain) CVUISelect *ddlcity;
@property(nonatomic,retain) CVUISelect *ddlCategory;
@property(nonatomic,retain) CVUISelect *ddlCategory2;
//手机定位
- (IBAction)buttonLocClick:(id)sender;

//退出编辑
-(IBAction)textEditExitbg:(id)sender;
//提交
- (IBAction)buttonSubmitClick:(id)sender;
//提交验证
-(BOOL)formSubmit;
@end
