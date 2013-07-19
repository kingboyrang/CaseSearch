//
//  MachineSearchViewController.h
//  CaseSearch
//
//  Created by rang on 12-11-14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircularSearchArgs.h"
#import "ServiceHelper.h"
#import "VCircular.h"
#import "BasicViewController.h"
#import "PullingRefreshTableView.h"
@interface MachineSearchViewController : BasicViewController<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate,ServiceHelperDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>{
    
    int maxPage;
    
    VCircularSearchArgs *args;
    VCircular *vCircular;
    
    
    BOOL isFirstLoad;

    int selectRow;
    NSString *circularPWD;
}
@property (retain,nonatomic) PullingRefreshTableView *tableView;
@property (nonatomic) BOOL refreshing;

@property(nonatomic,retain) NSDictionary *segmentData;
@property(nonatomic,retain) NSMutableArray *listData;
@end
