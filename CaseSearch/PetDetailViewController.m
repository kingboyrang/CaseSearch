//
//  PetDetailViewController.m
//  CaseSearch
//
//  Created by aJia on 12/12/7.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "PetDetailViewController.h"
#import "BulletSoapMessage.h"
#import "CircularPet.h"
#import "SoapXmlParseHelper.h"
#import "ImageScrollViewController.h"
@interface PetDetailViewController ()
-(void)handlerXml:(NSString*)xml;
@end

@implementation PetDetailViewController
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 私有方法
-(void)handlerXml:(NSString*)xml{
    CircularPet *road=[SoapXmlParseHelper RootNodeToObject:xml className:@"CircularPet"];
    [self autolabelSize:self.cellBulletNO withText:road.Number];
    [self autolabelSize:self.cellBulletDate withText:[road BulletinDate]];
    [self autolabelSize:self.cellStatus withText:[road ApprovalStatusText]];
    if ([road.ApprovalMemo length]>0) {
        [self autolabelSize:self.cellHandlerStatus withText:road.ApprovalMemo];
    }else{
        self.cellHandlerStatus.hidden=YES;
        self.cellHandlerStatus.frame=CGRectMake(0, 0, 0, 0);
    }
    
    [self autolabelSize:self.cellPetName withText:road.PetName];
    [self autolabelSize:self.cellPetType withText:road.PetType];
    [self autolabelSize:self.cellPetAge withText:road.PetAge];
    
    [self autolabelSize:self.cellPetSex withText:road.PetSex];
    [self autolabelSize:self.cellPetNeutered withText:road.PetNeutered];
    [self autolabelSize:self.cellPetFeature withText:road.PetFeature];
    
    [self autolabelSize:self.cellChip withText:[road ChipText]];
    
    //[self autolabelSize:self.cellLocation withText:[road AwayLocation]];
    [self autolabelSize:self.cellLocation withText:road.Location];
    
    [self autolabelSize:self.cellAwayDate withText:[road formatAwayDate]];
    [self autolabelSize:self.cellMemo withText:road.Memo];
    
    [self autolabelSize:self.cellContact withText:road.Contact];
    //cellChip
    
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
    [_cellPetName release];
    [_cellPetType release];
    [_cellPetAge release];
    [_cellPetSex release];
    [_cellPetNeutered release];
    [_cellPetFeature release];
    [_cellChip release];
    [_cellLocation release];
    [_cellAwayDate release];
    [_cellMemo release];
    [ItemCircular release];
    [CircularPWD release];
    [_cellImages release];
    [_cellBulletDate release];
    [_cellStatus release];
    [_cellHandlerStatus release];
    [_cellBulletNO release];
    [_cellContact release];
    [super dealloc];
}
@end
