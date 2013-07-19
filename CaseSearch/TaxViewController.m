//
//  TaxViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "TaxViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AlterMessage.h"
#import "CircularType.h"
#import "RegexKitLite.h"
@interface TaxViewController ()

@end

@implementation TaxViewController
@synthesize ddlCategory1,ddlCategory2;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
   

    self.txtMatter.delegate=self;
    self.txtMatter.layer.borderWidth=1.0;
    self.txtMatter.layer.borderColor=[UIColor grayColor].CGColor;
    self.txtMatter.layer.cornerRadius=5.0;
    
    
    
    CGFloat leftX=10;
    if ([AppSystem isIPad]) {
        leftX=(self.view.frame.size.width-290)/2;
    }
    
    //案件分类
    self.ddlCategory1=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX, 3, 290, 31)];
    self.ddlCategory1.delegate=self;
    [self.cellCategory1.contentView addSubview:self.ddlCategory1];
    //数据绑定
    [CircularType asycCircularType:@"E" withDropList:self.ddlCategory1];
    
    self.ddlCategory2=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX, 3, 290, 31)];
    [self.cellCategory2.contentView addSubview:self.ddlCategory2];
    //第二层隐藏
    self.cellCategory2.hidden=YES;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:self.cellCategory2];
    [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
    
    
    tax=[[CircularTax alloc] init];
    
}
//返回
-(void)btnBackClick:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}
//退出编辑
-(IBAction)textEditExitbg:(id)sender{
    [sender resignFirstResponder];
}
#pragma mark -
#pragma mark TextView delegate Methods
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"請按我輸入文字"]) {
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark -
#pragma mark CVUISelectDelegate Delegate Methods
-(void)doneChooseItem:(id)sender{
    if (self.ddlCategory1.isChange) {
        NSString *guid=[self.ddlCategory1 value];
        NSMutableArray *arr=[CircularType ChildsParentType:guid withData:[CircularType CircularTaxType]];
        if ([arr count]>0) {
            self.cellCategory2.hidden=NO;
            [self.ddlCategory2 setDataSourceForArray:arr dataTextName:@"Name" dataValueName:@"GUID"];
        }else{
            self.cellCategory2.hidden=YES;
            [self.ddlCategory2 setDataSourceForArray:[NSArray array] dataTextName:@"Name" dataValueName:@"GUID"];
        }
        //第二层隐藏
        NSIndexPath *indexPath=[self.tableView indexPathForCell:self.cellCategory2];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
        [self.tableView reloadData];
    }
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell==self.cellCategory2) {
        if (cell.hidden) {
            return 0;
        }
        return 37;
    }
    return cell.frame.size.height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ServicesHelper delegate Methods
-(void)finishedRequest:(NSString*)xml{
    self.buttonSubmit.enabled=YES;
    if ([xml length]>0) {
        [self showSuccess:@"送出成功!" completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];

    }else{
        [self showFailed:@"送出失敗!"];
    }
}
-(void)failedRequest:(NSError*)error{
    self.buttonSubmit.enabled=YES;
    [self showFailed:@"送出失敗!"];
    
}
//提交
- (IBAction)buttonSubmitClick:(id)sender{
    if (![self formSubmit]){
        return;
    }
    if (![NetWorkConnection connectedToNetwork]) {
        [self showNetWork];
        return;
    }
    NSString *strType=@"";
    if ([self.ddlCategory2.value length]>0) {
        strType=[self.ddlCategory2 value];
    }else{
        strType=[self.ddlCategory1 value];
    }
    tax.TypeGuid=strType;
    //tax.Ctiy=[[self.ddlcity.saveDic allKeys] objectAtIndex:0];
    tax.Ctiy=@"全部";
    tax.Location=self.txtAddress.text;
    
    if ([self.txtMatter.text isEqualToString:@"請按我輸入文字"]) {
        tax.Memo=@"";
    }else{
        tax.Memo=self.txtMatter.text;
    }
    tax.PWD=self.txtPWD.text;
    self.buttonSubmit.enabled=NO;
    [self show:@"submit..."];
    
    [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"AddCircular" soapMessage:[tax ObjectSeriationToString]] delegate:self];
}
//提交验证
-(BOOL)formSubmit{
    if ([self.ddlCategory1.value length]==0&&[self.ddlCategory2.value length]==0) {
        [AlterMessage initWithMessage:@"請選擇案件分類!"];
        return NO;
    }
    /***
    if (self.ddlcity.saveDic==nil||[self.ddlcity.saveDic count]==0) {
        [AlterMessage initWithMessage:@"請選擇鄉鎮市別!"];
        return NO;
    }
     //10004002
     **/
    NSString *strType=@"";
    if ([self.ddlCategory2.value length]>0) {
        strType=[self.ddlCategory2 value];
    }else{
        strType=[self.ddlCategory1 value];
    }

    
    /**
    if([self.txtMatter.text length]==0){
        [AlterMessage initWithMessage:@"狀況描述不為空!"];
        return NO;
    }
     **/
    if ([self.txtPWD.text length]==0) {
		[AlterMessage initWithMessage:@"案件密碼不能爲空!"];
		return NO;
	}else{
        //英數混合5碼以上!
        NSString *regxStr=@"^[A-Za-z0-9]{5,}$";
        NSRange r=[self.txtPWD.text rangeOfString:regxStr options:NSRegularExpressionSearch];
        if (r.location==NSNotFound){
            [AlterMessage initWithMessage:@"格式錯誤,案件密碼英數混合5碼以上!"];
            return NO;
        }
    }
    return YES;
}
- (void)dealloc {
    [tax release];
    [_txtMatter release];
    //[ddlcity release];
    [ddlCategory1 release];
    [ddlCategory2 release];
    [_cellCategory1 release];
    [_cellCategory2 release];
   // [_cellCity release];
    [_txtAddress release];
    [_txtPWD release];
    [_buttonSubmit release];
    [super dealloc];
}
@end
