//
//  SafeViewController.h
//  CaseSearch
//
//  Created by aJia on 12/12/19.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeViewController : UIViewController<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
    UIView *bgView;
}


- (IBAction)buttonSkipClick:(id)sender;
-(void)loadAnimation;
-(void)loadDefaultBackground;
@end
