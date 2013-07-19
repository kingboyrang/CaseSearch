//
//  AppDelegate.h
//  CaseSearch
//
//  Created by aJia on 12/11/14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
@interface AppDelegate : UIResponder <UIAlertViewDelegate,UIApplicationDelegate>{
   
    
    BOOL isFirst;
}

@property (strong, nonatomic) UIWindow *window;
-(void)AppRegisterApns;
-(void)reRegisterApns;

//推播处理
-(void)pushHandler:(NSDictionary*)userInfo;

-(void)asyncCircular;
@end
