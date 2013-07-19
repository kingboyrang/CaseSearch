//
//  CircularPet.m
//  CaseSearch
//
//  Created by aJia on 12/12/4.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "CircularPet.h"
#import "SoapHelper.h"
@implementation CircularPet
@synthesize ID,GUID,Name,Nick,Mobile;
@synthesize Email,PWD,Created,ExecDate,ApprovalDate;
@synthesize ApprovalMemo,ApprovalStatus,Account,Flag,Location;
@synthesize Ctiy,Memo,Number,PetName,PetType;
@synthesize PetAge,PetNeutered,PetSex,PetFeature,Chip;
@synthesize ChipCode,AwayDate,Contact,UpImages,Images;
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
    [Created release];
    [ExecDate release];
    [ApprovalDate release];
    
    [ApprovalMemo release];
    [ApprovalStatus release];
    [Account release];
    [Flag release];
    [Location release];
    [Ctiy release];
    [Memo release];
    [Number release];
    [PetName release];
    [PetType release];
    
    [PetAge release];
    [PetNeutered release];
    [PetSex release];
    [PetFeature release];
    [Chip release];
    
    [ChipCode release];
    [AwayDate release];
    [Contact release];
    [UpImages release];
    [Images release];
}
 **/
//晶片说明
-(NSString*)ChipText{
    NSString *memo=[self formatPropertyString:self.Chip];
    if ([memo isEqualToString:@"有"]) {
        NSString *code=[self formatPropertyString:self.ChipCode];
        if ([code length]>0) {
            return [NSString stringWithFormat:@"%@,%@",memo,code];
        }
        return memo;
    }
    return memo;
}
//走失地点
-(NSString*)AwayLocation{
   NSString *memo=[self formatPropertyString:self.Ctiy];
   NSString *loc=[self formatPropertyString:self.Location];
   return [NSString stringWithFormat:@"%@%@",memo,loc];
}
//走失时间格式化
-(NSString*)formatAwayDate{
    NSString *date=[self formatPropertyString:self.AwayDate];
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
-(NSString*)ObjectSeriationToString{
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    [msg appendString:@"&lt;?xml version=\"1.0\"?&gt;"];
    [msg appendString:@"&lt;CircularPet xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"CircularPet\"&gt;"];
    [msg appendString:[UserSet ObjectToXml]];
    [msg appendFormat:@"&lt;PetName&gt;%@&lt;/PetName&gt;",[self formatPropertyString:self.PetName]];
    [msg appendFormat:@"&lt;PetType&gt;%@&lt;/PetType&gt;",[self formatPropertyString:self.PetType]];
    [msg appendFormat:@"&lt;PetAge&gt;%@&lt;/PetAge&gt;",[self formatPropertyString:self.PetAge]];
    [msg appendFormat:@"&lt;PetSex&gt;%@&lt;/PetSex&gt;",[self formatPropertyString:self.PetSex]];
    [msg appendFormat:@"&lt;PetNeutered&gt;%@&lt;/PetNeutered&gt;",[self formatPropertyString:self.PetNeutered]];
    [msg appendFormat:@"&lt;PetFeature&gt;%@&lt;/PetFeature&gt;",[self formatPropertyString:self.PetFeature]];
    [msg appendFormat:@"&lt;Chip&gt;%@&lt;/Chip&gt;",[self formatPropertyString:self.Chip]];
    [msg appendFormat:@"&lt;ChipCode&gt;%@&lt;/ChipCode&gt;",[self formatPropertyString:self.ChipCode]];
    [msg appendFormat:@"&lt;Ctiy&gt;%@&lt;/Ctiy&gt;",[self formatPropertyString:self.Ctiy]];
    [msg appendFormat:@"&lt;Location&gt;%@&lt;/Location&gt;",[self formatPropertyString:self.Location]];
    [msg appendFormat:@"&lt;Contact&gt;%@&lt;/Contact&gt;",[self formatPropertyString:self.Contact]];
    
    [msg appendFormat:@"&lt;AwayDate&gt;%@&lt;/AwayDate&gt;",[self formatPropertyString:self.AwayDate]];
    [msg appendFormat:@"&lt;Memo&gt;%@&lt;/Memo&gt;",[self formatPropertyString:self.Memo]];
    //[msg appendFormat:@"&lt;Flag&gt;%@&lt;/Flag&gt;",[self formatPropertyString:self.Flag]];
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
    [msg appendString:@"&lt;/CircularPet&gt;"];
  
    NSString *soap=[NSString stringWithFormat:@"<categorty>D</categorty><xml>%@</xml>",msg];
    return [NSString stringWithFormat:[SoapHelper MethodSoapMessage:@"AddCircular"],soap];
}
-(NSString*)formatPropertyString:(NSString*)str{
    if (str==nil||str==NULL||[str length]==0) {
        return @"";
    }
    return str;
}
@end
