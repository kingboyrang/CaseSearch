//
//  NSString+StringExtension.h
//  CaseSearch
//
//  Created by aJia on 12/11/14.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringExtension)
//去除前后空格
-(NSString*)Trim;
-(NSString*)DateToTw:(NSString*)date;
-(CGSize)CalculateStringSize:(UIFont*)font with:(CGFloat)w;
-(CGFloat)CalculateStringHeight:(UIFont*)font with:(CGFloat)w;
+(NSString*)NewGuid;
@end
