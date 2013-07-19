//
//  ViewController.m
//  CaseSearch
//
//  Created by aJia on 12/11/14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
-(void)loadView{
    CGRect appFrame=[[UIScreen mainScreen] applicationFrame];
    UIView *view=[[UIView alloc] initWithFrame:appFrame];
    view.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.view=view;
    [view release];
    UIImage *bgImg=[[UIImage imageNamed:@"load.jpg"] imageByScalingProportionallyToSize:CGSizeMake(appFrame.size.width, appFrame.size.height)];
    self.view.backgroundColor=[UIColor colorWithPatternImage:bgImg];
    
    //加载动画
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    
    // myProgressTask uses the HUD instance to update progress
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
    
    

    
    //[self performSelectorOnMainThread:@selector(startAnimation) withObject:nil waitUntilDone:NO];
}
//动画效果
- (void)myProgressTask {
    
	// This just increases the progress indicator in a loop
	float progress = 0.0f;
	while (progress < 1.0f) {
		progress += 0.01f;
		HUD.progress = progress;
		usleep(30000);//1s=1000(毫秒)=1000000(微秒)
	}
    self.view.backgroundColor=[UIColor clearColor];
   
    [self performSegueWithIdentifier:@"goToTabBar" sender:nil];
       
       //indexToSafe
}


#pragma mark -
#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     //[self performSegueWithIdentifier:@"goToTabBar" sender:nil];
   
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [super dealloc];
   
}
@end
