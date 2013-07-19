//
//  VCircular.h
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//

/// <summary>
/// 所有通報資料的視圖
/// </summary>
#import <Foundation/Foundation.h>
#import "VCircularSearchArgs.h"
@interface VCircular : NSObject
@property(nonatomic,retain) NSString *Category;
@property(nonatomic,retain) NSString *GUID;
//姓名
@property(nonatomic,retain) NSString *Name;
//暱稱
@property(nonatomic,retain) NSString *Nick;
//手機
@property(nonatomic,retain) NSString *Mobile;
//電子郵件
@property(nonatomic,retain) NSString *Email;
//密碼
@property(nonatomic,retain) NSString *PWD;
//类别
@property(nonatomic,retain) NSString *TypeGuid;
//类别名稱
@property(nonatomic,retain) NSString *TypeName;
// 通报日期
@property(nonatomic,retain) NSString *Created;
// 到期日期
@property(nonatomic,retain) NSString *ExecDate;
// 审核时间
@property(nonatomic,retain) NSString *ApprovalDate;
// 审核说明
@property(nonatomic,retain) NSString *ApprovalMemo;
// 审核状态
@property(nonatomic,retain) NSString *ApprovalStatus;
// 处理人变更次数
@property(nonatomic,retain) NSString *AccountChangeNum;
// 处理人
@property(nonatomic,retain) NSString *Account;
// 标志
@property(nonatomic,retain) NSString *Flag;
// 縣市
@property(nonatomic,retain) NSString *Ctiy;
// 编号
@property(nonatomic,retain) NSString *Number;

@property(nonatomic,retain) VCircularSearchArgs *args;
//把时间转换成民国时间
-(NSString*)formatDataTw;
//格式化属性
-(NSString*)formatPropertyString:(NSString*)str;
//获取查询参数
-(NSString*)SearchArgsToSoap;
//获取类别名称
-(NSString*)CategoryName;
//获取案件状态
-(NSString*)ApprovalStatusText;
//xml系列化对象
-(NSMutableArray*)XmlToVCircular:(NSString*)xml withMaxPage:(NSString**)page;
//检查密码是否正确
-(NSString*)CheckPasswordByCircularSoap:(NSString*)type withGUID:(NSString*)guid withPassword:(NSString*)pwd;
@end
