//
//  skipSegue.m
//  CaseSearch
//
//  Created by rang on 13-1-22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SkipStory.h"

@implementation SkipStory
-(void)perform{
    UserSet *user=[UserSet systemUser];
    //如果使用者未设定就跳转到使用者设定中
    if (!user) {
        [AppSystem showAlterTip];//显示提示信息
        return;
    }else{
        UIViewController *current=self.sourceViewController;
        UIViewController *next=self.destinationViewController;
        [current.navigationController pushViewController:next animated:YES];
    }
}
@end
