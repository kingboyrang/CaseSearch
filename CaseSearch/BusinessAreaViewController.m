//
//  BusinessAreaViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/13.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "BusinessAreaViewController.h"
#import "AlterMessage.h"
#import "BulletSoapMessage.h"
#import "FileHelper.h"
@interface BusinessAreaViewController ()

@end

@implementation BusinessAreaViewController
@synthesize txtPWD,txtUser;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cellEqIdentifier.textLabel.font=[UIFont systemFontOfSize:17];
    self.cellEqIdentifier.textLabel.text=[[UIDevice currentDevice] uniqueDeviceIdentifier];

    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    [_cellEqIdentifier release];
    [txtPWD release];
    [txtUser release];
    [super dealloc];
}
//同步
- (IBAction)buttonSyncClick:(id)sender {
    UserSet *user=[UserSet loadUser];
    if (user.isSync){
        [AlterMessage initWithMessage:@"己註冊帳號!無需再註冊!"];
        return;
    }
    
    UIAlertView  *myAlert = [[UIAlertView alloc] initWithTitle: @"登錄"
                                                       message: nil
                                                      delegate: self
                                             cancelButtonTitle: @"取消"
                                             otherButtonTitles: @"確定", nil];
    
    [myAlert show];
    [myAlert release];
}
-(void)textExitEdit:(id)sender{
    [sender resignFirstResponder];
}
#pragma mark -
#pragma mark UIAlertView delegate Methods
- (void)willPresentAlertView:(UIAlertView *)alertView
{
    
    CGRect frame = alertView.frame;
        frame.origin.y -= 120;
        frame.size.height += 80;
        alertView.frame = frame;
        for( UIView * view in alertView.subviews )
        {
            if( ![view isKindOfClass:[UILabel class]] )
                
            {
                if (view.tag==1)
                    
                {
                    CGRect btnFrame1 =CGRectMake(30, frame.size.height-65, 105, 40);
                    
                    view.frame = btnFrame1;
                    
                } else if  (view.tag==2){
                    
                    CGRect btnFrame2 =CGRectMake(142, frame.size.height-65, 105, 40);
                    
                    view.frame = btnFrame2;
                    
                }
            }
        
        //加入自訂的label及UITextFiled
        
        UILabel *lblaccountName=[[UILabel alloc] initWithFrame:CGRectMake( 30, 50,60, 30 )];;
        lblaccountName.text=@"帳號：";
        lblaccountName.backgroundColor=[UIColor clearColor];
        lblaccountName.textColor=[UIColor whiteColor];
        
        
        self.txtUser= [[UITextField alloc] initWithFrame: CGRectMake( 85, 50,160, 30 )];
        self.txtUser.placeholder = @"輸入帳號";
        self.txtUser.borderStyle=UITextBorderStyleRoundedRect;
        self.txtUser.textAlignment=NSTextAlignmentLeft;
        self.txtUser.contentVerticalAlignment=UIControlContentHorizontalAlignmentCenter;
        [self.txtUser addTarget:self action:@selector(textExitEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        
        
        
        UILabel *lblaccountPassword=[[UILabel alloc] initWithFrame:CGRectMake( 30, 85,60, 30 )];;
        lblaccountPassword.text=@"密碼：";
        lblaccountPassword.backgroundColor=[UIColor clearColor];
        lblaccountPassword.textColor=[UIColor whiteColor];
        
        
        self.txtPWD= [[UITextField alloc] initWithFrame: CGRectMake( 85, 85,160, 30 )];
        self.txtPWD.placeholder = @"輸入密碼";
        self.txtPWD.borderStyle=UITextBorderStyleRoundedRect;
        self.txtPWD.secureTextEntry=YES;
        self.txtPWD.textAlignment=NSTextAlignmentLeft;
        self.txtPWD.contentVerticalAlignment=UIControlContentHorizontalAlignmentCenter;
         [self.txtPWD addTarget:self action:@selector(textExitEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        [alertView addSubview:lblaccountName];
        [alertView addSubview:self.txtUser];        
        [alertView addSubview:lblaccountPassword];
        [alertView addSubview:self.txtPWD];
        [lblaccountName release];
        [lblaccountPassword release];
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1){
        if ([self.txtUser.text length]==0) {
            [AlterMessage initWithMessage:@"帳號不為空!"];
            return;
        }
        if ([self.txtPWD.text length]==0) {
            [AlterMessage initWithMessage:@"密碼不為空!"];
            return;
        }
         NSString *soapMsg=[BulletSoapMessage AddDeviceSoap:self.txtUser.text password:self.txtPWD.text appCode:self.cellEqIdentifier.textLabel.text];
        
        [self showHUD:@"submit..."];
        [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"AddDevice" soapMessage:soapMsg] completed:^(NSString *xml) {
            [self hideHUD];
            if ([xml isEqualToString:@"true"]) {
                UserSet *user=[UserSet loadUser];
                user.isSync=YES;
                [UserSet save:user];
                
                [AlterMessage showTipMsg:@"同步成功!" finishAction:^(){
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
            else{
                [AlterMessage initWithMessage:@"同步失敗!"];
            }
            
        } failed:^(NSError *error) {
            [self hideHUD];
            [AlterMessage initWithMessage:@"同步失敗!"];
        }];
    }
}
@end
