//
//  VCircularSearchArgs.m
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "VCircularSearchArgs.h"
#import "SoapHelper.h"
@implementation VCircularSearchArgs
@synthesize Category,TypeGuid,Name,Nick,Ctiy;
@synthesize ApprovalStatus,SDate,EDate,Account,AccountName;
@synthesize ChangeAccount,OverdueExecDate,Flag,Number;
@synthesize CurPage,CurSize;
/***
-(void)dealloc{
    [super dealloc];
    [Category release];
    [TypeGuid release];
    [Name release];
    [Nick release];
    [Ctiy release];
    
    [ApprovalStatus release];
    [SDate release];
    [EDate release];
    [Account release];
    [AccountName release];
    
    [ChangeAccount release];
    [OverdueExecDate release];
    [Flag release];
    [Number release];
}
 **/
-(NSString*)ObjectSeriationToString{
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    [msg appendString:@"&lt;?xml version=\"1.0\"?&gt;"];
    [msg appendString:@"&lt;VCircularSearchArgs xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"VCircularSearchArgs\"&gt;"];
    [msg appendFormat:@"&lt;CurPage&gt;%d&lt;/CurPage&gt;",self.CurPage];
    [msg appendFormat:@"&lt;CurSize&gt;%d&lt;/CurSize&gt;",self.CurSize];
    
    [msg appendFormat:@"&lt;Ctiy&gt;%@&lt;/Ctiy&gt;",[self formatPropertyString:self.Ctiy]];
    [msg appendFormat:@"&lt;TypeGuid&gt;%@&lt;/TypeGuid&gt;",[self formatPropertyString:self.TypeGuid]];
    [msg appendFormat:@"&lt;Category&gt;%@&lt;/Category&gt;",[self formatPropertyString:self.Category]];
    /***
    [msg appendFormat:@"&lt;Name&gt;%@&lt;/Name&gt;",[self formatPropertyString:self.Name]];
    [msg appendFormat:@"&lt;Nick&gt;%@&lt;/Nick&gt;",[self formatPropertyString:self.Nick]];
    
    [msg appendFormat:@"&lt;ApprovalStatus&gt;%@&lt;/ApprovalStatus&gt;",[self formatPropertyString:self.ApprovalStatus]];
    ***/
    NSString *bdate=[self formatPropertyString:self.SDate];
    NSString *edate=[self formatPropertyString:self.EDate];
    if ([bdate length]>0) {
        [msg appendFormat:@"&lt;SDate&gt;%@&lt;/SDate&gt;",[self formatPropertyString:self.SDate]];
    }
    if ([edate length]>0){
       [msg appendFormat:@"&lt;EDate&gt;%@&lt;/EDate&gt;",[self formatPropertyString:self.EDate]];
    }
    /**
    [msg appendFormat:@"&lt;Account&gt;%@&lt;/Account&gt;",[self formatPropertyString:self.Account]];
    [msg appendFormat:@"&lt;AccountName&gt;%@&lt;/AccountName&gt;",[self formatPropertyString:self.AccountName]];
    
    [msg appendFormat:@"&lt;ChangeAccount&gt;%@&lt;/ChangeAccount&gt;",[self formatPropertyString:self.ChangeAccount]];
    [msg appendFormat:@"&lt;OverdueExecDate&gt;%@&lt;/OverdueExecDate&gt;",[self formatPropertyString:self.OverdueExecDate]];
    **/
    [msg appendFormat:@"&lt;Flag&gt;%@&lt;/Flag&gt;",[self formatPropertyString:self.Flag]];
    [msg appendFormat:@"&lt;Number&gt;%@&lt;/Number&gt;",[self formatPropertyString:self.Number]];
    [msg appendString:@"&lt;/VCircularSearchArgs&gt;"];
    NSString *body=[NSString stringWithFormat:@"<xml>%@</xml>",msg];
    return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"SearchCircular"],body];
}
-(NSString*)formatPropertyString:(NSString*)str{
    if (str==nil||str==NULL||[str length]==0) {
        return @"";
    }
    return str;
}
@end
