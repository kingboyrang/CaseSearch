//
//  MainSkipSegue.m
//  CaseSearch
//
//  Created by rang on 12-11-18.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "MainSkipSegue.h"
#import "NetWorkConnection.h"
#import <CoreLocation/CoreLocation.h>
#import "AlterMessage.h"
@implementation MainSkipSegue
-(void)perform{
    UIViewController *curentView=self.sourceViewController;
    UIViewController *nextView=self.destinationViewController;
    if ([self.identifier isEqualToString:@"goToAdd"]) {
        NSString *errMsg=[self NetworkGpsOpen];
        if ([errMsg length]!=0) {
            [AlterMessage initWithMessage:[NSString stringWithFormat:@"%@%@",errMsg,@"不能使用案件通報功能！"]];
            return;
        }
        UserSet *user=[UserSet systemUser];
        if (user==nil) {
            [AlterMessage initWithMessage:@"請先進行使用者設定！"];
			return;
        }
        //[nextView setTitle:@"案件通報"];
        [curentView.navigationController pushViewController:nextView animated:YES];
    }
    if ([self.identifier isEqualToString:@"goToMachine"]||[self.identifier isEqualToString:@"goToComp"]) {
        if (![NetWorkConnection connectedToNetwork]) {
            [AlterMessage initWithMessage:@"網絡未連接!"];
            return;
        }
        if ([self.identifier isEqualToString:@"goToMachine"]) {
            // [nextView setTitle:@"本機案件查詢"];
        }
        if ([self.identifier isEqualToString:@"goToComp"]) {
            //[nextView setTitle:@"全部案件查詢"];
        }
       
        [curentView.navigationController pushViewController:nextView animated:YES];
    }
    
}
-(NSString*)NetworkGpsOpen{
    BOOL b1=[NetWorkConnection connectedToNetwork];//判断网络是否连接
    BOOL b2=[CLLocationManager locationServicesEnabled];//判断gps功能是否开启
    NSString *errString=@"";
    if (!b1&&!b2) {
        errString=@"網路連線與gps功能未開啟！";
    }
    if (b1&&!b2) {
        errString=@"gps功能未開啟！";
    }
    if (!b1&&b2) {
        errString=@"網路未連線！";
    }
    /**
     if (!b1||!b2) {
     
     [AlterMessage initWithMessage:[NSString stringWithFormat:@"%@%@",errString,@"不能使用案件通報功能！"]];
     }
     ***/
    return errString;
}

@end
