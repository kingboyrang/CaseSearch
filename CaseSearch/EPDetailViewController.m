//
//  EPDetailViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/7.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "EPDetailViewController.h"
#import "BulletSoapMessage.h"
#import "SoapXmlParseHelper.h"
#import "CircularEP.h"
#import "ImageScrollViewController.h"
@interface EPDetailViewController ()
-(void)handlerXml:(NSString*)xml;
@end

@implementation EPDetailViewController
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
    CircularEP *road=[SoapXmlParseHelper RootNodeToObject:xml className:@"CircularEP"];
    [self autolabelSize:self.cellBulltNO withText:road.Number];
    [self autolabelSize:self.cellCategory withText:[road TypeGuidName]];
    [self autolabelSize:self.cellDate withText:[road BulletinDate]];
    [self autolabelSize:self.cellStatus withText:[road ApprovalStatusText]];
    
    if ([road.ApprovalMemo length]>0) {
        [self autolabelSize:self.cellHandlerStatus withText:road.ApprovalMemo];
    }else{
        self.cellHandlerStatus.hidden=YES;
        self.cellHandlerStatus.frame=CGRectMake(0, 0, 0, 0);
    }
    
    
    [self autolabelSize:self.cellMemo withText:road.Memo];
    [self autolabelSize:self.cellCity withText:road.Ctiy];
    
    [self autolabelSize:self.cellAddress withText:road.Location];
    if ([road.Images count]>0) {
        CGRect scrolRect=CGRectMake((self.view.frame.size.width-247)/2, 29,247, 198);
        ImageScrollViewController *imageController=[[ImageScrollViewController alloc] initWithListData:road.Images withFrame:scrolRect];
        [self.cellImages.contentView addSubview:imageController];
        [imageController release];
    }else{
        /**
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, 38.5,250, 150)];
        UIImage *img=[UIImage imageNamed:@"nopic.png"];
        [imgView setImage:img];
        [self.cellImages.contentView addSubview:imgView];
        [imgView release];
         **/
        self.cellImages.hidden=YES;
        self.cellImages.frame=CGRectMake(0, 0, 0, 0);
    }

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
    [CircularPWD release];
    [ItemCircular release];
    [_cellCategory release];
    [_cellDate release];
    [_cellStatus release];
    [_cellHandlerStatus release];
    [_cellMemo release];
    [_cellCity release];
    [_cellAddress release];
    [_cellImages release];
    [_cellBulltNO release];
    [super dealloc];
}
@end
