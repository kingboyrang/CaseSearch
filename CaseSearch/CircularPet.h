//
//  CircularPet.h
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//
/// 寵物協尋
/// A001審核寵物協尋
/// </summary>
#import <Foundation/Foundation.h>

@interface CircularPet : NSObject
// ID
@property(nonatomic,retain) NSString *ID;
// GUID
@property(nonatomic,retain) NSString *GUID;
// 姓名
@property(nonatomic,retain) NSString *Name;
// 昵稱
@property(nonatomic,retain) NSString *Nick;
// 手機
@property(nonatomic,retain) NSString *Mobile;
// 電子郵件
@property(nonatomic,retain) NSString *Email;
// 密碼
@property(nonatomic,retain) NSString *PWD;
// 通报日期
@property(nonatomic,retain) NSString *Created;
// 到期日期
@property(nonatomic,retain) NSString *ExecDate;
// 审核时间
@property(nonatomic,retain) NSString *ApprovalDate;
// 审核说明
@property(nonatomic,retain) NSString *ApprovalMemo;
// 审核状态(1處理中;2已處理)
@property(nonatomic,retain) NSString *ApprovalStatus;
// 处理人
@property(nonatomic,retain) NSString *Account;
// 标志
@property(nonatomic,retain) NSString *Flag;
// 走失地點
@property(nonatomic,retain) NSString *Location;
// 縣市
@property(nonatomic,retain) NSString *Ctiy;
// 主人的話
@property(nonatomic,retain) NSString *Memo;
// 编号
@property(nonatomic,retain) NSString *Number;
// 寵物名
@property(nonatomic,retain) NSString *PetName;
// 品種
@property(nonatomic,retain) NSString *PetType;
// 年齡
@property(nonatomic,retain) NSString *PetAge;
// 絕育
@property(nonatomic,retain) NSString *PetNeutered;
// 性別
@property(nonatomic,retain) NSString *PetSex;
// 特徵
@property(nonatomic,retain) NSString *PetFeature;
// 有无晶片
@property(nonatomic,retain) NSString *Chip;
// 晶片號碼
@property(nonatomic,retain) NSString *ChipCode;
// 走失日期
@property(nonatomic,retain) NSString *AwayDate;
// 聯絡方式
@property(nonatomic,retain) NSString *Contact;

/// <summary>
/// 上傳圖片
/// </summary>
@property(nonatomic,retain) NSMutableArray *UpImages;
// 圖片
@property(nonatomic,retain) NSMutableArray *Images;
//通报时间
-(NSString*)BulletinDate;
//获取案件状态
-(NSString*)ApprovalStatusText;
//晶片说明
-(NSString*)ChipText;
//走失地点
-(NSString*)AwayLocation;
//走失时间格式化
-(NSString*)formatAwayDate;
/****将对象转化成字符串***/
-(NSString*)ObjectSeriationToString;
-(NSString*)formatPropertyString:(NSString*)str;
@end
