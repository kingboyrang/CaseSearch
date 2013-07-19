//
//  TaxDetailViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/7.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "TaxDetailViewController.h"
#import "CircularTax.h"
#import "SoapXmlParseHelper.h"
#import "BulletSoapMessage.h"
@interface TaxDetailViewController ()
-(void)handlerXml:(NSString*)xml;
@end

@implementation TaxDetailViewController
@synthesize ItemCircular,CircularPWD;
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

    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    //隐藏乡镇市别
    self.cellCity.hidden=YES;
    self.cellCity.frame=CGRectMake(0, 0, self.view.frame.size.width, 0);
    
    NSString *soapMsg=[BulletSoapMessage FindCircularSoap:self.ItemCircular.Category withGUID:self.ItemCircular.GUID CasePwd:self.CircularPWD];
   
    [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"FindCircular" soapMessage:soapMsg] completed:^(NSString *xml) {
        [self handlerXml:xml];
    } failed:^(NSError *error) {
        
    }];
    
    
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
#pragma mark 私有方法
-(void)handlerXml:(NSString*)xml{
    //NSLog(@"xml=\n%@\n",xml);
    CircularTax *road=[SoapXmlParseHelper RootNodeToObject:xml className:@"CircularTax"];
    [self autolabelSize:self.cellBulletNO withText:road.Number];
    [self autolabelSize:self.cellCategory withText:[road TypeGuidName]];
    [self autolabelSize:self.cellDate withText:[road BulletinDate]];
    [self autolabelSize:self.cellStatus withText:[road ApprovalStatusText]];
    
    if ([road.ApprovalMemo length]>0) {
        [self autolabelSize:self.cellHandleStatus withText:road.ApprovalMemo];
    }else{
        self.cellHandleStatus.hidden=YES;
        self.cellHandleStatus.frame=CGRectMake(0, 0, 0, 0);
    }
    
    
   
    //[self autolabelSize:self.cellCity withText:road.Ctiy];
    
    [self autolabelSize:self.cellLocation withText:road.Location];
    [self autolabelSize:self.cellMatter withText:road.Memo];
    [self.tableView reloadData];
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
    [_cellCategory release];
    [_cellDate release];
    [_cellStatus release];
    [_cellCity release];
    [_cellLocation release];
    [_cellMatter release];
    [ItemCircular release];
    [CircularPWD release];
    [_cellHandleStatus release];
    [_cellBulletNO release];
    [super dealloc];
}
@end
