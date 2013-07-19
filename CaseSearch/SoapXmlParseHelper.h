//
//  XmlParseHelper.h
//  HttpRequest
//
//  Created by rang on 12-11-10.
//
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
@interface SoapXmlParseHelper : NSObject

//获取webservice调用返回的xml内容
+(NSString*)soapMessageResultXml:(id)xml serviceMethodName:(NSString*)methodName;
+(GDataXMLDocument*)xmlDocumentObject:(id)data nodeName:(NSString*)name;
//xml转换成Array
+(NSMutableArray*)XmlToArray:(id)xml;
+(NSMutableArray*)nodeChilds:(GDataXMLNode*)node;
//判断xml是否为NSData或NSString
+(BOOL)isKindOfStringOrData:(id)xml;

//获取节点下，子节点的所有内容
+(NSMutableDictionary*)ChildsNodeDictionary:(GDataXMLNode*)node;

//获取根节点下的子节点
+(NSArray*)ChildsRootNodeArray:(NSString*)xml;
//获取只有两层的xml转换成数组
+(NSMutableArray*)TwoLevelXmlToArray:(NSString*)xml;
+(NSMutableArray*)XmlOjbectToArray:(NSString*)xml ClassName:(NSString*)name;

////////////////////////////2012/12/05////////////////////////////////////////////////////
//查找节点,并转化成对象
+(NSMutableArray*)SearchNodeToArray:(id)xml nodeName:(NSString*)name className:(NSString*)objName;
//将某个节点转化成对象
+(id)NodeToObject:(GDataXMLNode*)node className:(NSString*)objName;
//将根节点转化成对象
+(id)RootNodeToObject:(id)xml className:(NSString*)objName;
@end
