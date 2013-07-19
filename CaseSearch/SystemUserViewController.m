//
//  SystemUserViewController.m
//  CaseSearch
//
//  Created by aJia on 12/11/27.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "SystemUserViewController.h"
#import "AlterMessage.h"
#import "FileHelper.h"
#import "SafeViewController.h"
@interface SystemUserViewController ()

@end

@implementation SystemUserViewController

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
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    UserSet *user=[UserSet loadUser];
    self.txtName.text=user.Name;
    self.txtNick.text=user.Nick;
    self.txtTel.text=user.Mobile;
    self.txtEmail.text=user.Email;
}
- (IBAction)editFieldExit:(id)sender {
    [sender resignFirstResponder];
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
-(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (IBAction)buttonSubmit:(id)sender {
	if ([self.txtEmail.text length]>0) {
        if (![self validateEmail:self.txtEmail.text]) {
            [AlterMessage initWithMessage:@"郵件地址格式錯誤!"];
            return;
        }
    }
	
	UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否確定儲存?"
												 delegate:self
										cancelButtonTitle:@"取消"
										otherButtonTitles:@"確定",nil];
	[alter show];
	[alter release];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//NSLog(@"index=%d",buttonIndex);
	if (buttonIndex==1) {
        UserSet *user=[UserSet loadUser];
        user.Name=self.txtName.text;
        user.Nick=self.txtNick.text;
        user.Mobile=self.txtTel.text;
        user.Email=self.txtEmail.text;
        if ([user.GUID length]==0) {
            user.GUID=[[UIDevice currentDevice] uniqueDeviceIdentifier];
        }
        [UserSet save:user];
		[AlterMessage initWithMessage:@"儲存成功!"];
	}
}
- (void)dealloc {
    [_txtName release];
    [_txtTel release];
    [_txtEmail release];
    [_txtNick release];
    [super dealloc];
}
@end
