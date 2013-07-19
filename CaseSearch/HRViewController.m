//
//  HRViewController.m
//  CaseSearch
//
//  Created by rang on 13-4-15.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "HRViewController.h"
#import "AlterMessage.h"
#import "CircularHR.h"
@interface HRViewController ()
-(BOOL)isVerify;
-(BOOL)validateEmail:(NSString *)email;
@end

@implementation HRViewController
@synthesize ddlApplyItem,hrBirth,hrMarray,hrDie;
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
    //返回按钮
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    CGFloat leftX=10;
    if ([AppSystem isIPad]) {
        leftX=239;
    }
    
    //申办项目
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"value",@"出生登記",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"value",@"結婚登記",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"value",@"死亡登記",@"key", nil]];
    self.ddlApplyItem=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX, 3, 290, 30)];
    self.ddlApplyItem.delegate=self;
    [self.ddlApplyItem setDataSourceForArray:arr dataTextName:@"key" dataValueName:@"value"];
    self.ddlApplyItem.popoverView.popoverTitle=@"申辦項目";
    self.ddlApplyItem.popoverView.clearButtonTitle=@"關閉";
    [self.ddlApplyItem setIndex:0];
    [self.cellItem.contentView addSubview:self.ddlApplyItem];
    
   
    
    //email赋值
    UserSet *user=[UserSet loadUser];
    self.txtApplyEmail.text=user.Email;
    
    leftX=(self.view.frame.size.width-320)/2;
    if([AppSystem isIPad]){
        leftX=230;
    }
   
    //表示默认选中的是出生登记
    orginItem=1;
   //出生登记
    self.hrBirth=[[HRBirthView alloc] initWithNibName:@"HRBirthView" bundle:[NSBundle mainBundle]];
    self.hrBirth.view.frame=CGRectMake(leftX,0,320, 289);
    [self.cellBirth addSubview:self.hrBirth.view];
    
    //结婚登记
    self.hrMarray=[[HRMarryView alloc] initWithNibName:@"HRMarryView" bundle:[NSBundle mainBundle]];
    self.hrMarray.view.frame=CGRectMake(leftX, 0, 320, 410);
    self.cellMarry.hidden=YES;
    [self.cellMarry addSubview:self.hrMarray.view];
    
    //死亡登记
    self.hrDie=[[HRDieView alloc] initWithNibName:@"HRDieView" bundle:[NSBundle mainBundle]];
    self.hrDie.view.frame=CGRectMake(leftX, 0, 320, 382);
    self.cellDie.hidden=YES;
    [self.cellDie addSubview:self.hrDie.view];
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
#pragma mark -
#pragma mark ServiceHelperDelegate Methods
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
#pragma mark -
#pragma mark 私有方法
-(BOOL)isVerify{
    int i=[self.ddlApplyItem.value intValue];
    if (i==1) {
        if (![self.hrBirth isVerify]) {
            return NO;
        }
    }else if(i==2){
        if (![self.hrMarray isVerify]) {
            return NO;
        }
    }else{
        if (![self.hrDie isVerify]) {
            return NO;
        }
    }
    if ([self.txtApplyName.text length]==0) {
        [AlterMessage initWithMessage:@"申請人姓名不為空!"];
        return NO;
    }
    if ([self.txtApplyAddress.text length]==0) {
        [AlterMessage initWithMessage:@"申請人地址不為空!"];
        return NO;
    }
    if ([self.txtApplyMobile.text length]==0&&[self.txtApplyTel.text length]==0) {
        [AlterMessage initWithMessage:@"請在市內電話或手機中填寫一項!"];
        return NO;
    }
    
    if ([self.txtApplyEmail.text length]>0) {
        if (![self validateEmail:self.txtApplyEmail.text]) {
            [AlterMessage initWithMessage:@"郵件地址格式錯誤!"];
            return NO;
        }
    }
    
    if ([self.txtPWD.text length]==0) {
        [AlterMessage initWithMessage:@"案件密碼不為空!"];
        return NO;
    }
    return YES;
}
-(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark -
#pragma mark CVUISelectDelegate Methods
-(void)doneChooseItem:(id)sender{
    CVUISelect *select=(CVUISelect*)sender;
    int current=[[select value] intValue];
    if (current!=orginItem) {
        orginItem=current;
        NSIndexPath *indexPath,*indexPath2;
        CGRect orginSize;
        if (current==1) {
            self.cellBirth.hidden=NO;
            self.cellMarry.hidden=YES;
            self.cellDie.hidden=YES;
            
            orginSize=self.cellBirth.frame;
            orginSize.size.height=289;
            self.cellBirth.frame=orginSize;
            
            indexPath=[self.tableView indexPathForCell:self.cellMarry];
            indexPath2=[self.tableView indexPathForCell:self.cellDie];
            
        }
        if (current==2) {
            self.cellBirth.hidden=YES;
            self.cellMarry.hidden=NO;
            self.cellDie.hidden=YES;
            
            orginSize=self.cellMarry.frame;
            orginSize.size.height=410;
            self.cellMarry.frame=orginSize;
            
            indexPath=[self.tableView indexPathForCell:self.cellBirth];
            indexPath2=[self.tableView indexPathForCell:self.cellDie];
           
        }
        if (current==3) {
            self.cellBirth.hidden=YES;
            self.cellMarry.hidden=YES;
            self.cellDie.hidden=NO;
            indexPath=[self.tableView indexPathForCell:self.cellBirth];
            indexPath2=[self.tableView indexPathForCell:self.cellMarry];
            
            orginSize=self.cellDie.frame;
            orginSize.size.height=382;
            self.cellDie.frame=orginSize;
            
        }
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath2];
        [self.tableView reloadData];
   }
   
}
-(void)closeSelect:(id)sender{
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell.hidden) {
        return 0;
    }
    return cell.frame.size.height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    [ddlApplyItem release];
    [_cellItem release];
    [hrBirth release];
    [hrMarray release];
    [hrDie release];
    [_cellBirth release];
    [_cellMarry release];
    [_cellDie release];
    [_txtApplyName release];
    [_txtApplyAddress release];
    [_txtApplyTel release];
    [_txtApplyMobile release];
    [_txtApplyEmail release];
    [_txtApplyMemo release];
    [_txtPWD release];
    [_buttonSubmit release];
    [super dealloc];
}
//提交
- (IBAction)buttonSubmit:(id)sender {
    if (![self isVerify]) {
        return;
    }
    if (![NetWorkConnection connectedToNetwork]) {
        [self showNetWork];
        return;
    }
    CircularHR *hr=[[[CircularHR alloc] init] autorelease];
    hr.Category=[self.ddlApplyItem value];
    
    if (orginItem==1) {
        hr.ChildRelation=[self.hrBirth.ddlRelative value];
        hr.Ctiy=[self.hrBirth.ddlCategory value];
    }
    if (orginItem==2) {
        hr.ManName=self.hrMarray.boyName.text;
        hr.WomanName=self.hrMarray.girlName.text;
        hr.ManAddress=self.hrMarray.boyAddress.text;
        hr.WomanAddress=self.hrMarray.girlAddress.text;
        hr.Ctiy=[self.hrMarray.ddlCategory value];
    }
    if (orginItem==3) {
        hr.DeathRelation=[self.hrDie.ddlRelative value];
        hr.Ctiy=[self.hrDie.ddlCategory value];
        hr.DeathName=self.hrDie.txtDieName.text;
        hr.DeathAddress=self.hrDie.txtDieAddress.text;
    }
    hr.Name=self.txtApplyName.text;
    hr.Address=self.txtApplyAddress.text;
    hr.Mobile=self.txtApplyMobile.text;
    hr.Phone=self.txtApplyTel.text;
    hr.Email=self.txtApplyEmail.text;
    hr.Memo=self.txtApplyMemo.text;
    hr.PWD=self.txtPWD.text;
    self.buttonSubmit.enabled=NO;
    NSString *soapMsg=[hr ObjectSeriationToString];
    //NSLog(@"soap=%@\n",soapMsg);
    [self show:@"submit..."];
    
    [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"AddCircular" soapMessage:soapMsg] delegate:self];
}

- (IBAction)textExitToEdit:(id)sender {
    [sender resignFirstResponder];
}
@end
