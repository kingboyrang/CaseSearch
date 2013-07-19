//
//  BasicViewController.h
//  CaseSearch
//
//  Created by rang on 13-4-24.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CVUIActivityBar.h"
#import "NetWorkConnection.h"
@interface BasicViewController : UIViewController<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
    CVUIActivityBar *_activityBar;
}
-(void)showHUD:(NSString*)title;
-(void)showHUD:(NSString*)title withView:(UIView*)sender;
-(void)hideHUD;


-(void)show:(NSString*)title;
-(void)showFailed:(NSString*)title;
-(void)showSuccess:(NSString*)title completion:(void (^)(void))completion;
-(void)showNetWork;
-(void)removeBar;
@end
