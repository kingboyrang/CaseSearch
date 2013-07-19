//
//  BulletSoapMessage.h
//  HttpRequest
//
//  Created by rang on 12-10-27.
//
//

#import <Foundation/Foundation.h>
@interface BulletSoapMessage : NSObject{
}
//案件新增soap信息
+(NSString*)AddCircularCaseSoap:(NSMutableDictionary*)dic withImages:(NSString*)images;
//获取一个案件soap信息
+(NSString*)CircularSoap:(NSString*)guid paramValue:(NSString*)pwd;
//获取案件分类soap信息
+(NSString*)CircularTypeSoap;
//获取案件查询的soap信息
+(NSString*)SearchCircularCaseSoap;
//检查密码是否正确
+(NSString*)CheckCircularPasswordSoap:(NSString*)guid CasePwd:(NSString*)pwd;
//业务专区同步
+(NSString*)AddDeviceSoap:(NSString*)user password:(NSString*)pwd appCode:(NSString*)code;

+(NSString*)CategoryByCircularSoap:(NSString*)type;
//获取一项分类详情
+(NSString*)FindCircularSoap:(NSString*)type withGUID:(NSString*)guid CasePwd:(NSString*)pwd;

//注册推播
+(NSString*)GCMRegisterSoap:(NSString*)token AppCode:(NSString*)code;
//取消注册
+(NSString*)GCMUnRegisterSoap:(NSString*)token;
//获取一笔推播信息
+(NSString*)PushInfoSoap:(NSString*)guid;
@end
