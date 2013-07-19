//
//  XmlParseHelper.m
//  HttpRequest
//
//  Created by rang on 12-11-10.
//
//

#import "SoapXmlParseHelper.h"
#import "GDataXMLNode.h"

@implementation SoapXmlParseHelper
+(BOOL)isKindOfStringOrData:(id)xml{
    if ([xml isKindOfClass:[NSString class]]||[xml isKindOfClass:[NSData class]]) {
        return YES;
    }
    return NO;
}
#pragma mark -
#pragma mark 获取methodName+Result里面的内容
+(NSString*)soapMessageResultXml:(id)data serviceMethodName:(NSString*)methodName{
    GDataXMLDocument *document=[self xmlDocumentObject:data nodeName:nil];
    if (document) {
        GDataXMLElement* rootNode = [document rootElement];
        NSString *searchStr=[NSString stringWithFormat:@"%@Result",methodName];
        NSString *MsgResult=@"";
        NSArray *result=[rootNode children];
        while ([result count]>0) {
            NSString *nodeName=[[result objectAtIndex:0] name];
            if ([nodeName isEqualToString: searchStr]) {
                MsgResult=[[result objectAtIndex:0] stringValue];
                break;
            }
            result=[[result objectAtIndex:0] children];
        }
        return MsgResult;
    }
    return @"";
}
+(GDataXMLDocument*)xmlDocumentObject:(id)data nodeName:(NSString*)name{
    NSError *error=nil;
    GDataXMLDocument *document=nil;
    if (name) {
        NSString *xml=nil;
        if ([data isKindOfClass:[NSString class]]){
            xml=(NSString*)data;
        }else{
            xml=[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        }
        if (xml) {
            xml=[xml stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"xmlns=\"%@\"",name] withString:@""];
            
            document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
        }
    }else{
        if ([data isKindOfClass:[NSString class]]) {
            document=[[GDataXMLDocument alloc] initWithXMLString:data options:0 error:&error];
        }else{
            document=[[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
        }
    }
    if (error||document==nil) {
        return nil;
    }
    //[document setCharacterEncoding:@"uft-8"];
    return [document autorelease];
}
+(NSMutableArray*)XmlToArray:(id)xml{
    NSMutableArray *arr=[NSMutableArray array];
    if (![self isKindOfStringOrData:xml]) {
        return arr;
    }
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([xml isKindOfClass:[NSString class]]) {
        document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    }
    else
       document=[[GDataXMLDocument alloc] initWithData:xml options:0 error:&error];
    if (error) {
        [document release];
        return arr;
    }
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    for (GDataXMLNode *node in rootChilds) {
        NSString *nodeName=node.name;
        if ([node.children count]>0) {
            [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[self nodeChilds:node],nodeName, nil]];
        }else{
            [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[node stringValue],nodeName, nil]];
        }
    }
    [document release];
    return arr;
}
+(NSMutableArray*)nodeChilds:(GDataXMLNode*)node{
    NSMutableArray *arr=[NSMutableArray array];
    NSArray *childs=[node children];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    for (GDataXMLNode* child in childs){
        NSString *nodeName=child.name;//获取节点名称
        NSArray  *childNode=[child children];
        if ([childNode count]>0) {//存在子节点
            [dic setValue:[self nodeChilds:child] forKey:nodeName];
        }else{
            [dic setValue:[child stringValue] forKey:nodeName];
        }
    }
    [arr addObject:dic];
    return arr;
}
+(NSMutableDictionary*)ChildsNodeDictionary:(GDataXMLNode*)node{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSArray *childs=[node children];
    for (GDataXMLNode *item in childs) {
        [dic setValue:[item stringValue] forKey:item.name];
    }
    return dic;
}
+(NSArray*)ChildsRootNodeArray:(NSString*)xml{
    NSArray *arr=[NSArray array];
    NSError *error=nil;
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    if (error) {
        [document release];
        return arr;
    }
    GDataXMLElement* rootNode = [document rootElement];
    arr=[rootNode children];
    [document release];
    return arr;
}
+(NSMutableArray*)TwoLevelXmlToArray:(NSString*)xml{
    
    NSMutableArray *arr=[NSMutableArray array];
    NSError *error=nil;
    GDataXMLDocument *document=[[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error] autorelease];
    if (error) {
        
        return arr;
    }
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    for (GDataXMLNode *node in rootChilds){
        [arr addObject:[self ChildsNodeDictionary:node]];
    }
    
    return arr;
}
+(NSMutableArray*)XmlOjbectToArray:(NSString*)xml ClassName:(NSString*)name{
    NSMutableArray *arr=[NSMutableArray array];
    NSError *error=nil;
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    if (error) {
        [document release];
        return arr;
    }
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    for (GDataXMLNode *node in rootChilds){
        //[arr addObject:[self ChildsNodeDictionary:node]];
        id obj=[[NSClassFromString(name) alloc] init];
        NSArray *nodechilds=[node children];
        for (GDataXMLNode *item in nodechilds) {
            SEL sel=NSSelectorFromString(item.name);
            if ([obj respondsToSelector:sel]) {
                [obj setValue:[item stringValue] forKey:item.name];
                //[obj performSelector:sel withObject:[item stringValue]];
            }
        }
        [arr addObject:obj];
        [obj release];
    }
   // NSLog(@"result=%@\n",arr);
    [document release];
    return arr;
}
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
//查找节点,并转化成对象
+(NSMutableArray*)SearchNodeToArray:(id)xml nodeName:(NSString*)name className:(NSString*)objName{
    NSMutableArray *arr=[NSMutableArray array];
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([xml isKindOfClass:[NSString class]]) {
        document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    }
    else
        document=[[GDataXMLDocument alloc] initWithData:xml options:0 error:&error];
    if (error) {
        [document release];
        return arr;
    }
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *childs=[rootNode nodesForXPath:name error:nil];
    for (GDataXMLNode *node in childs) {
        [arr addObject:[self NodeToObject:node className:objName]];
    }
    return arr;
}
//将某个节点转化成对象
+(id)NodeToObject:(GDataXMLNode*)node className:(NSString*)objName{
     id obj=[[[NSClassFromString(objName) alloc] init] autorelease];
    NSArray *nodechilds=[node children];
    for (GDataXMLNode *item in nodechilds) {
        SEL sel=NSSelectorFromString(item.name);
        if ([obj respondsToSelector:sel]) {
            [obj setValue:[item stringValue] forKey:item.name];
            //[obj performSelector:sel withObject:[item stringValue]];
        }
    }
    return obj;
}
//将根节点转化成对象
+(id)RootNodeToObject:(id)xml className:(NSString*)objName{
    id obj=[[[NSClassFromString(objName) alloc] init] autorelease];
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([xml isKindOfClass:[NSString class]]) {
        document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    }
    else
        document=[[GDataXMLDocument alloc] initWithData:xml options:0 error:&error];
    if (error) {
        [document release];
        return obj;
    }
   GDataXMLElement* rootNode = [document rootElement];
     NSArray *nodechilds=[rootNode children];
    for (GDataXMLNode *item in nodechilds){
        SEL sel=NSSelectorFromString(item.name);
        if ([item.name isEqualToString:@"DownImages"]) {
            SEL pro=NSSelectorFromString(@"Images");
            if ([obj respondsToSelector:pro]) {
                NSMutableArray *imagesList=[NSMutableArray array];
                NSArray *imgArr=[item children];
                for (GDataXMLNode *img in imgArr) {
                    [imagesList addObject:[img stringValue]];
                }
                 [obj setValue:imagesList forKey:@"Images"];
            }
            
        }else{
        if ([obj respondsToSelector:sel]) {
            [obj setValue:[item stringValue] forKey:item.name];
        }
        }
    }
    return obj;
}
@end
