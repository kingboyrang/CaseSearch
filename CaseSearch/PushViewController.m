//
//  PushViewController.m
//  CaseSearch
//
//  Created by aJia on 12/11/26.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "PushViewController.h"
#import "FileHelper.h"
#import "PushInfo.h"
#import "AlterMessage.h"
#import "ServiceHelper.h"
#import "BulletSoapMessage.h"
#import "SoapXmlParseHelper.h"
@interface PushViewController ()

@end

@implementation PushViewController
@synthesize listData;
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
    
    [self updatePushData];
    
   
}
-(void)updatePushData{
    NSMutableArray *arr=[AppSystem fileNameToPush];
    //排序
    NSSortDescriptor *_sorter  = [[NSSortDescriptor alloc] initWithKey:@"Created" ascending:NO];
    NSArray *sortArr=[arr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:_sorter, nil]];
    self.listData=[NSMutableArray array];
    [self.listData addObjectsFromArray:sortArr];
    [_sorter release];
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    self.tableView.bounces=NO;
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    /***
    NSString *soapMsg=[BulletSoapMessage PushInfoSoap:@"5dc97f17-d9d8-4f5f-bb04-86987f7b2a0e"];
   __block ASIHTTPRequest *request=[ServiceHelper SharedRequestMethod:@"GetPushInfo" SoapMessage:soapMsg];
    [request setCompletionBlock:^{
        NSString *xml =[SoapXmlParseHelper SoapMessageResultXml:[request responseString] ServiceMethodName:@"GetPushInfo"];
        
        NSMutableDictionary *dic=[PushInfo PushToDictionary:xml];
        //[AlterMessage initWithMessage:[NSString stringWithFormat:@"%@",dic]];
        if([dic count]>0){
            NSLog(@"success\n");
            //文件写入
            [PushInfo writeToPushFile:dic];
        }else{
            [AlterMessage initWithMessage:@"資料加載失敗！"];
        }
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"error=%@\n",[error description]);
    }];
    [request startAsynchronous];
    ***/
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
//如果还要传值，可以再这处理
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destination = segue.destinationViewController;
    //NSString *guid=[[self.listData objectAtIndex:selectRow] objectForKey:@"GUID"];
    //[destination setValue:@"5dc97f17-d9d8-4f5f-bb04-86987f7b2a0e" forKey:@"GUID"];
    [destination setValue:[self.listData objectAtIndex:selectRow] forKey:@"ItemData"];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.listData count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    for (UIView *subView in [cell.contentView subviews]) {
        [subView removeFromSuperview];
    }
    cell.textLabel.text=@"";
    cell.detailTextLabel.text=@"";
    if (indexPath.row==0) {
        UIView *navView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        navView.backgroundColor=[UIColor darkGrayColor];
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(1, 4, 161, 21)];
        lab.font=[UIFont boldSystemFontOfSize:17];
        lab.textColor=[UIColor whiteColor];
        lab.text=@"首頁 > 推播訊息中心";
        lab.backgroundColor=[UIColor clearColor];
        [navView addSubview:lab];
        [cell.contentView addSubview:navView];
        [lab release];
        [navView release];
    }else{
        NSDictionary *item=[self.listData objectAtIndex:indexPath.row-1];
        if ([item objectForKey:@"Number"]!=nil) {//表示结案通知
            cell.textLabel.text=[NSString stringWithFormat:@"%@結案通知",[item objectForKey:@"Number"]];
        }else{
          cell.textLabel.text=[item objectForKey:@"Title"];
        }
        
    //cell.textLabel.numberOfLines=0;
        //cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.detailTextLabel.text=[PushInfo formatCreateTime:[item objectForKey:@"Created"]];//Created
    }
    // Configure the cell...
    
    return cell;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    if(indexPath.row==0)return 30;
    return 40;
    //UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //return cell.frame.size.height;

    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{     if (indexPath.row == 0)
       {
           return NO;
       }
    return YES;
}
//设置编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
    //return UITableViewCellEditingStyleInsert;
}
//默认编辑模式为删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger deleteRow=indexPath.row;
    [AlterMessage showConfirmAndCancel:@"提示" withMessage:@"確定是否刪除?" cancelMessage:@"取消" confirmMessage:@"確定" cancelAction:nil confirmAction:^(){
        //删除绑定数据
        [self.listData removeObjectAtIndex:deleteRow];
        //重新写入文件中
        [FileHelper ContentToFile:self.listData withFileName:@"Push.plist"];
        //行的删除
        NSMutableArray *indexPaths = [NSMutableArray array];
        [indexPaths addObject:[NSIndexPath indexPathForRow:deleteRow inSection:0]];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
        [AlterMessage initWithMessage:@"刪除成功!"];
    }];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row>0) {
        selectRow=indexPath.row-1;
        [self performSegueWithIdentifier:@"goPushDetail" sender:self];
    }
}
-(void)dealloc{
    [super dealloc];
    [listData release];
}
//删除操作
- (IBAction)buttonEditClick:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
	if(self.tableView.editing)
		[self.navigationItem.rightBarButtonItem setTitle:@"Done"];
	else {
		[self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
	}
}
@end
