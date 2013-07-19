//
//  HRDetailViewController.m
//  CaseSearch
//
//  Created by rang on 13-4-17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "HRDetailViewController.h"
#import "BulletSoapMessage.h"
#import "SoapXmlParseHelper.h"
#import "CircularHR.h"
@interface HRDetailViewController ()
-(void)handlerXml:(NSString*)xml;
@end

@implementation HRDetailViewController
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
#pragma mark -
#pragma mark 私有方法
-(void)handlerXml:(NSString*)xml{
    CircularHR *road=[SoapXmlParseHelper RootNodeToObject:xml className:@"CircularHR"];
    [self autolabelSize:self.cellCase withText:road.Number];
    [self autolabelSize:self.cellItem withText:road.CategoryText];
    [self autolabelSize:self.cellDate withText:[road BulletinDate]];
    [self autolabelSize:self.cellStatus withText:[road ApprovalStatusText]];
    
    if ([road.ApprovalMemo length]>0) {
        [self autolabelSize:self.cellHandler withText:road.ApprovalMemo];
    }else{
        self.cellHandler.hidden=YES;
        self.cellHandler.frame=CGRectMake(0, 0, 0, 0);
        NSIndexPath *indexPath=[self.tableView indexPathForCell:self.cellHandler];
        [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
    }
    [self autolabelSize:self.cellMemo withText:road.Memo];
    
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    if ([road.Category isEqualToString:@"1"]) {
        [msg appendFormat:@"新生兒預約戶籍之戶政事務所:%@\n",road.Ctiy];
    }
    if ([road.Category isEqualToString:@"2"]) {
        [msg appendFormat:@"預約戶籍地之戶政事務所:%@\n",road.Ctiy];
    }
    if ([road.Category isEqualToString:@"3"]) {
        [msg appendFormat:@"預約戶籍地戶政事務所:%@\n",road.Ctiy];
    }
    [msg appendString:@"申請人聯絡方式:\n"];
    [msg appendFormat:@"申請人姓名:%@\n",road.Name];
    [msg appendFormat:@"申請人地址:%@\n",road.Address];
    [msg appendFormat:@"市內電話:%@\n",road.Phone];
    [msg appendFormat:@"手機:%@\n",road.Mobile];
    [msg appendFormat:@"Email:%@\n",road.Email];
    
    self.txtView.textColor=[UIColor colorWithRed:0.25098 green:0.501961 blue:0 alpha:1];
    self.txtView.text=msg;
    
    [self.tableView reloadData];
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
    [_cellCase release];
    [_cellItem release];
    [_cellDate release];
    [_cellStatus release];
    [_cellHandler release];
    [_cellMemo release];
    [ItemCircular release];
    [CircularPWD release];
    [_txtView release];
    [super dealloc];
}
@end
