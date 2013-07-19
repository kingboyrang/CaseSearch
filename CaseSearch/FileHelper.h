//
//  FileHelper.h
//  CaseSearch
//
//  Created by rang on 12-11-14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject
//取得文件路径
+(NSString*)fileSavePath:(NSString*)fileName;
//判断文件是否存在
+(BOOL)isExistsFile:(NSString*)filepath;
//写内容到文件中
+(void)ContentToFile:(id)content withFileName:(NSString*)fileName;
@end
