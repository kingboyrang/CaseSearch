//
//  ApplyItemViewController.m
//  CaseSearch
//
//  Created by rang on 13-4-15.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "ApplyItemViewController.h"

@interface ApplyItemViewController ()

@end

@implementation ApplyItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    self.view.backgroundColor=[UIColor clearColor];
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

@end
