//
//  CVUICalendar.m
//  CalendarDemo
//
//  Created by rang on 13-3-11.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CVUICalendar.h"



@interface CVUICalendar()
-(void)loadControl:(CGRect)frame;
-(void)setCalendarValue;
@end


@implementation CVUICalendar
@synthesize popoverText;
@synthesize dateForFormat;
@synthesize datePicker;
@synthesize popoverView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadControl:frame];
                
    }
    return self;
}
//设置日期格式
-(void)setDateForFormat:(NSDateFormatter *)format{
    if (dateForFormat!=format) {
        [dateForFormat release];
        [format retain];
        dateForFormat=format;
    }
}
#pragma mark -
#pragma mark CVUIPopoverTextDelegate Methods
-(void)doneShowPopoverView{
    if (self.popoverView) {
        [self.popoverView show:self];
    }
}
#pragma mark -
#pragma mark CVUIPopoverViewDelegate Methods
-(void)showPopoverView{
   [self setCalendarValue];//赋值
}
-(void)donePopoverView{
    self.popoverText.popoverTextField.text  =[self.dateForFormat stringFromDate:self.datePicker.date];
}
-(void)clearPopoverView{
    self.popoverText.popoverTextField.text=@"";
}
#pragma mark -
#pragma mark 私有方法
-(void)loadControl:(CGRect)frame{
    self.popoverText=[[CVUIPopoverText alloc] initWithFrame:frame];
    self.popoverText.delegate=self;
    [self addSubview:self.popoverText];

    
    
    //設定日曆格式
    self.dateForFormat=[[NSDateFormatter alloc] init];
    [self.dateForFormat setDateFormat:@"yyyy-MM-dd"];
    
    //日期控件
    if (!self.datePicker) {
        self.datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        self.datePicker.datePickerMode=1;
		self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedString(@"LocaleIdentifier", @"")];
        //self.datePicker.maximumDate=[NSDate date];//设置最大日期
    }
    
    if (!self.popoverView) {
        self.popoverView=[[CVUIPopoverView alloc] initWithFrame:CGRectZero];
        self.popoverView.delegate=self;
        [self.popoverView addChildView:self.datePicker];
    }
   
    
}
-(void)setCalendarValue{
    if (self.datePicker&&self.dateForFormat&&self.popoverText&&[self.popoverText.popoverTextField.text length]>0) {
        NSDate *date = [self.dateForFormat dateFromString:self.popoverText.popoverTextField.text];
        [self.datePicker setDate:date animated:YES];
    }
}
-(void)dealloc{
    [popoverText release];
    [dateForFormat release];
    [datePicker release];
    [popoverView release];
    [super dealloc];
}
@end
