//
//  NetWorkConnection.h
//  SystemLeave
//
//  Created by aJia on 2012/3/5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetWorkConnection : NSObject {

}
//判斷網路是否開啟
+(BOOL)connectedToNetwork;
//判斷GPS是否開啟
+(BOOL)isOpenGps;
// 是否wifi
+ (BOOL) IsEnableWIFI;
// 是否3G
+(BOOL) IsEnable3G;
@end
