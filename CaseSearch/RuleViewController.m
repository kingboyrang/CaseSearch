//
//  RuleViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/19.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "RuleViewController.h"

@interface RuleViewController ()

@end

@implementation RuleViewController

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
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    
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

- (void)dealloc {
    [_tvRule release];
    [super dealloc];
}
@end
