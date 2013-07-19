//
//  LightViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularLight.h"
#import "ServiceHelper.h"
#import "CVUISelect.h"
#import "BasicTableViewController.h"
@interface LightViewController : BasicTableViewController<CVUISelectDelegate,ServiceHelperDelegate,UITextViewDelegate>{
    int changeImgTag;
    int cameraAlbumTag;
     
    CircularLight *light;
    
    
}
@property (retain, nonatomic) IBOutlet UITableViewCell *cellLightNum;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellLightNumValue;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellAddressMemo;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellAddressValue;



@property (retain, nonatomic) IBOutlet UIButton *buttonGps;

@property (retain, nonatomic) IBOutlet UITextField *txtLightNumber;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPhoto;


@property (retain, nonatomic) IBOutlet UITextField *txtPWD;
@property (retain, nonatomic) IBOutlet UITextField *txtAddress;
@property (retain, nonatomic) IBOutlet UITextField *txtBulletAddress;
@property (retain, nonatomic) IBOutlet UIButton *buttonSubmit;


@property (retain, nonatomic) IBOutlet UITableViewCell *cellCity;
@property (retain, nonatomic) IBOutlet UITextView *txtMemo;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory1;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory2;

@property(nonatomic,retain) CVUISelect *ddlcity;
@property(nonatomic,retain) CVUISelect *ddlCategory1;
@property(nonatomic,retain) CVUISelect *ddlCategory2;
//地址与路灯编号选中[当出现路灯编号时，checkbox切换]
-(IBAction)buttonSelectClick:(id)sender;
//手机定位
- (IBAction)buttonLocClick:(id)sender;


//退出编辑
-(IBAction)textEditExitbg:(id)sender;
//提交
- (IBAction)buttonSubmitClick:(id)sender;
//提交验证
-(BOOL)formSubmit;
@end
