//
//  MachineSearchViewController.m
//  CaseSearch
//
//  Created by rang on 12-11-14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "MachineSearchViewController.h"
#import "AlterMessage.h"
#import "CircularType.h"
#import "BulletSoapMessage.h"
#import "CircularDetail.h"
@interface MachineSearchViewController ()
-(void)handler:(NSString*)xml;
@end

@implementation MachineSearchViewController
@synthesize listData,segmentData;
@synthesize tableView = _tableView;
@synthesize refreshing;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    
    
    NSString *segPath=[[NSBundle mainBundle] pathForResource:@"Segment" ofType:@"plist"];
    self.segmentData=[[NSDictionary alloc] initWithContentsOfFile:segPath];
    //[NSDictionary dictionaryWithContentsOfFile:segPath];
     
    vCircular=[[VCircular alloc] init];
    isFirstLoad=YES;
    maxPage=1;
    args=[[VCircularSearchArgs alloc] init];
    args.CurPage=0;
    args.CurSize=20;
    
    
    CGRect bounds = CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height-30);
    
    self.tableView = [[PullingRefreshTableView alloc] initWithFrame:bounds pullingDelegate:self];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setAutoresizesSubviews:YES];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:self.tableView];
     
        
    if (args.CurPage ==0) {
        //第1次加载执时[下拉加载]
        [self.tableView launchRefreshing];//默认加载10笔数据
    }
        
    
}
#pragma -
#pragma mark 私有方法
-(void)handler:(NSString*)xml{
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd  = NO;
    NSString *page;
    NSMutableArray *arr=[vCircular XmlToVCircular:xml withMaxPage:&page];
     maxPage=[page intValue];
    if (isFirstLoad) {
        isFirstLoad=NO;
        self.listData=arr;
        [self.tableView reloadData];
    }else{
        NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
        for (int i=0; i<[arr count]; i++) {
            [self.listData addObject:[arr objectAtIndex:i]];
            NSIndexPath *newPath=[NSIndexPath indexPathForRow:(args.CurPage-1)*args.CurSize+i inSection:0];
            [insertIndexPaths addObject:newPath];
        }
        //重新呼叫UITableView的方法, 來生成行.
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
}
//默认加载数据
-(void)startLoadData{
    
    UserSet *user=[UserSet loadUser];
    if ([user.Flag length]>0) {
        args.Flag=user.Flag;
    }else{
        //NSLog(@"4\n");
        //return;
    }
    NSString *soapMsg=[args ObjectSeriationToString];
   // NSLog(@"soapMsg=%@\n",soapMsg);
    [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"SearchCircular" soapMessage:soapMsg] completed:^(NSString *xml) {
        [self handler:xml];
       
        
    } failed:^(NSError *error) {
        
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"沒有返回數據!"];
        self.tableView.reachedTheEnd  = NO;
        args.CurPage--;
        //self.tableView.reachedTheEnd  = YES;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellCircularIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    for (UIView *subView in [cell.contentView subviews]) {
        [subView removeFromSuperview];
    }
    cell.textLabel.text=@"";
    
            VCircular *item=(VCircular*)[self.listData objectAtIndex:indexPath.row];
            CGRect detailRect=CGRectMake(0, 0,self.view.frame.size.width-29, 65);
            NSString *strIndex=[NSString stringWithFormat:@"%d.",indexPath.row];
            CircularDetail *detail=[[CircularDetail alloc] initWithData:item WithIndex:strIndex withFrame:detailRect];
            [cell.contentView addSubview:detail];
            [detail release];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            //UITableViewCellAccessoryDetailDisclosureButton;
           return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
		return 65;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
       
        selectRow=indexPath.row;
		UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"提示" message:nil
													 delegate:self
											cancelButtonTitle:@"取消"
											otherButtonTitles:@"確定",nil];
		UITextField *pwdField=[[UITextField alloc] initWithFrame:CGRectMake(10, 40, 264, 31)];
		pwdField.tag=100;
		pwdField.borderStyle=UITextBorderStyleRoundedRect;
		pwdField.placeholder=@"請輸入案件密碼";
		pwdField.textAlignment=NSTextAlignmentLeft;
        //UITextAlignmentLeft;
		pwdField.secureTextEntry=YES;
		pwdField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
         [pwdField addTarget:self action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
		[alter addSubview:pwdField];
		
		
		
		[pwdField release];
		[alter show];
		[alter release];
	
    //goToDetail
}
#pragma -
#pragma 按return时退出键盘
- (IBAction)textFiledReturnEditing:(id)sender
{
	[sender resignFirstResponder];
}
//如果还要传值，可以再这处理
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destination = segue.destinationViewController;
    [destination setValue:circularPWD forKey:@"CircularPWD"];
    SEL sel=NSSelectorFromString(@"ItemCircular");
    if ([destination respondsToSelector:sel]) {
        [destination setValue:[self.listData objectAtIndex:selectRow] forKey:@"ItemCircular"];
    }
    //[destination setValue:rowGuid forKey:@"GUID"];
    //[destination setValue:rowPwd forKey:@"Password"];
}
#pragma -
#pragma UIAlertView delegate Methods
-(void) willPresentAlertView:(UIAlertView *)alertView{
    alertView.bounds=CGRectMake(alertView.bounds.origin.x, alertView.bounds.origin.y, alertView.bounds.size.width,alertView.bounds.size.height+30);
	for (UIView *v in alertView.subviews) {
		NSString *strV=[NSString stringWithFormat:@"%@",[v class]];
		if ([strV isEqualToString:@"UIAlertButton"]) {
			CGRect rect=v.frame;
			rect.origin.y=40+31+10;
			v.frame=rect;
		}
	}
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
	//確定 ＝1
	if (buttonIndex==1) {//確定
		UITextField *pwdField=(UITextField*)[alertView viewWithTag:100];
		if ([pwdField.text length]==0) {
			[AlterMessage initWithMessage:@"密碼錯誤!"];
		}else {
			VCircular *item=(VCircular*)[self.listData objectAtIndex:selectRow];
			NSString *soapMsg=[vCircular CheckPasswordByCircularSoap:item.Category withGUID:item.GUID withPassword:pwdField.text];
            ServiceArgs *params=[[[ServiceArgs alloc] init] autorelease];
            params.methodName=@"CheckPasswordByCircular";
            params.soapMessage=soapMsg;

            
            NSString *result=[[ServiceHelper sharedInstance] syncService:params];
			if ([result isEqualToString:@"true"]) {
                circularPWD=pwdField.text;
                NSDictionary *dic=[self.segmentData objectForKey:@"MachineSearchViewController"];
                [self performSegueWithIdentifier:[dic objectForKey:item.Category] sender:self];
            }else {
                [AlterMessage initWithMessage:@"密碼錯誤!"];
            }
            
		}
        
	}
	
}
-(void)loadData{
    
    if (self.refreshing) {
        self.refreshing=NO;
    }
    if (![NetWorkConnection connectedToNetwork]){
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"網絡連接失敗!"];
        self.tableView.reachedTheEnd  = NO;
        return;
    }
    if (args.CurPage!=maxPage) {
        args.CurPage++;
        if (args.CurPage>=maxPage) {
            args.CurPage=maxPage;
        }
        
        [self startLoadData];//加载
    }else{
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"下面没有了.."];
        self.tableView.reachedTheEnd  = YES;
         
    }
}

#pragma mark - PullingRefreshTableViewDelegate
//下拉加载
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

//上拉加载
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

-(void)dealloc{
    [super dealloc];
    [listData release];
    [vCircular release];
    [args release];
    [_tableView release];
    if (segmentData!=nil) {
        //[segmentData release];
        segmentData=nil;
    }

}
@end
