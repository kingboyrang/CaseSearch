//
//  AppDelegate.m
//  CaseSearch
//
//  Created by aJia on 12/11/14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "AppDelegate.h"
#import "AlterMessage.h"
#import "BulletSoapMessage.h"
#import "FileHelper.h"
#import "PushInfo.h"
#import "PushViewController.h"
#import "SoapXmlParseHelper.h"
#import "NetWorkConnection.h"
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

//向apns注册
-(void)AppRegisterApns{
[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
}
-(void)reRegisterApns{
    UserSet *user=[UserSet loadUser];
    if ([user.Flag length]==0) {
        //向apns注册
        [self AppRegisterApns];
    }
}
-(void)asyncCircular{
    if (![NetWorkConnection connectedToNetwork]) {
        return;
    }
    ServiceHelper *helper=[ServiceHelper sharedInstance];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"CircularRoadType",@"name",@"A",@"type", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"CircularLightType",@"name",@"B",@"type", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"CircularEPType",@"name",@"C",@"type", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"CircularTaxType",@"name",@"E",@"type", nil]];
    for (NSDictionary *dic in arr) {
        NSString *soap=[BulletSoapMessage CategoryByCircularSoap:[dic objectForKey:@"type"]];
        ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
        args.methodName=@"GetCategoryByCircular";
        args.soapMessage=soap;
        ASIHTTPRequest *request =[ServiceHelper commonSharedRequest:args];
        [request setUserInfo:[NSDictionary dictionaryWithObject:[dic objectForKey:@"name"] forKey:@"name"]];
        [helper addQueue:request];
    }
    __block NSMutableArray *result=[[NSMutableArray alloc] initWithCapacity:4];
    [helper startQueue:^(NSString *xml, NSDictionary *userInfo) {
        
        NSString *requestName=[userInfo objectForKey:@"name"];
        if ([xml length]>0&&result) {
            [result addObject:[NSDictionary dictionaryWithObjectsAndKeys:xml,requestName, nil]];
            
        }
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        
    } complete:^{
        if ([result count]>0) {
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (NSDictionary *item in result) {
                if ([item count]>0) {
                    NSString *key=[[item allKeys] objectAtIndex:0];
                    NSMutableArray *value=[SoapXmlParseHelper TwoLevelXmlToArray:[item objectForKey:key]];
                    if([value count]>0){
                        [dic setValue:value forKey:key];
                    }
                    
                }
                
            }
            if ([dic count]>0) {
                [FileHelper ContentToFile:dic withFileName:@"CircleType.plist"];
            }
        }
        
    }];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.applicationIconBadgeNumber=0;
    //UIBarButtonItem按钮背景色
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor colorWithRed:0.36 green:0.64 blue:0.36 alpha:1.0]];
    // Override point for customization after application launch.
    
    //默认把案件类别写到文件中
    [self asyncCircular];
    //向apns注册
    [self AppRegisterApns];
   /*****远程通知启动****/
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo)
    {
        [self pushHandler:userInfo];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   [self reRegisterApns];
    //默认把案件类别写到文件中
    //[appSystem startRequestQueue];
     [self asyncCircular];
    /****
    //删除50笔推播资料
    NSMutableArray *arr=[AppSystem fileNameToPush];
    if ([arr count]>50) {
        [arr removeObjectsInRange:NSMakeRange(0, 50)];
        [FileHelper ContentToFile:arr withFileName:@"Push.plist"];//写入文件中
    }
     ****/
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
    
       
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - APNS 回傳結果

// 成功取得設備編號token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *deviceId = [[deviceToken description]
                          substringWithRange:NSMakeRange(1, [[deviceToken description] length]-2)];
    deviceId = [deviceId stringByReplacingOccurrencesOfString:@" " withString:@""];
    deviceId = [deviceId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    //把token保存到本地文件中
    UserSet *user=[UserSet loadUser];
    user.Flag=deviceId;
    if ([user.GUID length]==0) {
        user.GUID=[[UIDevice currentDevice] uniqueDeviceIdentifier];
    }
    [UserSet save:user];
    //把token写到数据库中
    NSString *soapMsg=[BulletSoapMessage GCMRegisterSoap:deviceId AppCode:user.GUID];
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"GCMRegister";
    args.soapMessage=soapMsg;
    [[ServiceHelper sharedInstance] asynService:args completed:^(NSString *xml) {
        if ([xml isEqualToString:@"true"]) {
            isFirst=YES;
        }else{
            [self reRegisterApns];
        }
    } failed:^(NSError *error) {
        [self reRegisterApns];
    }];
    
}
//获取接收的推播信息
- (void) application:(UIApplication *) app didReceiveRemoteNotification:(NSDictionary *) userInfo {
    //把icon上的标记数字设置为0,
    //app.applicationIconBadgeNumber = 0;
    //[AlterMessage initWithMessage:[NSString stringWithFormat:@"%@",userInfo]];
    [self pushHandler:userInfo];
}

// 或無法取得設備編號token
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
   //表示信息推播失败
}
//推播处理
-(void)pushHandler:(NSDictionary*)userInfo{
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
        NSString *post=[userInfo objectForKey:@"content"];
        NSDictionary *dic=[PushInfo PushCheckStringToDictionary:post];
        
        if (![[dic objectForKey:@"Type"] isEqualToString:@"9"]){
            NSMutableDictionary *detailDic=[NSMutableDictionary dictionaryWithDictionary:dic];
            //文件写入
            [PushInfo writeToPushFile:detailDic];
        }
        
        //return;
        //NSNotification *notification = [NSNotification notificationWithName:@"pushDetail" object:nil userInfo:dic];
        //[[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:NO];
        //NSString *soapMsg=[BulletSoapMessage PushInfoSoap:[dic objectForKey:@"GUID"]];
        //[helper AsyTraditionalServiceMethod:@"GetPushInfo" SoapMessage:soapMsg];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushDetail" object:self userInfo:dic];
    }
}
@end
