//
//  HRBirthView.m
//  CaseSearch
//
//  Created by rang on 13-4-16.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "HRBirthView.h"
#import "AlterMessage.h"
@interface HRBirthView()
-(void)bindRelative;
@end
@implementation HRBirthView
@synthesize ddlRelative,ddlCategory;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self bindRelative];        
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)isVerify{
    if ([self.ddlRelative.key length]==0) {
        [AlterMessage initWithMessage:@"請選擇申請人與新生兒之關係!"];
        return NO;
    }
    if ([self.ddlCategory.key length]==0) {
        [AlterMessage initWithMessage:@"請選擇新生兒預約設籍之戶政事務所!"];
        return NO;
    }
    return  YES;
}
#pragma mark -
#pragma mark 私有方法
-(void)bindRelative{
    if (self.ddlRelative&&self.ddlCategory) {
        return;
        
    }

    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"父母",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"祖父母",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"戶長", @"key",nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"同居人",@"key", nil]];
    self.ddlRelative=[[CVUISelect alloc] initWithFrame:CGRectMake(10, 191, 290, 30)];
    [self.ddlRelative setDataSourceForArray:arr dataTextName:@"key" dataValueName:@"key"];
    self.ddlRelative.popoverView.popoverTitle=@"申請人與新生兒之關係";
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
    self.ddlCategory=[[CVUISelect alloc] initWithFrame:CGRectMake(10, 254, 290, 30)];
    [self.ddlCategory setDataSourceForArray:source dataTextName:@"key" dataValueName:@"key"];
    self.ddlCategory.popoverView.popoverTitle=@"新生兒預約設籍之戶政事務所";
    [self.view addSubview:self.ddlCategory];
}
/***
 宜蘭市
 羅東鎮
 南澳鄉
 礁溪鄉
 冬山鄉
 大同鄉
 壯圍鄉
 員山鄉
 五結鄉
 三星鄉
 蘇澳鎮
 頭城鎮 ***/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [ddlRelative release];
    [ddlCategory release];
    [super dealloc];
}
@end
