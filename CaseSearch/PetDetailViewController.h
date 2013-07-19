//
//  PetDetailViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/7.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircular.h"
#import "basicDetailViewController.h"
@interface PetDetailViewController : basicDetailViewController

@property (retain, nonatomic) IBOutlet UITableViewCell *cellBulletNO;


@property (retain, nonatomic) IBOutlet UITableViewCell *cellBulletDate;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellStatus;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellHandlerStatus;


@property (retain, nonatomic) IBOutlet UITableViewCell *cellPetName;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPetType;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPetAge;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPetSex;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPetNeutered;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellPetFeature;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellChip;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellLocation;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellAwayDate;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellContact;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellMemo;
@property (retain, nonatomic) IBOutlet UITableViewCell *cellImages;



@property(nonatomic,retain) VCircular *ItemCircular;
@property(nonatomic,retain) NSString *CircularPWD;

@end
