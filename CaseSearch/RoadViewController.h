//
//  RoadViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularRoad.h"
#import "ServiceHelper.h"
#import "CVUISelect.h"
#import "BasicTableViewController.h"
@interface RoadViewController : BasicTableViewController<ServiceHelperDelegate,UITextViewDelegate>{
    int changeImgTag;
    int cameraAlbumTag;
     
    
    CircularRoad *road;
}
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCategory;
@property (retain, nonatomic) IBOutlet UITextView *txtMemo;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellCity;
@property (retain, nonatomic) IBOutlet UITextField *txtAddress;
@property (retain, nonatomic) IBOutlet UITextField *txtPWD;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellShowImg;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPhoto;

@property (retain, nonatomic) IBOutlet UIButton *buttonSubmit;


@property(nonatomic,retain) CVUISelect *ddlcity;
@property(nonatomic,retain) CVUISelect *ddlCategory;


//退出编辑
-(IBAction)textEditExitbg:(id)sender;
//手机定位
- (IBAction)buttonLocClick:(id)sender;
//提交
- (IBAction)buttonSubmitClick:(id)sender;
//提交验证
-(BOOL)formSubmit;

@end
