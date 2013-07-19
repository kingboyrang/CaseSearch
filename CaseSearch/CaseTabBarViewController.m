//
//  CaseTabBarViewController.m
//  CaseSearch
//
//  Created by aJia on 12/11/20.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "CaseTabBarViewController.h"
#import "PushDetailViewController.h"
#import "PushViewController.h"
#import "CompleteSearchViewController.h"
#import "MainViewController.h"
#import "PushInfo.h"
#import "BulletSoapMessage.h"
#import "AlterMessage.h"
#import "VCircular.h"
@interface CaseTabBarViewController ()

@end

@implementation CaseTabBarViewController

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
    self.selectedIndex=2;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotifice:) name:@"pushDetail" object:nil];
	// Do any additional setup after loading the view.
}
-(void)receiveNotifice:(NSNotification*)notice{
    NSDictionary *dic=[notice userInfo];
    self.selectedIndex=2;
    UINavigationController *selectViewNav=(UINavigationController*)[self.viewControllers objectAtIndex:2];
    UIStoryboard *storyboard=selectViewNav.storyboard;
    
    if ([[dic objectForKey:@"Type"] isEqualToString:@"9"]) {
    PushDetailViewController *push=[storyboard instantiateViewControllerWithIdentifier:@"PushDetailViewController"];
    push.GUID=[dic objectForKey:@"GUID"];
    [selectViewNav pushViewController:push animated:YES];
    }else{
        
        if (![selectViewNav.topViewController isKindOfClass:[PushViewController class]]) {
            PushViewController *pushController=[storyboard instantiateViewControllerWithIdentifier:@"PushViewController"];
            [selectViewNav pushViewController:pushController animated:YES];
        }else{
        
            PushViewController *pushList=(PushViewController*)selectViewNav.topViewController;
            [pushList updatePushData];
            //[pushList v];
        }
        
       
        /***
        NSString *segemtName=[dic objectForKey:@"segment"];
        if ([segemtName length]>0) {
            UIViewController *skipController=[storyboard instantiateViewControllerWithIdentifier:segemtName];
            SEL selItem=NSSelectorFromString(@"ItemCircular");//
            if ([skipController respondsToSelector:selItem]) {
                VCircular *vcircular=[[VCircular alloc] init];
                vcircular.GUID=[dic objectForKey:@"GUID"];
                vcircular.PWD=[dic objectForKey:@"PWD"];
                vcircular.Category=[dic objectForKey:@"Category"];
                
                [skipController setValue:vcircular forKey:@"ItemCircular"];
                [vcircular release];
            }
            SEL selPwd=NSSelectorFromString(@"CircularPWD");
            if ([skipController respondsToSelector:selPwd]){
                [skipController setValue:[dic objectForKey:@"PWD"] forKey:@"CircularPWD"];
            }
            [selectViewNav pushViewController:skipController animated:YES];
        }
         ***/
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
@end
