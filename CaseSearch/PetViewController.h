//
//  PetViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUICalendar.h"
#import "CVUISelect.h"
#import "ServiceHelper.h"
#import "CircularPet.h"
#import "BasicTableViewController.h"
@interface PetViewController : BasicTableViewController<ServiceHelperDelegate>{
     int changeImgTag;
     int cameraAlbumTag;
     CircularPet *pet;
    
}
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPetAge;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellLocation;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellDate;

@property (retain, nonatomic) IBOutlet UITextField *txtPetName;
@property (retain, nonatomic) IBOutlet UITextField *txtPetType;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segPetSex;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segPetNeutered;
@property (retain, nonatomic) IBOutlet UITextField *txtPetFeature;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segChip;
@property (retain, nonatomic) IBOutlet UITextField *txtChipCode;
@property (retain, nonatomic) IBOutlet UITextField *txtLocation;
@property (retain, nonatomic) IBOutlet UITextField *txtContact;
@property (retain, nonatomic) IBOutlet UIButton *buttonSubmit;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPhoto;

@property (retain, nonatomic) IBOutlet UITextField *txtPWD;
@property (retain, nonatomic) IBOutlet UITextField *txtMemo;
@property(nonatomic,retain) CVUISelect *ddlcity;
@property(nonatomic,retain) CVUICalendar *lostDate;
@property(nonatomic,retain) CVUISelect *ddlPetAge;

//有无晶片
- (IBAction)segChipClick:(id)sender;


//退出编辑
-(IBAction)textEditExitbg:(id)sender;
//提交验证
-(BOOL)formSubmit;
//提交
- (IBAction)buttonSubmitClick:(id)sender;

@end
