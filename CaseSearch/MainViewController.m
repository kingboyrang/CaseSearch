//
//  MainViewController.m
//  CaseSearch
//
//  Created by aJia on 12/11/14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //显示状态
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] showNetWorkStatus];
    self.navigationItem.rightBarButtonItem=rightButton;
    [rightButton release];
}
//接收通知
-(void)receiveNotifice:(NSNotification*)notice{
    self.tabBarController.selectedIndex=0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
   
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotifice:) name:@"closeWin" object:nil];
    
    [self loadConfigure];
    
    //设置背景为透明
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    
    self.tabBarController.delegate=self;//设置委拖实现
    
   //设定TabBarItem图片
    NSArray *barList=self.tabBarController.tabBar.items;
    UIImage *useImg=[[UIImage imageNamed:@"user.png"] imageByScalingProportionallyToSize:CGSizeMake(30, 30)];
    UIImage *useselImg=[[UIImage imageNamed:@"user_b.png"] imageByScalingProportionallyToSize:CGSizeMake(30, 30)];
    UITabBarItem *item1=(UITabBarItem*)[barList objectAtIndex:0];
    [item1 setTitle:@"使用者設定"];
    [item1 setFinishedSelectedImage:useselImg withFinishedUnselectedImage:useImg];
    
    UIImage *newImg=[[UIImage imageNamed:@"help.png"] imageByScalingProportionallyToSize:CGSizeMake(30, 30)];
    UIImage *newselImg=[[UIImage imageNamed:@"help_b.png"] imageByScalingProportionallyToSize:CGSizeMake(30, 30)];
    UITabBarItem *item2=(UITabBarItem*)[barList objectAtIndex:1];
    [item2 setFinishedSelectedImage:newselImg withFinishedUnselectedImage:newImg];

    
    UIImage *IndexImg=[[UIImage imageNamed:@"home1.png"] imageByScalingProportionallyToSize:CGSizeMake(30, 30)];
    UIImage *item3selImg=[[UIImage imageNamed:@"home_b.png"] imageByScalingProportionallyToSize:CGSizeMake(30, 30)];
    UITabBarItem *item3=(UITabBarItem*)[barList objectAtIndex:2];
    [item3 setFinishedSelectedImage:item3selImg withFinishedUnselectedImage:IndexImg];

}
-(void)loadConfigure{
    
    NSString *bgImgName=@"bg.png";
    if ([AppSystem isIPad]) {
        bgImgName=@"ipad_bg.jpg";
    }
    
    UIApplication *app=[UIApplication sharedApplication];
    //設定背景
    CGRect tScreenBounds = [[UIScreen mainScreen] bounds];
    UIImage *bgImg=[[UIImage imageNamed:bgImgName] imageByScalingProportionallyToSize:tScreenBounds.size];
    [[app.delegate window] setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];

    

    CGFloat w=(555*44)/99;
    CGFloat leftx=(self.view.frame.size.width-w)/2.0;
    UIImageView *logoView=[[UIImageView alloc] initWithFrame:CGRectMake(leftx, 0,w, 44)];
     UIImage *logoImage=[[UIImage imageNamed:@"logo2.png"] imageByScalingProportionallyToSize:CGSizeMake(w, 44)];
    [logoView setImage:logoImage];
    
    self.navigationItem.titleView=logoView;
    [logoView release];
    
    

   
}
#pragma mark -
#pragma mark UITabBarControllerDelegate
/**
- (BOOL)tabBarController:(UITabBarController *)tbc shouldSelectViewController:(UIViewController *)vc {
    UIViewController *tbSelectedController = tbc.selectedViewController;
    if ([tbSelectedController isEqual:vc]&&tbc.selectedIndex==0) {
		SystemSetViewController *systemSet=[[SystemSetViewController alloc] init];
        [tbSelectedController presentViewController:systemSet animated:YES completion:nil];
		[systemSet release];
        return NO;
    }
	//NSLog(@"1");
    return YES;
}
 **/
//回首页
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
   
    
    
    NSArray *controls=[tabBarController viewControllers];
    if (tabBarController.selectedIndex==2) {
        //tabBarController.selectedIndex=0;
        UINavigationController *navController=(UINavigationController*)[controls objectAtIndex:2];
        if (navController!=nil) {
            [navController popToRootViewControllerAnimated:YES];//回首页
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
@end
