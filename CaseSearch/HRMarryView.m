//
//  HRMarryView.m
//  CaseSearch
//
//  Created by rang on 13-4-16.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "HRMarryView.h"
#import "AlterMessage.h"
@interface HRMarryView ()

@end

@implementation HRMarryView
@synthesize ddlCategory;
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
    self.ddlCategory=[[CVUISelect alloc] initWithFrame:CGRectMake(10, 149, 290, 30)];
    [self.ddlCategory setDataSourceForArray:source dataTextName:@"key" dataValueName:@"key"];
    self.ddlCategory.popoverView.popoverTitle=@"戶政事務所";
    [self.view addSubview:self.ddlCategory];

	// Do any additional setup after loading the view.
}
-(BOOL)isVerify{
    if ([self.ddlCategory.key length]==0) {
        [AlterMessage initWithMessage:@"請選擇新生兒預約設籍之戶政事務所!"];
        return NO;
    }
    if ([self.boyName.text length]==0) {
        [AlterMessage initWithMessage:@"結婚男生姓名不為空!"];
        return NO;
    }
    if ([self.girlName.text length]==0) {
        [AlterMessage initWithMessage:@"結婚女生姓名不為空!"];
        return NO;
    }
    if ([self.boyAddress.text length]==0) {
        [AlterMessage initWithMessage:@"結婚男住址不為空!"];
        return NO;
    }
    if ([self.girlAddress.text length]==0) {
        [AlterMessage initWithMessage:@"結婚女住址不為空!"];
        return NO;
    }

    return  YES;
}

- (IBAction)buttonExitToEditor:(id)sender {
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [ddlCategory release];
    [_boyName release];
    [_girlName release];
    [_boyAddress release];
    [_girlAddress release];
    [super dealloc];
}
@end
