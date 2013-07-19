//
//  PushDetailViewController.m
//  CaseSearch
//
//  Created by aJia on 12/11/26.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "PushDetailViewController.h"
#import "BulletSoapMessage.h"
#import "PushInfo.h"
#import "AlterMessage.h"
#import "VCircular.h"
@interface PushDetailViewController ()

@end

@implementation PushDetailViewController
@synthesize GUID,ItemData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    
    
    if (self.GUID!=nil) {
        self.ItemData=[NSDictionary dictionary];
        NSString *soapMsg=[BulletSoapMessage PushInfoSoap:self.GUID];
        [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"GetPushInfo" soapMessage:soapMsg] delegate:self];
    }else{
        
        if ([self.ItemData objectForKey:@"Number"]!=nil) {
            [self loadCaseDetail:[self.ItemData objectForKey:@"Number"]];
        }else{
            [self reLoadController:[self.ItemData objectForKey:@"Title"] withMessage:[self.ItemData objectForKey:@"Content"]];
        }
        self.GUID=@"";
    }
}
-(void)reLoadController:(NSString*)title withMessage:(NSString*)msg{
   
    CGSize textSize=[title CalculateStringSize:[UIFont boldSystemFontOfSize:17] with:self.view.frame.size.width];
    
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-textSize.width)/2, 2, textSize.width, textSize.height)];
    labTitle.font=[UIFont boldSystemFontOfSize:17];
    labTitle.textColor=[UIColor blackColor];
    labTitle.text=title;
    labTitle.backgroundColor=[UIColor clearColor];
    [self.view addSubview:labTitle];
    [labTitle release];
    
    CGFloat topY=self.view.frame.size.height;
    topY-=(textSize.height+4);
    /***
    if (self.navigationController) {
        topY-=self.navigationController.navigationBar.frame.size.height;
    }
    if (self.tabBarController) {
        topY-=self.tabBarController.tabBar.frame.size.height;
    }
     ***/
    UITextView *tv=[[UITextView alloc] initWithFrame:CGRectMake(0, textSize.height+4, self.view.frame.size.width, topY)];
    tv.editable=NO;
    tv.font=[UIFont systemFontOfSize:17];
    tv.textColor=[UIColor blackColor];
    tv.backgroundColor=[UIColor clearColor];
    //[tv setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    tv.text=msg;
    [self.view addSubview:tv];
    [tv release];

}
-(void)loadCaseDetail:(NSString*)title{
    //标题
    NSString *caseTitle=[NSString stringWithFormat:@"%@結案通知",title];
    CGSize textSize=[caseTitle CalculateStringSize:[UIFont boldSystemFontOfSize:17] with:self.view.frame.size.width];
    
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-textSize.width)/2, 2, textSize.width, textSize.height)];
    labTitle.font=[UIFont boldSystemFontOfSize:17];
    labTitle.textColor=[UIColor blackColor];
    labTitle.text=caseTitle;
    labTitle.backgroundColor=[UIColor clearColor];
    [self.view addSubview:labTitle];
    [labTitle release];
    
    //内容1
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(42, textSize.height+4, 277, 21)];
    lab1.font=[UIFont systemFontOfSize:17];
    lab1.backgroundColor=[UIColor clearColor];
    lab1.textColor=[UIColor blackColor];
    lab1.text=[NSString stringWithFormat:@"您好，編號:%@案件已完成，",title];
    [self.view addSubview:lab1];
    [lab1 release];
    
     CGFloat topY=textSize.height+25;
    //详情按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(8, topY, 34, 21);
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"按此" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //内容2
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(42, topY, 170, 21)];
    lab2.font=[UIFont systemFontOfSize:17];
    lab2.backgroundColor=[UIColor clearColor];
    lab2.textColor=[UIColor blackColor];
    lab2.text=@"查看案件詳情資料。";
    [self.view addSubview:lab2];
    [lab2 release];
}
//详情
-(IBAction)buttonDetailClick:(id)sender{
    
    UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"提示" message:nil
                                                 delegate:self
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"確定",nil];
    UITextField *pwdField=[[UITextField alloc] initWithFrame:CGRectMake(10, 40, 264, 31)];
    pwdField.tag=100;
    pwdField.borderStyle=UITextBorderStyleRoundedRect;
    pwdField.placeholder=@"請輸入案件密碼";
    pwdField.textAlignment=NSTextAlignmentLeft;
    //UITextAlignmentLeft;
    pwdField.secureTextEntry=YES;
    pwdField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [pwdField addTarget:self action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [alter addSubview:pwdField];
    
    
    
    [pwdField release];
    [alter show];
    [alter release];
    
}
#pragma -
#pragma 按return时退出键盘
- (IBAction)textFiledReturnEditing:(id)sender
{
	[sender resignFirstResponder];
}
#pragma -
#pragma UIAlertView delegate Methods
-(void) willPresentAlertView:(UIAlertView *)alertView{
    alertView.bounds=CGRectMake(alertView.bounds.origin.x, alertView.bounds.origin.y, alertView.bounds.size.width,alertView.bounds.size.height+30);
	for (UIView *v in alertView.subviews) {
		NSString *strV=[NSString stringWithFormat:@"%@",[v class]];
		if ([strV isEqualToString:@"UIAlertButton"]) {
			CGRect rect=v.frame;
			rect.origin.y=40+31+10;
			v.frame=rect;
		}
	}
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
	//確定 ＝1
	if (buttonIndex==1) {//確定
		UITextField *pwdField=(UITextField*)[alertView viewWithTag:100];
		if ([pwdField.text length]==0) {
			[AlterMessage initWithMessage:@"密碼錯誤!"];
		}else {
            
            //VCircular *vCircular=[[[VCircular alloc] init] autorelease];
			//NSString *soapMsg=[vCircular CheckPasswordByCircularSoap:[self.ItemData objectForKey:@"Category"] withGUID:[self.ItemData objectForKey:@"GUID"] withPassword:pwdField.text];
            //NSString *result=[helper SysServiceMethod:@"CheckPasswordByCircular" SoapMessage:soapMsg];
            NSString *pw=[pwdField.text Trim];
            if ([pw isEqualToString:[self.ItemData objectForKey:@"PWD"]]) {
                circularPWD=pw;
                
                UIStoryboard *storyboard=self.storyboard;
                
                UIViewController *destination=[storyboard instantiateViewControllerWithIdentifier:[self.ItemData objectForKey:@"segment"]];
                
                SEL selPwd=NSSelectorFromString(@"CircularPWD");
                if ([destination respondsToSelector:selPwd]){
                    [destination setValue:pw forKey:@"CircularPWD"];
                }
                SEL sel=NSSelectorFromString(@"ItemCircular");
                if ([destination respondsToSelector:sel]) {
                    VCircular *vcircular=[[VCircular alloc] init];
                    vcircular.GUID=[self.ItemData objectForKey:@"GUID"];
                    vcircular.PWD=pw;
                    //[self.ItemData objectForKey:@"PWD"];
                    vcircular.Category=[self.ItemData objectForKey:@"Category"];
                    
                    [destination setValue:vcircular forKey:@"ItemCircular"];
                    [vcircular release];
                }
               
                [self.navigationController pushViewController:destination animated:YES];
               
            }else {
                [AlterMessage initWithMessage:@"密碼錯誤!"];
            }
            
		}
        
	}
	
}
//返回
-(void)btnBackClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark WebService delegate Methods
-(void)finishSoapRequest:(NSString*)xml userInfo:(NSDictionary*)info{
    NSMutableDictionary *dic=[PushInfo PushToDictionary:xml];
    //[AlterMessage initWithMessage:[NSString stringWithFormat:@"%@",dic]];
    if([dic count]>0){
        //[AlterMessage initWithMessage:@"ＯＫ吗？！"];
        [self reLoadController:[dic objectForKey:@"Title"] withMessage:[dic objectForKey:@"Content"]];
        //文件写入
        [PushInfo writeToPushFile:dic];
    }else{
       [AlterMessage initWithMessage:@"資料加載失敗！"];
    }
    
}
-(void)failedSoapRequest:(NSError*)error userInfo:(NSDictionary*)dic{
    [AlterMessage initWithMessage:@"資料加載失敗！"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    [GUID release];
    [ItemData release];
    [super dealloc];
}
@end
