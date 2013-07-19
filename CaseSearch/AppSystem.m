//
//  AppSystem.m
//  CaseSearch
//
//  Created by rang on 13-5-6.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "AppSystem.h"
#import "FileHelper.h"
#import "BulletSoapMessage.h"
#import "SoapXmlParseHelper.h"
#import "NetWorkConnection.h"
#import "CustomShowAlert.h"
@implementation AppSystem
//显示一个提示信息
+(void)showAlterTip{
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    CustomShowAlert *showAlert=[[CustomShowAlert alloc] initWithFrame:CGRectMake((screenRect.size.width-300)/2, 0,300, 300)];
    [window addSubview:showAlert];
    [window bringSubviewToFront:showAlert];
    
    [UIView animateWithDuration:0.5 animations:^(){
        CGRect orginRect=showAlert.frame;
        CGRect screenRect=[[UIScreen mainScreen] bounds];
        orginRect.origin.y=(screenRect.size.height-orginRect.size.height)/2;
        showAlert.frame=orginRect;
        [showAlert release];
        
    }];
    
    
}



+(NSMutableDictionary*)fileNameToCircularType{
    NSMutableDictionary *data=[NSMutableDictionary dictionary];
	NSString *documentsPath = [FileHelper fileSavePath:@"CircleType.plist"];
    //NSLog(@"path=%@\n",documentsPath);
	if(![FileHelper isExistsFile:documentsPath])return data;
	data= [[NSMutableDictionary alloc] initWithContentsOfFile:documentsPath];
	return data;
}
+(NSMutableArray*)fileNameToPush{
    NSMutableArray *data=[NSMutableArray array];
	NSString *documentsPath = [FileHelper fileSavePath:@"Push.plist"];
	if(![FileHelper isExistsFile:documentsPath])return data;
	data= [[NSMutableArray alloc] initWithContentsOfFile:documentsPath];
	return data;
}
+(NSString*)infoMessageMemo{
    NSMutableString *body=[NSMutableString stringWithString:@"使用者應載明具體事項、"];
    [body appendString:@"真實姓名及聯絡方式"];
    [body appendString:@"(包括電話、住址或電子郵件位址等)"];
    [body appendString:@"，無具體內容、未具「真實姓名」或「聯絡方式」者，"];
    [body appendString:@"受理機關得依分層負責權限規定，得不予處理。"];
    return [NSString stringWithFormat:@"%@",body];
}
//判断是否为ipad
+(BOOL)isIPad{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}
-(void)dealloc{
    //[circularTypes release];
    [super dealloc];
    
}
@end
