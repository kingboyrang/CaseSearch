//
//  HRBirthView.h
//  CaseSearch
//
//  Created by rang on 13-4-16.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUISelect.h"
@interface HRBirthView : UIViewController
@property(nonatomic,retain) CVUISelect *ddlRelative;
@property(nonatomic,retain) CVUISelect *ddlCategory;
-(BOOL)isVerify;
@end
