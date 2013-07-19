//
//  CircularType.h
//  CaseBulletin
//
//  Created by aJia on 2012/10/25.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVUISelect.h"
@interface CircularType : NSObject {

}
@property(nonatomic,retain) NSString *Author;
@property(nonatomic,retain) NSString *Created;
@property(nonatomic,retain) NSString *GUID;
@property(nonatomic,retain) NSString *ID;
@property(nonatomic,retain) NSString *Level;
@property(nonatomic,retain) NSString *Memo;
@property(nonatomic,retain) NSString *Modified;
@property(nonatomic,retain) NSString *Name;
@property(nonatomic,retain) NSString *Parent;
@property(nonatomic,retain) NSString *Sort;
@property(nonatomic,retain) NSString *Status;
+(NSString*)typeName:(NSString*)type;
//取得分类名称
+(NSString*)CircularTypeName:(NSString*)guid;
+(NSMutableArray*)CommonCircularList:(NSString*)type;
+(void)asycCircularType:(NSString*)strType withDropList:(CVUISelect*)dropList;
+(NSMutableArray*)CircularList:(NSString*)type;

//获取指定父节点下的子节点
+(NSMutableArray*)ChildsCircularType:(NSString*)parGuid withType:(NSString*)type;
+(NSMutableArray*)ChildsLevelType:(NSString*)level withData:(NSMutableArray*)arr;
+(NSMutableArray*)ChildsParentType:(NSString*)parent withData:(NSMutableArray*)arr;
//格式化案件类别名称
+(NSString*)formatCircularName:(NSString*)str;
//获取所有分类
+(NSMutableArray*)ChildsAllCircularType;

//获取路平报修类别
+(NSMutableArray*)CircularRoadType;
//获取路灯报修类别
+(NSMutableArray*)CircularLightType;
//获取环保查报类别
+(NSMutableArray*)CircularEPType;
//获取税务申办类别
+(NSMutableArray*)CircularTaxType;
@end
