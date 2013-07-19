//
//  BasicViewController.m
//  CaseSearch
//
//  Created by rang on 13-4-24.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
#pragma mark -
#pragma mark 提交动画操作
-(void)show:(NSString*)title{
    _activityBar=[[CVUIActivityBar alloc] initWithTitle:title];
    [self.view addSubview:_activityBar];
    [_activityBar show];
}
-(void)showFailed:(NSString*)title{
    _activityBar.errorMessage=title;
    [_activityBar showFailed];
}
-(void)showSuccess:(NSString*)title completion:(void (^)(void))completion{
    _activityBar.successMessage=title;
    [_activityBar showSuccess];
    if (completion) {
        completion();
    }
}
-(void)showNetWork{
    if ([NetWorkConnection connectedToNetwork]) {
        return;
    }
    _activityBar=[[CVUIActivityBar alloc] netWorkWithTitle:@"網絡連接不可用!"];
    [self.view addSubview:_activityBar];
    [_activityBar show];
    
    [self performSelector:@selector(removeBar) withObject:nil afterDelay:0.3f];
}
-(void)removeBar{
    [_activityBar hide];
}
#pragma mark -
#pragma mark 显示与隐藏动画
-(void)showHUD:(NSString*)title{
    [self showHUD:title withView:self.view];
}
-(void)showHUD:(NSString*)title withView:(UIView*)sender{
    //UIApplication *app=[UIApplication sharedApplication];
    HUD = [[MBProgressHUD alloc] initWithView:sender];
	//[self.navigationController.view addSubview:HUD];
    [sender addSubview:HUD];
	HUD.dimBackground = YES;
    //HUD.color=[UIColor redColor];
	HUD.labelText = title;
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
	
    [HUD show:YES];
    
}
-(void)hideHUD{
    [HUD hide:YES];
}
#pragma mark -
#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    if (_activityBar!=nil) {
        [_activityBar release];
        _activityBar=nil;
    }
    [super dealloc];
}
@end
