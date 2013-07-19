//
//  SafeViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/19.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "SafeViewController.h"
#import "AlterMessage.h"
@interface SafeViewController ()

@end

@implementation SafeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)loadAnimation{
     
    self.navigationController.view.alpha=0.0;
    CGRect appFrame=[[UIScreen mainScreen] applicationFrame];
    bgView=[[UIView alloc] initWithFrame:appFrame];
    bgView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

    
    NSString *loadImgName=@"load.jpg";
    if ([AppSystem isIPad]) {
        loadImgName=@"ipad_load.jpg";
    }
    
    UIImage *bgImg=[[UIImage imageNamed:loadImgName] imageByScalingProportionallyToSize:CGSizeMake(appFrame.size.width, appFrame.size.height)];
    [bgView setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
    UIApplication *app=[UIApplication sharedApplication];
    UIWindow *window=[app.delegate window];
    [window addSubview:bgView];
    [window bringSubviewToFront:bgView];
    //[window setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:bgImg];
    
    //加载动画
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
	[window addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    //HUD.delegate = self;
    HUD.labelText = @"Loading";
    
    // myProgressTask uses the HUD instance to update progress
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
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
    [HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
    //UIApplication *app=[UIApplication sharedApplication];
    //[[app.delegate window] setBackgroundColor:[UIColor clearColor]];
    [bgView removeFromSuperview];
    UserSet *user=[UserSet systemUser];
    if (!user) {
          self.navigationController.view.alpha=1.0;
    }else{
        
        [self performSegueWithIdentifier:@"saftToTabBar" sender:nil];
    }

    
    
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
    
    //加载动画
    [self loadAnimation];
    
    
    
    //显示状态
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] showNetWorkStatus];
    self.navigationItem.rightBarButtonItem=rightButton;
    [rightButton release];
    
    //设置背景
    [self loadDefaultBackground];
    
    
    
    CGFloat w=(555*44)/99;
    CGFloat leftx=(self.view.frame.size.width-w)/2.0;
    UIImageView *logoView=[[UIImageView alloc] initWithFrame:CGRectMake(leftx, 0,w, 44)];
    UIImage *logoImage=[[UIImage imageNamed:@"logo2.png"] imageByScalingProportionallyToSize:CGSizeMake(w, 44)];
    [logoView setImage:logoImage];
    
    self.navigationItem.titleView=logoView;
    [logoView release];
    
	// Do any additional setup after loading the view.
}
-(void)loadDefaultBackground{
    
    NSString *bgImgName=@"bg.png";
    if ([AppSystem isIPad]) {
        bgImgName=@"ipad_bg.jpg";
    }
    //設定背景
    CGRect tScreenBounds =self.view.frame;
    NSString *imgPath=[[NSBundle mainBundle] pathForResource:[bgImgName stringByDeletingPathExtension] ofType:[bgImgName pathExtension]];
    UIImage *bgImg1=[UIImage imageWithContentsOfFile:imgPath];
    UIImage *bgImg=[bgImg1 imageByScalingProportionallyToSize:tScreenBounds.size];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
}
//返回
-(void)btnBackClick:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonSkipClick:(id)sender {
    [self performSegueWithIdentifier:@"saftToTabBar" sender:nil];
}
- (void)dealloc {
    [super dealloc];
}
@end
