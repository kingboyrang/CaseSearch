//
//  UIBarButtonItem+CustomBarButtonItem.h
//  Bullet
//
//  Created by rang on 12-11-13.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomBarButtonItem)
-(id)CustomViewButtonItem:(NSString*)conent target:(id)tar action:(SEL)action;
-(id)showNetWorkStatus;
@end
