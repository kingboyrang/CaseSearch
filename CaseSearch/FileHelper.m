//
//  FileHelper.m
//  CaseSearch
//
//  Created by rang on 12-11-14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "FileHelper.h"
#import "AlterMessage.h"
@implementation FileHelper
//資料存放路徑
+(NSString*)fileSavePath:(NSString*)fileName{
	/*取得行動裝置的檔案存放位置*/
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *savePath=[documentsDirectory stringByAppendingPathComponent:fileName];
    
	return savePath;
}
+(BOOL)isExistsFile:(NSString*)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL b=[fileManager fileExistsAtPath:fileName];
	[fileManager release];
	return b;
    /**
    NSString *filepath=[self fileSavePath:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL b=[fileManager fileExistsAtPath:filepath];
	[fileManager release];
	return b;
     **/
}

+(void)ContentToFile:(id)content withFileName:(NSString*)fileName{
    NSString *errStr=nil;
	NSData *data=[NSPropertyListSerialization dataFromPropertyList:content format:NSPropertyListXMLFormat_v1_0 errorDescription:&errStr];
    if(errStr){
        //[AlterMessage initWithMessage:[errStr description]];
    }
	//NSLog(@"error:%@",errStr);
	[data writeToFile:[self fileSavePath:fileName] atomically:YES];
}
@end
