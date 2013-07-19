//
//  BulletSoapMessage.m
//  HttpRequest
//
//  Created by rang on 12-10-27.
//
//

#import "BulletSoapMessage.h"
#import "SoapHelper.h"
@implementation BulletSoapMessage

+(NSString*)CategoryByCircularSoap:(NSString*)type{
    NSString *soap=[NSString stringWithFormat:@"<categorty>%@</categorty>",type];
    return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"GetCategoryByCircular"],soap];
}
//获取一项分类详情
+(NSString*)FindCircularSoap:(NSString*)type withGUID:(NSString*)guid CasePwd:(NSString*)pwd{
    NSMutableString *msg=[NSMutableString stringWithFormat:@"<categorty>%@</categorty>",type];
    [msg appendFormat:@"<guid>%@</guid>",guid];
    [msg appendFormat:@"<pwd>%@</pwd>",pwd];
    return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"FindCircular"],msg];
}
+(NSString*)AddCircularCaseSoap:(NSMutableDictionary*)dic withImages:(NSString*)images{
 
    NSString *searchString=[SoapHelper defaultSoapMesage];
    NSMutableString *searchSoap=[NSMutableString stringWithFormat:@"<AddCircularCase xmlns=\"%@\">",defaultWebServiceNameSpace];
    [searchSoap appendString:@"<xml>%@</xml></AddCircularCase>"];
    NSString *soap=[NSString stringWithFormat:searchString,searchSoap];
   
    NSMutableString *soapBody3=[NSMutableString stringWithFormat:@""];
	[soapBody3 appendString:@"&lt;?xml version=\"1.0\"?&gt;"];
	[soapBody3 appendString:@"&lt;AddCircular xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"AddCircular\"&gt;"];
    
    for (NSString *item in dic) {
        [soapBody3 appendFormat:@"&lt;%@&gt;",item];
        [soapBody3 appendString:[dic objectForKey:item]];
        [soapBody3 appendFormat:@"&lt;/%@&gt;",item];
    }
    /***
    [soapBody3 appendFormat:@"&lt;Lat&gt;%@&lt;/Lat&gt;",show.Lat];
    [soapBody3 appendFormat:@"&lt;Lng&gt;%@&lt;/Lng&gt;",show.Lng];
    [soapBody3 appendFormat:@"&lt;Category&gt;%@&lt;/Category&gt;",show.Category];
    [soapBody3 appendFormat:@"&lt;TypeGuid&gt;%@&lt;/TypeGuid&gt;",show.TypeGuid];
    [soapBody3 appendFormat:@"&lt;City&gt;%@&lt;/City&gt;",show.City];
    [soapBody3 appendFormat:@"&lt;Number&gt;%@&lt;/Number&gt;",show.Number];
    
    [soapBody3 appendFormat:@"&lt;Memo&gt;%@&lt;/Memo&gt;",show.Memo];
    [soapBody3 appendFormat:@"&lt;Address&gt;%@&lt;/Address&gt;",show.Address];
    [soapBody3 appendFormat:@"&lt;Flag&gt;%@&lt;/Flag&gt;",show.Flag];
    [soapBody3 appendFormat:@"&lt;Name&gt;%@&lt;/Name&gt;",show.Name];
    [soapBody3 appendFormat:@"&lt;Nick&gt;%@&lt;/Nick&gt;",show.Nick];
    [soapBody3 appendFormat:@"&lt;Mobile&gt;%@&lt;/Mobile&gt;",show.Mobile];
    [soapBody3 appendFormat:@"&lt;Email&gt;%@&lt;/Email&gt;",show.Email];
    [soapBody3 appendFormat:@"&lt;PWD&gt;%@&lt;/PWD&gt;",show.PWD];
	**/
    [soapBody3 appendString:images];
	[soapBody3 appendString:@"&lt;/AddCircular&gt;"];
    return [NSString stringWithFormat:soap,soapBody3];
    
}
+(NSString*)CircularSoap:(NSString*)guid paramValue:(NSString*)pwd{
    NSMutableArray *key=[NSMutableArray arrayWithObjects:@"guid",@"pwd", nil];
    NSMutableArray *value=[NSMutableArray arrayWithObjects:guid,pwd, nil];
    return [SoapHelper SoapMessageMethod:@"GetCircular" paramKey:key paramValue:value];
}
+(NSString*)CircularTypeSoap{
  return [SoapHelper SoapMessageMethod:@"GetCircularType" paramKey:nil paramValue:nil];
}
+(NSString*)SearchCircularCaseSoap{
    NSString *searchString=[SoapHelper defaultSoapMesage];
    
    NSMutableString *searchSoap=[NSMutableString stringWithFormat:@"<SearchCircularCase xmlns=\"%@\">",defaultWebServiceNameSpace];
    [searchSoap appendString:@"<xml>%@</xml></SearchCircularCase>"];
    return [NSString stringWithFormat:searchString,searchSoap];
    /***
     <SearchCircularCase xmlns=\"%@\">\n"
     NSString *soapMsg=[SoapHelper SoapMessageMethod:@"SearchCircularCase" paramKey:[NSMutableArray arrayWithObjects:@"key", nil] paramValue:[NSMutableArray arrayWithObjects:searchString, nil]];
     return soapMsg;
     **/
    //生成soap信息
    
}
//业务专区同步
+(NSString*)AddDeviceSoap:(NSString*)user password:(NSString*)pwd appCode:(NSString*)code{
    NSString *body=[SoapHelper MethodSoapMessage:@"AddDevice"];
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    [msg appendFormat:@"<uid>%@</uid>",user];
    [msg appendFormat:@"<pwd>%@</pwd>",pwd];
    [msg appendFormat:@"<appCode>%@</appCode>",code];
    [msg appendString:@"<appName>IOS施政互動</appName>"];
    return [NSString stringWithFormat:body,msg];
}
+(NSString*)CheckCircularPasswordSoap:(NSString*)guid CasePwd:(NSString*)pwd{
    NSMutableArray *key=[NSMutableArray arrayWithObjects:@"guid",@"pwd", nil];
    NSMutableArray *value=[NSMutableArray arrayWithObjects:guid,pwd, nil];
    return [SoapHelper SoapMessageMethod:@"CheckCircularPassword" paramKey:key paramValue:value];
}
+(NSString*)GCMRegisterSoap:(NSString*)token  AppCode:(NSString*)code{
    NSString *soap=[SoapHelper MethodSoapMessage:@"GCMRegister"];
    NSString *body=[NSString stringWithFormat:@"<token>%@</token><appName>ios.app.elandmc.circular</appName><appCode>%@</appCode>",token,code];
    /***
     <token>string</token>
     <appName>string</appName>
     <appCode>string</appCode>
     ***/
    return [NSString stringWithFormat:soap,body];
}
+(NSString*)GCMUnRegisterSoap:(NSString*)token{
    NSString *soap=[SoapHelper MethodSoapMessage:@"GCMUnRegister"];
    NSString *body=[NSString stringWithFormat:@"<token>%@</token>",token];
    return [NSString stringWithFormat:soap,body];
}
+(NSString*)PushInfoSoap:(NSString*)guid{
    NSString *soap=[SoapHelper MethodSoapMessage:@"GetPushInfo"];
    NSString *body=[NSString stringWithFormat:@"<guid>%@</guid>",guid];
    return [NSString stringWithFormat:soap,body];
}
-(void)dealloc{
    [super dealloc];
   
}
@end
