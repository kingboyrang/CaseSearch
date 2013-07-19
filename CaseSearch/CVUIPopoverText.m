//
//  CVUIPopoverText.m
//  CalendarDemo
//
//  Created by rang on 13-3-12.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CVUIPopoverText.h"

@implementation CVUIPopoverText
@synthesize popoverTextField,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //文本框显示日期
        self.popoverTextField=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.popoverTextField.borderStyle=UITextBorderStyleRoundedRect;
        self.popoverTextField.placeholder=@"請選擇";
        self.popoverTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//設定本文垂直置中
        self.popoverTextField.enabled=NO;//设置不可以编辑
        self.popoverTextField.font=[UIFont systemFontOfSize:14];
        //设置按钮
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(buttonChooseClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.popoverTextField];
        [self addSubview:btn];
        [btn release];
        
        frame.origin.x=0;
        frame.origin.y=0;
        self.frame=frame;

    }
    return self;
}
-(void)buttonChooseClick{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(doneShowPopoverView)]) {
        [self.delegate doneShowPopoverView];
    }
}

-(void)dealloc{
    [popoverTextField release];
    [super dealloc];
}
@end
