//
//  HRDieView.m
//  CaseSearch
//
//  Created by rang on 13-4-16.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "HRDieView.h"
#import "AlterMessage.h"
@interface HRDieView ()

@end

@implementation HRDieView
@synthesize ddlCategory,ddlRelative;
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
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"配偶",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"親屬",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"戶長", @"key",nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"同居人",@"key", nil]];
    self.ddlRelative=[[CVUISelect alloc] initWithFrame:CGRectMake(10, 166, 290, 30)];
    [self.ddlRelative setDataSourceForArray:arr dataTextName:@"key" dataValueName:@"key"];
    self.ddlRelative.popoverView.popoverTitle=@"申請人與往生者之關係";
    [self.view addSubview:self.ddlRelative];
    
    NSMutableArray *source=[NSMutableArray array];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"宜蘭市",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"羅東鎮",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"南澳鄉",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"礁溪鄉",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"冬山鄉",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"大同鄉",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"壯圍鄉",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"員山鄉",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"五結鄉",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"三星鄉",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"蘇澳鎮",@"key", nil]];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"頭城鎮",@"key", nil]];
    self.ddlCategory=[[CVUISelect alloc] initWithFrame:CGRectMake(10, 348, 290, 30)];
    [self.ddlCategory setDataSourceForArray:source dataTextName:@"key" dataValueName:@"key"];
    self.ddlCategory.popoverView.popoverTitle=@"預約戶籍地戶政事務所";
    [self.view addSubview:self.ddlCategory];
	// Do any additional setup after loading the view.
}
-(BOOL)isVerify{
    if ([self.ddlRelative.key length]==0) {
        [AlterMessage initWithMessage:@"請選擇申請人與往生者之關係!"];
        return NO;
    }
    if ([self.ddlCategory.key length]==0) {
        [AlterMessage initWithMessage:@"請選擇預約戶籍地戶政事務所!"];
        return NO;
    }
   
    if ([self.txtDieName.text length]==0) {
        [AlterMessage initWithMessage:@"往生者姓名不為空!"];
        return NO;
    }
    if ([self.txtDieAddress.text length]==0) {
        [AlterMessage initWithMessage:@"往生者戶籍地址不為空!"];
        return NO;
    }
    
    return YES;
}

- (IBAction)buttonExitToEdit:(id)sender {
    [sender resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [ddlCategory release];
    [ddlRelative release];
    [_txtDieName release];
    [_txtDieAddress release];
    [super dealloc];
}
@end
