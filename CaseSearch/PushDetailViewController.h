//
//  PushDetailViewController.h
//  CaseSearch
//
//  Created by aJia on 12/11/26.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
@interface PushDetailViewController : UIViewController<ServiceHelperDelegate,UIAlertViewDelegate>{
    NSString *circularPWD;
}
@property(nonatomic,retain) NSDictionary *ItemData;
@property(nonatomic,retain) NSString *GUID;

-(void)reLoadController:(NSString*)title withMessage:(NSString*)msg;
-(void)loadCaseDetail:(NSString*)title;
@end
