//
//  CircularRoad.m
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//
/// <summary>
/// 路平報修
/// </summary>
#import "CircularRoad.h"
#import "SoapHelper.h"
#import "CircularType.h"
@implementation CircularRoad
@synthesize ID,GUID,Name,Nick,Mobile;
@synthesize Email,PWD,TypeGuid,Created,ExecDate;
@synthesize ApprovalDate,ApprovalMemo,ApprovalStatus,Foreign,AccountChangeNum;
@synthesize Account,Flag,Location,Ctiy,Lat,Lng,Memo,Number;
@synthesize ApprovalImages,Images;
/***
-(void)dealloc{
    [super dealloc];
    [ID release];
    [GUID release];
    [Name release];
    [Nick release];
    [Mobile release];
    
    [Email release];
    [PWD release];
    [TypeGuid release];
    [Created release];
    [ExecDate release];
    
    [ApprovalDate release];
    [ApprovalMemo release];
    [ApprovalStatus release];
    [Foreign release];
    [AccountChangeNum release];
    
    [Account release];
    [Flag release];
    [Location release];
    [Ctiy release];
    [Lat release];
    [Lng release];
    [Memo release];
    [Number release];
    [ApprovalImages release];
    [Images release];
}
 **/
//获取案件分类名称
-(NSString*)TypeGuidName{
    NSString *type=[self formatPropertyString:self.TypeGuid];
    if ([type length]==0) {return @"";}
    return [CircularType CircularTypeName:type];
}
//通报时间
-(NSString*)BulletinDate{
    NSString *date=[self formatPropertyString:self.Created];
    if ([date length]==0) {return @"";}
    date=[date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSRange range = [date  rangeOfString:@":" options:NSBackwardsSearch];
    if (range.location!=NSNotFound) {
        int pos=range.location;
        date=[date substringWithRange:NSMakeRange(0, pos)];
    }
    int y=[[date substringWithRange:NSMakeRange(0, 4)] intValue];
    return [NSString stringWithFormat:@"%d%@",y-1911,[date stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""]];
}
/***
 获取案件状态
 ***/
-(NSString*)ApprovalStatusText{
    if ([self.ApprovalStatus isEqualToString:@"1"]) return @"辦理中";
    return @"已完成";
}
-(NSString*)ObjectSeriationToString{
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    [msg appendString:@"&lt;?xml version=\"1.0\"?&gt;"];
    [msg appendString:@"&lt;CircularRoad xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"CircularRoad\"&gt;"];
    [msg appendString:[UserSet ObjectToXml]];
    [msg appendFormat:@"&lt;TypeGuid&gt;%@&lt;/TypeGuid&gt;",[self formatPropertyString:self.TypeGuid]];
    [msg appendFormat:@"&lt;Ctiy&gt;%@&lt;/Ctiy&gt;",[self formatPropertyString:self.Ctiy]];
    [msg appendFormat:@"&lt;Location&gt;%@&lt;/Location&gt;",[self formatPropertyString:self.Location]];
    [msg appendFormat:@"&lt;Lat&gt;%@&lt;/Lat&gt;",[self formatPropertyString:self.Lat]];
    [msg appendFormat:@"&lt;Lng&gt;%@&lt;/Lng&gt;",[self formatPropertyString:self.Lng]];
    [msg appendFormat:@"&lt;Memo&gt;%@&lt;/Memo&gt;",[self formatPropertyString:self.Memo]];
    [msg appendFormat:@"&lt;PWD&gt;%@&lt;/PWD&gt;",[self formatPropertyString:self.PWD]];
    if ([self.Images count]>0) {
        [msg appendString:@"&lt;UpImages&gt;"];
        for (NSDictionary *dic in self.Images) {
            [msg appendString:@"&lt;CircularImage&gt;"];
            [msg appendFormat:@"&lt;Name&gt;%@&lt;/Name&gt;",[dic objectForKey:@"Name"]];
            [msg appendFormat:@"&lt;Content&gt;%@&lt;/Content&gt;",[dic objectForKey:@"Content"]];
            [msg appendString:@"&lt;/CircularImage&gt;"];
        }
        [msg appendString:@"&lt;/UpImages&gt;"];
    }
    [msg appendString:@"&lt;/CircularRoad&gt;"];
    NSString *soap=[NSString stringWithFormat:@"<categorty>A</categorty><xml>%@</xml>",msg];
    return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"AddCircular"],soap];
}
-(NSString*)formatPropertyString:(NSString*)str{
    if (str==nil||str==NULL||[str length]==0) {
        return @"";
    }
    return str;
}

@end
