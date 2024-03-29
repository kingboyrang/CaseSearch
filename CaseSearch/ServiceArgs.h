//
//  ServiceArgs.h
//  CommonLibrary
//
//  Created by aJia on 13/2/20.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceArgs : NSObject
@property(nonatomic,copy) NSString *serviceURL;
@property(nonatomic,readonly) NSURL *webURL;
@property(nonatomic,copy) NSString *serviceNameSpace;
@property(nonatomic,copy) NSString *methodName;
@property(nonatomic,copy) NSString *soapMessage;
@property(nonatomic,readonly) NSMutableDictionary *headers;
//soapMessage处理
@property(nonatomic,readonly) NSString *defaultSoapMesage;
@property(nonatomic,retain) NSArray *soapParams;
-(NSString*)stringSoapMessage:(NSArray*)params;
+(ServiceArgs*)serviceMethodName:(NSString*)name soapMessage:(NSString*)msg;
@end
