//
//  appSet.m
//  CaseSearch
//
//  Created by rang on 13-4-22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "UserSet.h"

@implementation UserSet
@synthesize GUID,Name,Nick,Mobile,Email,Flag,isSync;
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.GUID forKey:@"GUID"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.Nick forKey:@"Nick"];
    [encoder encodeObject:self.Mobile forKey:@"Mobile"];
    [encoder encodeObject:self.Email forKey:@"Email"];
    [encoder encodeObject:self.Flag forKey:@"Flag"];
    [encoder encodeBool:self.isSync forKey:@"isSync"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.GUID=[aDecoder decodeObjectForKey:@"GUID"];
        self.Name=[aDecoder decodeObjectForKey:@"Name"];
        self.Nick=[aDecoder decodeObjectForKey:@"Nick"];
        self.Mobile=[aDecoder decodeObjectForKey:@"Mobile"];
        self.Email=[aDecoder decodeObjectForKey:@"Email"];
        self.Flag=[aDecoder decodeObjectForKey:@"Flag"];
        self.isSync=[aDecoder decodeBoolForKey:@"isSync"];
    }
    return self;
}
+(void)save:(UserSet*)obj{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"localEncodeSet"];
    [defaults synchronize];
}
+(UserSet*)systemUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"localEncodeSet"];
    if (data) {
      UserSet *obj = (UserSet*)[NSKeyedUnarchiver unarchiveObjectWithData: data];
      return obj;
    }
    return nil;
}
+(UserSet*)loadUser{
    UserSet *obj = [self systemUser];
    if(!obj){
        obj=[[[UserSet alloc] init] autorelease];
        obj.GUID=@"";
        obj.Name=@"";
        obj.Nick=@"";
        obj.Mobile=@"";
        obj.Email=@"";
        obj.Flag=@"";
        obj.isSync=NO;
    }
    return obj;
}
+(NSString*)ObjectToXml{
    UserSet *app=[self loadUser];
    if (app) {
        NSMutableString *body=[NSMutableString stringWithFormat:@""];
        [body appendFormat:@"&lt;Name&gt;%@&lt;/Name&gt;",app.Name];
        [body appendFormat:@"&lt;Nick&gt;%@&lt;/Nick&gt;",app.Nick];
        [body appendFormat:@"&lt;Mobile&gt;%@&lt;/Mobile&gt;",app.Mobile];
        [body appendFormat:@"&lt;Email&gt;%@&lt;/Email&gt;",app.Email];
        [body appendFormat:@"&lt;Flag&gt;%@&lt;/Flag&gt;",app.Flag];
        return [NSString stringWithFormat:@"%@",body];
    }
    return @"";
}
@end
