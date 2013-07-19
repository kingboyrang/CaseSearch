//
//  PetViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/5.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "PetViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AlterMessage.h"
#import "RegexKitLite.h"
@interface PetViewController ()

@end

@implementation PetViewController
@synthesize lostDate,ddlcity,ddlPetAge;
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
   
    CGFloat leftX=0;
    if ([AppSystem isIPad]) {
        leftX=(self.view.frame.size.width-320)/2;
    }
    
   
    
    //照片浏览
    self.photo=[[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:[NSBundle mainBundle]];
    self.photo.popController=self;
    self.photo.view.frame=CGRectMake(leftX, 0, 320, 331);
    [self.cellPhoto addSubview:self.photo.view];
    
    //走失时间
    leftX=93;
    if ([AppSystem isIPad]) {
        leftX=324;
    }
    self.lostDate=[[CVUICalendar alloc] initWithFrame:CGRectMake(leftX, 6, 208, 31)];
	self.lostDate.popoverText.popoverTextField.placeholder=@"走失時間";
    self.lostDate.popoverView.popoverTitle=@"走失時間";
    self.lostDate.datePicker.maximumDate=[NSDate date];
	[self.cellDate.contentView addSubview:self.lostDate];
    
    NSString *cityPath=[[NSBundle mainBundle] pathForResource:@"village" ofType:@"plist"];
	self.ddlcity=[[CVUISelect alloc] initWithFrame:CGRectMake(88,6,208, 31)];
	self.ddlcity.popoverText.popoverTextField.placeholder=@"鄉鎮市別";//
    self.ddlcity.popoverView.popoverTitle=@"鄉鎮市別";
	[self.ddlcity setDataSourceForArray:[NSArray arrayWithContentsOfFile:cityPath]];
    [self.cellLocation.contentView addSubview:self.ddlcity];
    //隐藏乡镇市别
    self.ddlcity.hidden=YES;
    
    //年龄
     leftX=81;
    if ([AppSystem isIPad]) {
        leftX=307;
    }
    NSString *agePath=[[NSBundle mainBundle] pathForResource:@"PetAge" ofType:@"plist"];
	self.ddlPetAge=[[CVUISelect alloc] initWithFrame:CGRectMake(leftX,8,221, 31)];
	self.ddlPetAge.popoverText.popoverTextField.placeholder=@"寵物年齡";//
    self.ddlPetAge.popoverView.popoverTitle=@"寵物年齡";
    [self.ddlPetAge setDataSourceForArray:[NSArray arrayWithContentsOfFile:agePath]];
    //[NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:agePath]];
    [self.cellPetAge.contentView addSubview:self.ddlPetAge];

    
    
    pet=[[CircularPet alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    [ddlcity release];
    [lostDate release];
    [_cellDate release];
    [_cellLocation release];
    [_txtPetName release];
    [_txtPetType release];
    [_segPetSex release];
    [_segPetNeutered release];
    [_txtPetFeature release];
    [_segChip release];
    [_txtChipCode release];
    [_txtMemo release];
    [_txtLocation release];
    [_txtPWD release];
    [pet release];
    if (self.photo) {
        self.photo=nil;
    }
    [ddlPetAge release];
    [_cellPetAge release];
    [_txtContact release];
    [_buttonSubmit release];
    [_cellPhoto release];
    [super dealloc];
}
//提交
- (IBAction)buttonSubmitClick:(id)sender {
    if (![self formSubmit]) {
        return;
    }
    if (![NetWorkConnection connectedToNetwork]) {
        [self showNetWork];
        return;
    }
    pet.PetName=self.txtPetName.text;
    pet.PetType=self.txtPetType.text;
    if ([self.ddlPetAge.value length]>0) {
        pet.PetAge=self.ddlPetAge.value;
    }
    if (self.segPetSex.selectedSegmentIndex==0) {
        pet.PetSex=@"公";
    }else{
        pet.PetSex=@"母";
    }
    if (self.segPetNeutered.selectedSegmentIndex==0) {
        pet.PetNeutered=@"是";
    }else{
        pet.PetNeutered=@"否";
    }
    pet.PetFeature=self.txtPetFeature.text;
    if (self.segChip.selectedSegmentIndex==0) {
        pet.Chip=@"無";
    }else{
        pet.Chip=@"有";
    }
    pet.ChipCode=self.txtChipCode.text;
    /**
    if ([self.ddlcity.saveDic count]>0) {
        pet.Ctiy=[[self.ddlcity.saveDic allKeys] objectAtIndex:0];
    }**/
    pet.Ctiy=@"全部";
    pet.Location=self.txtLocation.text;
    pet.AwayDate=self.lostDate.popoverText.popoverTextField.text;
    pet.Memo=self.txtMemo.text;
    pet.Contact=self.txtContact.text;
    pet.PWD=self.txtPWD.text;
    pet.Images=[self.photo imageToArray];
    
    self.buttonSubmit.enabled=NO;
    NSString *soap=[pet ObjectSeriationToString];
    [self show:@"Submit..."];
    
    [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"AddCircular" soapMessage:soap] delegate:self];
    
    //[helper AsyTraditionalServiceMethod:@"AddCircular" SoapMessage:soap];
}
//提交验证
-(BOOL)formSubmit{
    if ([self.txtPetName.text length]==0) {
        [AlterMessage initWithMessage:@"寵物名不為空!"];
        return NO;
    }
    if ([self.txtPetType.text length]==0) {
        [AlterMessage initWithMessage:@"品種不為空!"];
        return NO;
    }
    if ([self.ddlPetAge.value length]==0) {
        [AlterMessage initWithMessage:@"請選擇年齡!"];
        return NO;
    }
    if ([self.txtPetFeature.text length]==0) {
        [AlterMessage initWithMessage:@"特徵不為空!"];
        return NO;
    }
    /***
    if (self.ddlcity.saveDic==nil||[self.ddlcity.saveDic count]==0) {
        [AlterMessage initWithMessage:@"請選擇走失鄉鎮!"];
        return NO;
    }
     **/
    if ([self.txtLocation.text length]==0) {
        [AlterMessage initWithMessage:@"走失地點不為空!"];
        return NO;
    }
    if ([self.lostDate.popoverText.popoverTextField.text length]==0) {
        [AlterMessage initWithMessage:@"走失時間不為空!"];
        return NO;
    }
    if ([self.txtMemo.text length]==0) {
        [AlterMessage initWithMessage:@"主人的話不為空!"];
        return NO;
    }
    
    if ([self.txtPWD.text length]==0) {
		[AlterMessage initWithMessage:@"案件瀏覽密碼不能爲空!"];
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
//有无晶片
- (IBAction)segChipClick:(id)sender {
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    if (segment.selectedSegmentIndex==0) {
        self.txtChipCode.hidden=YES;
        self.txtChipCode.text=@"";
    }else{
        self.txtChipCode.hidden=NO;
    }
}
@end
