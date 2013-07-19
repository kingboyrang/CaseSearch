//
//  CompleteSearchViewController.h
//  CaseSearch
//
//  Created by rang on 12-11-14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircularSearchArgs.h"
#import "ServiceHelper.h"
#import "VCircular.h"
#import "CVUISelect.h"
#import "CVUICalendar.h"
#import "BasicViewController.h"
#import "PullingRefreshTableView.h"
@interface CompleteSearchViewController : BasicViewController<PullingRefreshTableViewDelegate,ServiceHelperDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{

    int maxPage;
    
    VCircularSearchArgs *args;
    VCircular *vCircular;
    
    BOOL isFirstLoad;
    int selectRow;
    NSString *circularPWD;
}

@property(nonatomic,retain) NSDictionary *segmentData;
@property (retain, nonatomic) IBOutlet UITextField *txtCaseNO;
@property (retain,nonatomic) PullingRefreshTableView *tableView;
@property (nonatomic) BOOL refreshing;
@property(nonatomic,retain) NSMutableArray *listData;
@property(nonatomic,retain) CVUICalendar *bdate;
@property(nonatomic,retain) CVUICalendar *edate;
@property(nonatomic,retain) CVUISelect *ddlCategory;
@property(nonatomic,retain) CVUISelect *ddlCity;
//退出键盘
- (IBAction)buttonCaseNumExit:(id)sender;


-(void)reloadSearchArgs;
-(void)startAsyLoad;
@end
