//
//  CircularType.m
//  CaseBulletin
//
//  Created by aJia on 2012/10/25.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CircularType.h"
#import "ServiceHelper.h"
#import "BulletSoapMessage.h"
#import "SoapXmlParseHelper.h"
#import "FileHelper.h"
@implementation CircularType
@synthesize Author,Created,GUID,ID;
@synthesize Level,Memo,Modified,Name;
@synthesize Parent,Sort,Status;

+(NSString*)typeName:(NSString*)type{
    if ([type isEqualToString:@"A"]) {return @"CircularRoadType";}//路平报修类别
    if ([type isEqualToString:@"B"]) {return @"CircularLightType";}//路灯报修类别
    if ([type isEqualToString:@"C"]) {return @"CircularEPType";}//环保查报类别
    return @"CircularTaxType";//税务申办类别
}
+(NSMutableArray*)CommonCircularList:(NSString*)type{
    NSMutableDictionary *dic=[AppSystem fileNameToCircularType];
    NSMutableArray *arr=[NSMutableArray array];
    NSString *name=[self typeName:type];
    if ([dic objectForKey:name]!=nil) {
        arr=[dic objectForKey:name];
    }
    //if ([arr count]==0) {
      //  arr=[self CircularList:type];
    //}
    return arr;
}
+(void)asycCircularType:(NSString*)strType withDropList:(CVUISelect*)dropList{
    NSMutableArray *arr=[self CommonCircularList:strType];
    NSMutableArray *source;
    if ([arr count]>0) {
        if ([strType isEqualToString:@"A"]) {//路平报修
            [dropList setDataSourceForArray:arr dataTextName:@"Name" dataValueName:@"GUID"];
        }else{
            source=[self ChildsLevelType:@"1" withData:arr];
            [dropList setDataSourceForArray:source dataTextName:@"Name" dataValueName:@"GUID"];
        }
    }else{
        NSString *CircularName=[self typeName:strType];
        NSString *soapMsg=[BulletSoapMessage CategoryByCircularSoap:strType];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
            args.methodName=@"GetCategoryByCircular";
            args.soapMessage=soapMsg;

            NSString *result=[[ServiceHelper sharedInstance] syncService:args];
            NSMutableArray *circularArr=[SoapXmlParseHelper TwoLevelXmlToArray:result];
            if ([circularArr count]>0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([strType isEqualToString:@"A"]) {//路平报修
                        //绑定数据
                        [dropList setDataSourceForArray:circularArr dataTextName:@"Name" dataValueName:@"GUID"];
                    }else{
                      NSMutableArray *circularSource=[self ChildsLevelType:@"1" withData:circularArr];
                       [dropList setDataSourceForArray:circularSource dataTextName:@"Name" dataValueName:@"GUID"];
                    }
                    //重新保存
                    NSMutableDictionary *dic=[AppSystem fileNameToCircularType];
                    if ([dic objectForKey:CircularName]!=nil) {
                        [dic removeObjectForKey:CircularName];
                    }
                    [dic setValue:circularArr forKey:CircularName];
                    [FileHelper ContentToFile:dic withFileName:@"CircleType.plist"];
                    
                });
                //dispatch_async(dispatch_get_main_queue(), completion);
            }
            else {
                //NSLog(@"-- impossible download: %@", urlString);
            }
            
        });
        
    }

}

+(NSMutableArray*)CircularList:(NSString*)type{
    NSString *CircularName=[self typeName:type];
    NSString *soapMsg=[BulletSoapMessage CategoryByCircularSoap:type];
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"GetCategoryByCircular";
    args.soapMessage=soapMsg;
    NSString *result=[[ServiceHelper sharedInstance] syncService:args];
    NSMutableArray  *arr=[SoapXmlParseHelper TwoLevelXmlToArray:result];
    
    //重新保存
    NSMutableDictionary *dic=[AppSystem fileNameToCircularType];
    if ([dic objectForKey:CircularName]!=nil) {
        [dic removeObjectForKey:CircularName];
    }
    [dic setValue:arr forKey:CircularName];
    [FileHelper ContentToFile:dic withFileName:@"CircleType.plist"];
    return arr;
}
//获取路平报修类别
+(NSMutableArray*)CircularRoadType{
    return [self CommonCircularList:@"A"];
}
//路灯报修类别
+(NSMutableArray*)CircularLightType{
    return [self CommonCircularList:@"B"];
}
//获取环保查报类别
+(NSMutableArray*)CircularEPType{
    return [self CommonCircularList:@"C"];
}
//获取税务申办类别
+(NSMutableArray*)CircularTaxType{
    return [self CommonCircularList:@"E"];
}
+(NSString*)CircularTypeName:(NSString*)guid{
    NSMutableDictionary *dic=[AppSystem fileNameToCircularType];
    NSArray *arr=[dic allKeys];
    NSString *result=@"";
    BOOL b=NO;
    for (NSString *item in arr){
        NSArray *newArr=[dic objectForKey:item];
        for (NSDictionary *node in newArr) {
            if ([[[node objectForKey:@"GUID"] Trim] isEqualToString:[guid Trim]]) {
                result=[node objectForKey:@"Name"];
                b=YES;
                break;
            }

        }
        if (b) {
            break;
        }
       }
    return [self formatCircularName:result];
}
//获取指定父节点下的子节点
+(NSMutableArray*)ChildsCircularType:(NSString*)parGuid withType:(NSString*)type{
    NSMutableDictionary *dic=[AppSystem fileNameToCircularType];
    NSString *typeName=[self typeName:type];
    NSArray *arr=[NSArray array];
    if ([dic objectForKey:typeName]!=nil) {
        arr=[dic objectForKey:typeName];
    }
    NSMutableArray *newArr=[NSMutableArray array];
    for (NSMutableDictionary *item in arr){
        if ([[[item objectForKey:@"Parent"] Trim] isEqualToString:[parGuid Trim]])
        {
            [newArr addObject:item];
        }
        //Level
    }
    return newArr;
}
+(NSMutableArray*)ChildsLevelType:(NSString*)level withData:(NSMutableArray*)arr{
    NSMutableArray *newArr=[NSMutableArray array];
    for (NSDictionary *item in arr) {
        if ([[item objectForKey:@"Level"] isEqualToString:level]) {
            [newArr addObject:item];
        }
    }
    return newArr;
}
+(NSMutableArray*)ChildsParentType:(NSString*)parent withData:(NSMutableArray*)arr{
    NSMutableArray *newArr=[NSMutableArray array];
    for (NSDictionary *item in arr) {
        NSString *itemParent=[item objectForKey:@"Parent"];
        if ([[itemParent Trim] isEqualToString:[parent Trim]]) {
            [newArr addObject:item];
        }
    }
    return newArr;
}
+(NSString*)formatCircularName:(NSString*)str{
    NSRange r=[str rangeOfString:@"-"];
    while (r.location!=NSNotFound) {
        int pos=r.location;
        str=[str substringWithRange:NSMakeRange(pos+1, str.length-1)];
        r=[str rangeOfString:@"-"];
    }
    return str;
}
+(NSMutableArray*)ChildsAllCircularType{
   NSMutableDictionary *dic=[AppSystem fileNameToCircularType];
    NSMutableArray *newArr=[NSMutableArray array];
    for (NSString *item in [dic allKeys]){
        [newArr addObjectsFromArray:[dic objectForKey:item]];
    }
    return newArr;
    
}
@end
