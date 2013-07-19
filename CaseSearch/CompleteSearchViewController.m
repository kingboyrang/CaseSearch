//
//  CompleteSearchViewController.m
//  CaseSearch
//
//  Created by rang on 12-11-14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "CompleteSearchViewController.h"
#import "NSDate+DateExtension.h"
#import "AlterMessage.h"
#import "CircularType.h"
#import "BulletSoapMessage.h"
#import "CircularDetail.h"
@interface CompleteSearchViewController ()
-(void)handler:(NSString*)xml;
@end

@implementation CompleteSearchViewController
@synthesize listData,bdate,edate,ddlCategory,ddlCity;
@synthesize segmentData,tableView,refreshing;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //self.navTitle.backgroundColor=[UIColor darkGrayColor];
    CGRect bounds = CGRectMake(0, 139, self.view.frame.size.width, self.view.frame.size.height-139);
    
    self.tableView = [[PullingRefreshTableView alloc] initWithFrame:bounds pullingDelegate:self];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setAutoresizesSubviews:YES];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:self.tableView];

    
   
    
    NSString *segPath=[[NSBundle mainBundle] pathForResource:@"Segment" ofType:@"plist"];
    self.segmentData=[NSDictionary dictionaryWithContentsOfFile:segPath];
    
    //设置内页logo
    [self.navigationItem titleViewBackground];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] CustomViewButtonItem:@"返回" target:self action:@selector(btnBackClick:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    [leftButton release];
    
    CGFloat h=31;
    CGFloat w=(132*h)/67;
    
    UIImage *leftImage=[[UIImage imageNamed:@"search.png"] imageByScalingToSize:CGSizeMake(w, h)];
    UIButton *customBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customBackButton.frame=CGRectMake(0, 0, w, h);
    [customBackButton setBackgroundImage:leftImage forState:UIControlStateNormal];
    [customBackButton addTarget:self action:@selector(btnSearchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:customBackButton];
    self.navigationItem.rightBarButtonItem =rightBtn;
    [rightBtn release];
    
    CGFloat leftX=0;
    if ([AppSystem isIPad]) {
        leftX=226;
    }
    
    //开始时间
    self.bdate=[[CVUICalendar alloc] initWithFrame:CGRectMake(43+leftX, 107, 124, 31)];
	self.bdate.popoverText.popoverTextField.placeholder=@"開始時間";
    self.bdate.popoverView.popoverTitle=@"開始時間";
    self.bdate.datePicker.maximumDate=[NSDate date];
	[self.view addSubview:self.bdate];
	//结束时间
	self.edate=[[CVUICalendar alloc] initWithFrame:CGRectMake(184+leftX, 106, 124, 31)];
	self.edate.popoverText.popoverTextField.placeholder=@"結束時間";
    self.edate.popoverView.popoverTitle=@"結束時間";
     self.edate.datePicker.maximumDate=[NSDate date];
	[self.view addSubview:self.edate];
        
    
    NSMutableArray *funArr=[NSMutableArray array];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"key",@"",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"路平報修",@"key",@"A",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"路燈報修",@"key",@"B",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"環保查報",@"key",@"C",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"寵物協尋",@"key",@"D",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"稅務預約",@"key",@"E",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"戶政預約",@"key",@"F",@"value", nil]];
    //分类
    self.ddlCategory=[[CVUISelect alloc] initWithFrame:CGRectMake(45+leftX,74,112, 31)];
    [self.ddlCategory setDataSourceForArray:funArr dataTextName:@"key" dataValueName:@"value"];
	self.ddlCategory.popoverText.popoverTextField.placeholder=@"全部";
    self.ddlCategory.popoverView.popoverTitle=@"案件分類";
	[self.view addSubview:self.ddlCategory];//根視圖新增子視圖

	//乡镇
	NSString *cityPath=[[NSBundle mainBundle] pathForResource:@"village" ofType:@"plist"];
    NSMutableArray *villageSource=[NSMutableArray arrayWithContentsOfFile:cityPath];
    [villageSource insertObject:@"全部" atIndex:0];
	self.ddlCity=[[CVUISelect alloc] initWithFrame:CGRectMake(194+leftX,74,114, 31)];
	self.ddlCity.popoverText.popoverTextField.placeholder=@"全部";
    self.ddlCity.popoverView.popoverTitle=@"鄉鎮";
    [self.ddlCity setDataSourceForArray:villageSource];
	[self.view addSubview:self.ddlCity];//根視圖新增子視圖

   
    
    vCircular=[[VCircular alloc] init];
    maxPage=1;
    args=[[VCircularSearchArgs alloc] init];
    args.CurPage=0;
    args.CurSize=20;
    //args.SDate=[self getMonthBeginAndEndWith];
    //NSDate *todayDate=[NSDate date];
    //args.EDate=[NSDate stringFromDate:todayDate withFormat:@"yyyy-MM-dd"];
    
     isFirstLoad=YES;
    
    if (args.CurPage ==0) {
        //第1次加载执时[下拉加载]
        [self.tableView launchRefreshing];//默认加载10笔数据
    }

    
}
//加载查询参数
-(void)reloadSearchArgs{
    args.Category=[self.ddlCategory value];
    args.Ctiy=[self.ddlCity value];
    args.SDate=self.bdate.popoverText.popoverTextField.text;
    args.EDate=self.edate.popoverText.popoverTextField.text;
    args.Number=[self.txtCaseNO.text Trim];
}
//搜寻
-(void)btnSearchClick:(id)sender{
    if ([self.bdate.popoverText.popoverTextField.text length]>0&&[self.edate.popoverText.popoverTextField.text length]>0){
        if ([NSDate CompareToDateString:self.bdate.popoverText.popoverTextField.text compareDate:self.edate.popoverText.popoverTextField.text]) {
            [AlterMessage initWithMessage:@"開始時間不能大於結束時間!"];
            return;
        }
    }
	args.CurPage=0;
    maxPage=1;
	[self.listData removeAllObjects];
    isFirstLoad=YES;
    
    if (args.CurPage ==0) {
        //第1次加载执时[下拉加载]
        [self.tableView launchRefreshing];//默认加载10笔数据
    }
}
//开始查询
-(void)startAsyLoad{
    [self reloadSearchArgs];//获取查询参数
    NSString *soapMsg=[args ObjectSeriationToString];
    

    [[ServiceHelper sharedInstance] asynService:[ServiceArgs serviceMethodName:@"SearchCircular" soapMessage:soapMsg] completed:^(NSString *xml) {
        [self handler:xml];
    } failed:^(NSError *error) {
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"沒有返回數據!"];
        self.tableView.reachedTheEnd  = NO;
        args.CurPage--;
    }];
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

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellCompCircularIdentifier";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    for (UIView *subView in [cell.contentView subviews]) {
        [subView removeFromSuperview];
    }
    cell.textLabel.text=@"";
    
       
            VCircular *item=(VCircular*)[self.listData objectAtIndex:indexPath.row];
            CGRect detailRect=CGRectMake(0, 0,self.view.frame.size.width-29, 65);
            NSString *strIndex=[NSString stringWithFormat:@"%d.",indexPath.row+1];
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
		 return 65.0;
}
- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:indexPath animated:YES];
   
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
                NSDictionary *dic=[self.segmentData objectForKey:@"CompleteSearchViewController"];
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
        
        [self startAsyLoad];//加载
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
    [tableView release];
    [_txtCaseNO release];
    [super dealloc];
    [bdate release];
	[edate release];
	[ddlCity release];
	[listData release];
    [ddlCategory release];
    [args release];
    [vCircular release];
    [segmentData release];
}
- (IBAction)buttonCaseNumExit:(id)sender {
    [sender resignFirstResponder];
}
@end
