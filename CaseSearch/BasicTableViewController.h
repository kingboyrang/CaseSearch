//
//  BasicTableViewController.h
//  CaseSearch
//
//  Created by rang on 13-4-18.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "LocationHelper.h"
#import "AlterMessage.h"
#import "CVUIActivityBar.h"
#import "NetWorkConnection.h"
#import "PhotoViewController.h"
#import "ASIHTTPRequest.h"
@interface BasicTableViewController : UITableViewController<MBProgressHUDDelegate>{
  MBProgressHUD *HUD;
  CVUIActivityBar *_activityBar;
}
@property(nonatomic,retain) SVPlacemark *place;
@property(nonatomic,retain) PhotoViewController *photo;
-(void)showHUD:(NSString*)title;
-(void)showHUD:(NSString*)title withView:(UIView*)sender;
-(void)hideHUD;
-(void)startPosition:(UITextField*)txtField;

-(void)show:(NSString*)title;
-(void)showFailed:(NSString*)title;
-(void)showSuccess:(NSString*)title completion:(void (^)(void))completion;
-(void)showNetWork;
-(void)removeBar;
@end
