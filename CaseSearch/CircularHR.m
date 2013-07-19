//
//  CircularHR.m
//  CaseSearch
//
//  Created by rang on 13-4-16.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CircularHR.h"
#import "SoapHelper.h"

@implementation CircularHR
@synthesize ID,GUID,Name,Nick,Mobile,Phone,Address,Email,PWD;
@synthesize Created,ExecDate,ApprovalDate,ApprovalMemo,ApprovalStatus;
@synthesize AccountChangeNum,Account,IsMessagge,Flag,Category,Ctiy;
@synthesize ChildRelation,ManName,WomanName,ManAddress,WomanAddress;
@synthesize  DeathRelation,DeathName,DeathAddress,Memo,Number,ApprovalStatusText,CategoryText;
-(NSString*)CategoryText{
    if ([self.Category isEqualToString:@"1"]) {
        return  @"出生登記";
    }
    if ([self.Category isEqualToString:@"2"]) {
        return @"結婚登記";
    }
    if ([self.Category isEqualToString:@"3"]) {
        return @"死亡登記";
    }
    return @"";
}
-(NSString*)ApprovalStatusText{
    if ([self.ApprovalStatus isEqualToString:@"1"]) {
        return @"辦理中";
    }
    return @"已完成";
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
/****将对象转化成字符串***/
-(NSString*)ObjectSeriationToString{
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    [msg appendString:@"&lt;?xml version=\"1.0\"?&gt;"];
    [msg appendString:@"&lt;CircularHR xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"CircularHR\"&gt;"];
    
    UserSet *user=[UserSet loadUser];
     NSMutableString *body=[NSMutableString stringWithFormat:@""];
     if([user.Nick length]>0){
        [body appendFormat:@"&lt;%@&gt;%@&lt;/%@&gt;",@"Nick",user.Nick,@"Nick"];
     }
     if([user.Flag length]>0){
       [body appendFormat:@"&lt;%@&gt;%@&lt;/%@&gt;",@"Flag",user.Flag,@"Flag"];
     }
    [msg appendString:body];
    
    [msg appendFormat:@"&lt;Name&gt;%@&lt;/Name&gt;",[self formatPropertyString:self.Name]];
    [msg appendFormat:@"&lt;Phone&gt;%@&lt;/Phone&gt;",[self formatPropertyString:self.Phone]];
    [msg appendFormat:@"&lt;Mobile&gt;%@&lt;/Mobile&gt;",[self formatPropertyString:self.Mobile]];
    [msg appendFormat:@"&lt;Email&gt;%@&lt;/Email&gt;",[self formatPropertyString:self.Email]];
    [msg appendFormat:@"&lt;Address&gt;%@&lt;/Address&gt;",[self formatPropertyString:self.Address]];
    [msg appendFormat:@"&lt;PWD&gt;%@&lt;/PWD&gt;",[self formatPropertyString:self.PWD]];
    [msg appendFormat:@"&lt;Category&gt;%@&lt;/Category&gt;",[self formatPropertyString:self.Category]];
    [msg appendFormat:@"&lt;Ctiy&gt;%@&lt;/Ctiy&gt;",[self formatPropertyString:self.Ctiy]];
    [msg appendFormat:@"&lt;ChildRelation&gt;%@&lt;/ChildRelation&gt;",[self formatPropertyString:self.ChildRelation]];    
    [msg appendFormat:@"&lt;ManName&gt;%@&lt;/ManName&gt;",[self formatPropertyString:self.ManName]];
    [msg appendFormat:@"&lt;WomanName&gt;%@&lt;/WomanName&gt;",[self formatPropertyString:self.WomanName]];
    [msg appendFormat:@"&lt;ManAddress&gt;%@&lt;/ManAddress&gt;",[self formatPropertyString:self.ManAddress]];
    [msg appendFormat:@"&lt;WomanAddress&gt;%@&lt;/WomanAddress&gt;",[self formatPropertyString:self.WomanAddress]];
    [msg appendFormat:@"&lt;DeathRelation&gt;%@&lt;/DeathRelation&gt;",[self formatPropertyString:self.DeathRelation]];
    [msg appendFormat:@"&lt;DeathName&gt;%@&lt;/DeathName&gt;",[self formatPropertyString:self.DeathName]];
    [msg appendFormat:@"&lt;DeathAddress&gt;%@&lt;/DeathAddress&gt;",[self formatPropertyString:self.DeathAddress]];
    [msg appendFormat:@"&lt;Memo&gt;%@&lt;/Memo&gt;",[self formatPropertyString:self.Memo]];
    [msg appendString:@"&lt;/CircularHR&gt;"];
    
    NSString *soap=[NSString stringWithFormat:@"<categorty>F</categorty><xml>%@</xml>",msg];
    return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"AddCircular"],soap];
}
-(NSString*)formatPropertyString:(NSString*)str{
    if (str==nil||str==NULL||[str length]==0) {
        return @"";
    }
    return str;
}
@end
