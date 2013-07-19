//
//  CircularTax.m
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "CircularTax.h"
#import "SoapHelper.h"
#import "SoapXmlParseHelper.h"
#import "CircularType.h"
@implementation CircularTax
@synthesize ID,GUID,Name,Nick,Mobile;
@synthesize Email,PWD,TypeGuid,Created,ExecDate;
@synthesize ApprovalDate,ApprovalMemo,ApprovalStatus,AccountChangeNum,Account;
@synthesize Flag,Location,Ctiy,Memo,Number;
/**
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
    [AccountChangeNum release];
    [Account release];
    
    [Flag release];
    [Location release];
    [Ctiy release];
    [Memo release];
    [Number release];

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

//获取类别Soap
-(NSString*)CircularTaxTypeSoap{
    return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"GetCategoryByCircular"],@"<categorty>E</categorty>"];
}
//获取类别
-(NSMutableArray*)XmlToCircularTaxType:(NSString*)xml{
    return [SoapXmlParseHelper TwoLevelXmlToArray:xml];
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
    [msg appendString:@"&lt;CircularTax xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"CircularTax\"&gt;"];
    [msg appendString:[UserSet ObjectToXml]];
    [msg appendFormat:@"&lt;TypeGuid&gt;%@&lt;/TypeGuid&gt;",[self formatPropertyString:self.TypeGuid]];
    [msg appendFormat:@"&lt;Ctiy&gt;%@&lt;/Ctiy&gt;",[self formatPropertyString:self.Ctiy]];
    [msg appendFormat:@"&lt;Location&gt;%@&lt;/Location&gt;",[self formatPropertyString:self.Location]];
    [msg appendFormat:@"&lt;Memo&gt;%@&lt;/Memo&gt;",[self formatPropertyString:self.Memo]];
    [msg appendFormat:@"&lt;PWD&gt;%@&lt;/PWD&gt;",[self formatPropertyString:self.PWD]];
    [msg appendString:@"&lt;/CircularTax&gt;"];
   
    NSString *soap=[NSString stringWithFormat:@"<categorty>E</categorty><xml>%@</xml>",msg];
    return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"AddCircular"],soap];
}
-(NSString*)formatPropertyString:(NSString*)str{
    if (str==nil||str==NULL||[str length]==0) {
        return @"";
    }
    return str;
}
@end
