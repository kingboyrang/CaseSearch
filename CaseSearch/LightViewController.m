//
//  LightViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "LightViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AlterMessage.h"
#import "CircularType.h"
#import "RegexKitLite.h"
@interface LightViewController ()

@end

@implementation LightViewController
@synthesize ddlcity,ddlCategory1,ddlCategory2;
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
    
    
    
    //隐藏路灯路编号
    self.cellLightNum.hidden=YES;
    self.cellLightNumValue.hidden=YES;
    NSIndexPath *indexPath1=[self.tableView indexPathForCell:self.cellLightNum];
    NSIndexPath *indexPath2=[self.tableView indexPathForCell:self.cellLightNumValue];
    [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath1];
    [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath2];
    
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
  
    
    light=[[CircularLight alloc] init];
   
    
    self.txtMemo.delegate=self;
    self.txtMemo.layer.borderWidth=1.0;
    self.txtMemo.layer.borderColor=[UIColor grayColor].CGColor;
    self.txtMemo.layer.cornerRadius=5.0;
    
   
    
    CGFloat leftX=10;
    if ([AppSystem isIPad]) {
        leftX=(self.view.frame.size.width-290)/2;
    }
   
    self.ddlCategory1=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX, 3, 290, 31)];
    self.ddlCategory1.delegate=self;
    [self.cellCategory1.contentView addSubview:self.ddlCategory1];
    //绑定数据
    [CircularType asycCircularType:@"B" withDropList:self.ddlCategory1];
    
    self.ddlCategory2=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX, 3, 290, 31)];
    [self.cellCategory2.contentView addSubview:self.ddlCategory2];
    
    //第二层隐藏
    self.cellCategory2.hidden=YES;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:self.cellCategory2];
    [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
    
   CGFloat leftP=0;
    if ([AppSystem isIPad]) {
        leftP=(self.view.frame.size.width-320)/2;
    }
    
    //照片浏览
    self.photo=[[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:[NSBundle mainBundle]];
    self.photo.popController=self;
    self.photo.view.frame=CGRectMake(leftP, 0, 320, 331);
    [self.cellPhoto addSubview:self.photo.view];
    
    
    NSString *cityPath=[[NSBundle mainBundle] pathForResource:@"village" ofType:@"plist"];
	self.ddlcity=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX,3,290, 31)];
	self.ddlcity.popoverText.popoverTextField.placeholder=@"鄉鎮市別";
    self.ddlcity.popoverView.popoverTitle=@"鄉鎮市別";
    [self.ddlcity setDataSourceForArray:[NSArray arrayWithContentsOfFile:cityPath]];
    [self.cellCity.contentView addSubview:self.ddlcity];
    
    //[self showNetWork];
}
//返回
-(void)btnBackClick:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}
//退出编辑
-(IBAction)textEditExitbg:(id)sender{
    [sender resignFirstResponder];
}
//地址与路灯编号选中[当出现路灯编号时，checkbox切换]
-(IBAction)buttonSelectClick:(id)sender{
    UIButton *btn=(UIButton*)sender;
	[btn setSelected:YES];
	int otherTag=61;
	if (btn.tag==61) {
		otherTag=62;
	}
	UIButton *btnSelect=(UIButton*)[self.view viewWithTag:otherTag];
	[btnSelect setSelected:NO];
   
    if ([btn tag]==61) {//不可以编辑
        self.cellAddressMemo.hidden=YES;
        self.cellAddressValue.hidden=YES;
        self.txtAddress.text=@"";
        NSIndexPath *indexPath3=[self.tableView indexPathForCell:self.cellAddressMemo];
        NSIndexPath *indexPath4=[self.tableView indexPathForCell:self.cellAddressValue];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath3];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath4];
        
        self.cellLightNum.hidden=NO;
        self.cellLightNumValue.hidden=NO;
       
        NSIndexPath *indexPath1=[self.tableView indexPathForCell:self.cellLightNum];
        NSIndexPath *indexPath2=[self.tableView indexPathForCell:self.cellLightNumValue];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath1];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath2];
        
        [self.tableView reloadData];
        /***
         [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2, nil] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
         **/

    }else{//现在地址
        self.cellAddressMemo.hidden=NO;
        self.cellAddressValue.hidden=NO;
        
       
        NSIndexPath *indexPath1=[self.tableView indexPathForCell:self.cellAddressMemo];
         NSIndexPath *indexPath2=[self.tableView indexPathForCell:self.cellAddressValue];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath1];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath2];
        
        /***
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2, nil] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
         **/
        
        self.cellLightNum.hidden=YES;
        self.cellLightNumValue.hidden=YES;
        self.txtLightNumber.text=@"";
        NSIndexPath *indexPath3=[self.tableView indexPathForCell:self.cellLightNum];
        NSIndexPath *indexPath4=[self.tableView indexPathForCell:self.cellLightNumValue];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath3];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath4];
        [self.tableView reloadData];
    }
    
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
    if (self.ddlCategory1.isChange) {
    NSString *guid=[self.ddlCategory1 value];
    NSMutableArray *arr=[CircularType ChildsParentType:guid withData:[CircularType CircularLightType]];
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
    if (indexPath.row>=6&&indexPath.row<=9) {
        if (cell.hidden) {
            return 0;
        }else{
            if (indexPath.row==6) {
                return 30;
            }
            if (indexPath.row==8) {
                return 44;
            }
            return 37;
        }
    }
    return cell.frame.size.height;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//提交验证
-(BOOL)formSubmit{
    
    if ([self.ddlCategory1.value length]==0&&[self.ddlCategory2.value length]==0) {
        [AlterMessage initWithMessage:@"請選擇案件分類!"];
        return NO;
    }
    if (self.cellLightNum.hidden) {
        if ([self.txtAddress.text length]==0) {
            [AlterMessage initWithMessage:@"現在地址不為空!"];
            return NO;
        }
    }else{
        if ([self.txtLightNumber.text length]==0) {
            [AlterMessage initWithMessage:@"路燈編號不為空!"];
            return NO;
        }
    }
if ([self.ddlcity.value length]==0) {
    [AlterMessage initWithMessage:@"請選擇鄉鎮市別!"];
    return NO;
}
    /***
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
        strType=[self.ddlCategory1 value];
    }
    light.TypeGuid=strType;
    if ([self.txtMemo.text isEqualToString:@"請按我輸入文字"]) {
        light.Memo=@"";
    }else{
        light.Memo=self.txtMemo.text;
    }
    light.Lat=[NSString stringWithFormat:@"%f",self.place.coordinate.latitude];
    light.Lng=[NSString stringWithFormat:@"%f",self.place.coordinate.longitude];
    light.Ctiy=[self.ddlcity value];
    light.Location=self.txtAddress.text;
    light.PWD=self.txtPWD.text;
    light.Images=[self.photo imageToArray];
    light.LightNumber=self.txtLightNumber.text;
    light.Address=self.txtBulletAddress.text;
    NSString *soapMsg=[light ObjectSeriationToString];
    //NSLog(@"soapMsg=%@\n",soapMsg);
    //[self showHUD:@"submit..."];
    self.buttonSubmit.enabled=NO;
    [self show:@"submit..."];
    [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"AddCircular" soapMessage:soapMsg] delegate:self];
}
#pragma mark -
#pragma mark ServicesHelper delegate Methods
-(void)finishedRequest:(NSString *)xml{
    self.buttonSubmit.enabled=YES;
    if ([xml length]>0) {
        [self showSuccess:@"送出成功!" completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        //[AlterMessage showTipMsg:@"送出成功!" finishAction:^(){
            //[self.navigationController popViewControllerAnimated:YES];
        //}];
    }else{
        
        [self showFailed:@"送出失敗!"];
    }
}
-(void)failedRequest:(NSError *)error{
    self.buttonSubmit.enabled=YES;
    [self showFailed:@"送出失敗!"];
}
- (void)dealloc {
    [light release];
    [_txtPWD release];
    [_txtAddress release];
    [_cellCity release];
    [_txtMemo release];
    [_cellCategory1 release];
    [_cellCategory2 release];
    [ddlcity release];
    [ddlCategory1 release];
    [ddlCategory2 release];
    [_txtLightNumber release];
    [_buttonGps release];
    [_cellLightNum release];
    [_cellLightNumValue release];
    [_cellAddressMemo release];
    [_cellAddressValue release];
    [_txtBulletAddress release];
    [_buttonSubmit release];
    if (self.photo) {
        self.photo=nil;
    }
    [_cellPhoto release];
    [super dealloc];
}
@end
