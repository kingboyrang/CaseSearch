//
//  EPViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "EPViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AlterMessage.h"
#import "RegexKitLite.h"
#import "CircularType.h"
@interface EPViewController ()

@end

@implementation EPViewController
@synthesize ddlcity,ddlCategory,ddlCategory2;
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
  
    
    ep=[[CircularEP alloc] init];
    
    self.txtMemo.delegate=self;
    self.txtMemo.layer.borderWidth=1.0;
    self.txtMemo.layer.borderColor=[UIColor grayColor].CGColor;
    self.txtMemo.layer.cornerRadius=5.0;
    
    CGFloat leftX=10;
    if ([AppSystem isIPad]) {
        leftX=(self.view.frame.size.width-290)/2;
    }
    
    NSString *cityPath=[[NSBundle mainBundle] pathForResource:@"village" ofType:@"plist"];
	self.ddlcity=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX,3,290, 31)];
	self.ddlcity.popoverText.popoverTextField.placeholder=@"鄉鎮市別";
    self.ddlcity.popoverView.popoverTitle=@"鄉鎮市別";
    [self.ddlcity setDataSourceForArray:[NSArray arrayWithContentsOfFile:cityPath]];
    [self.cellCity.contentView addSubview:self.ddlcity];
    
    CGFloat leftP=0;
    if ([AppSystem isIPad]) {
        leftP=(self.view.frame.size.width-320)/2;
    }
    
    //照片浏览
    self.photo=[[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:[NSBundle mainBundle]];
    self.photo.popController=self;
    self.photo.view.frame=CGRectMake(leftP, 0, 320, 331);
    [self.cellPhoto addSubview:self.photo.view];
    
    //案件分类
    self.ddlCategory=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX, 3, 290, 31)];
    self.ddlCategory.delegate=self;
    [self.cellCategory.contentView addSubview:self.ddlCategory];
    //数据绑定
    [CircularType asycCircularType:@"C" withDropList:self.ddlCategory];
    
    self.ddlCategory2=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX, 3, 290, 31)];
    [self.cellCategory2.contentView addSubview:self.ddlCategory2];
    //第二层隐藏
    self.cellCategory2.hidden=YES;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:self.cellCategory2];
    [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
}
//返回
-(void)btnBackClick:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}
//退出编辑
-(IBAction)textEditExitbg:(id)sender{
    [sender resignFirstResponder];
}
//手机定位
- (IBAction)buttonLocClick:(id)sender {
    [self startPosition:self.txtAddress];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -
#pragma CVUISelectDelegate Delegate Methods
-(void)doneChooseItem:(id)sender{
    if (self.ddlCategory.isChange) {
        NSString *guid=[self.ddlCategory value];
        NSMutableArray *arr=[CircularType ChildsParentType:guid withData:[CircularType CircularEPType]];
        if ([arr count]>0) {
            self.cellCategory2.hidden=NO;
            [self.ddlCategory2 setDataSourceForArray:arr dataTextName:@"Name" dataValueName:@"GUID"];
        }else{
            self.cellCategory2.hidden=YES;
            [self.ddlCategory2 setDataSourceForArray:[NSArray array] dataTextName:@"Name" dataValueName:@"GUID"];
        }
        NSIndexPath *indexPath=[self.tableView indexPathForCell:self.cellCategory2];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
        [self.tableView reloadData];
    }   
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
//提交
- (IBAction)buttonSubmitClick:(id)sender{
    if (![self formSubmit]) {
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
        strType=[self.ddlCategory value];
    }
    ep.TypeGuid=strType;
    if ([self.txtMemo.text isEqualToString:@"請按我輸入文字"]) {
        ep.Memo=@"";
    }else{
        ep.Memo=self.txtMemo.text;
    }
    ep.Lat=[NSString stringWithFormat:@"%f",self.place.coordinate.latitude];
    ep.Lng=[NSString stringWithFormat:@"%f",self.place.coordinate.longitude];
    ep.Ctiy=[self.ddlcity value];
    ep.Location=self.txtAddress.text;
    ep.PWD=self.txtPWD.text;
    ep.Images=[self.photo imageToArray];
    self.buttonSubmit.enabled=NO;
    NSString *soapMsg=[ep ObjectSeriationToString];
    [self show:@"submit..."];
    [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"AddCircular" soapMessage:soapMsg] delegate:self];
}
//提交验证
-(BOOL)formSubmit{
    if ([self.ddlCategory.value length]==0&&[self.ddlCategory2.value length]==0) {
        [AlterMessage initWithMessage:@"請選擇案件分類!"];
        return NO;
    }
    if ([self.txtAddress.text length]==0) {
        [AlterMessage initWithMessage:@"現在地址不為空!"];
        return NO;
    }
    if ([self.ddlcity.value length]==0) {
        [AlterMessage initWithMessage:@"請選擇鄉鎮市別!"];
        return NO;
    }
    /****
    if ([self.txtMemo.text length]==0) {
        [AlterMessage initWithMessage:@"狀況描述不為空!"];
        return NO;
    }
     ***/
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
#pragma mark -
#pragma mark ServicesHelper delegate Methods
-(void)finishedRequest:(NSString*)xml{
    self.buttonSubmit.enabled=YES;
    if ([xml length]>0) {
        [AlterMessage showTipMsg:@"送出成功!" finishAction:^(){
            //[self.navigationController popViewControllerAnimated:YES];
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
- (void)dealloc {
    [ep release];
    [ddlCategory2 release];
    [_cellCategory release];
    [_txtMemo release];
    [_cellCity release];
    [_txtAddress release];
    [_txtPWD release];
    [ddlCategory release];
    [ddlcity release];
    if (self.photo) {
        self.photo=nil;
    }
    [_cellCategory2 release];
    [_buttonSubmit release];
    [_cellPhoto release];
    [super dealloc];
}
@end
