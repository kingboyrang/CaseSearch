//
//  appSet.h
//  CaseSearch
//
//  Created by rang on 13-4-22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSet : NSObject<NSCoding>
@property(nonatomic,copy) NSString *GUID;//手机唯一码
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,copy) NSString *Nick;
@property(nonatomic,copy) NSString *Mobile;
@property(nonatomic,copy) NSString *Email;
@property(nonatomic,copy) NSString *Flag;//推播Token
@property(nonatomic,assign) BOOL isSync;//判断是否已同步

+(void)save:(UserSet*)app;
+(UserSet*)loadUser;
+(UserSet*)systemUser;
+(NSString*)ObjectToXml;
@end