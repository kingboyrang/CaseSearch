//
//  CircularDetail.m
//  CaseSearch
//
//  Created by rang on 12-11-24.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "CircularDetail.h"
#import "CircularType.h"
@implementation CircularDetail
@synthesize ItemCircular,CircularIndex;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        orginRect=frame;
        [self loadConfigure];
    }
    return self;
}
-(id)initWithData:(VCircular*)item WithIndex:(NSString*)index withFrame:(CGRect)frame{
    self.ItemCircular=item;
    self.CircularIndex=index;
    return [self initWithFrame:frame];
}
-(void)loadConfigure{
    UIFont *f=[UIFont boldSystemFontOfSize:17];
    CGFloat w=self.frame.size.width;
    CGFloat h=self.frame.size.height;
    //编号
    NSString *strNumber=[self.ItemCircular.Number Trim];
    CGSize  numberSize=[strNumber CalculateStringSize:f with:w];
    [self addLabel:strNumber frame:CGRectMake(5,(h-numberSize.height)/2, numberSize.width,numberSize.height)];

    CGFloat lefx=numberSize.width+5+1;
    
    
    //暱稱:
    NSString *nickMemo=@"暱稱:";
    CGSize nickMemoSize=[nickMemo CalculateStringSize:f with:w];
    [self addLabel:nickMemo frame:CGRectMake(lefx, 0, nickMemoSize.width, nickMemoSize.height)];
    
    
    NSString *nickName=[self.ItemCircular.Nick Trim];
    CGSize nickSize=[nickName CalculateStringSize:f with:w];
    [self addLabel:nickName frame:CGRectMake(lefx+nickMemoSize.width+1, 0, nickSize.width,nickSize.height)];
    
    //類別名稱
    NSString *cateName=[self.ItemCircular CategoryName];
    CGSize cateSize=[cateName CalculateStringSize:f with:w];
    [self addLabel:cateName frame:CGRectMake(lefx, nickMemoSize.height+1, cateSize.width, cateSize.height)];
    
    //发布时间
    NSString *pubDate=[self.ItemCircular formatDataTw];
    CGSize dateSize=[pubDate CalculateStringSize:f with:w];
    [self addLabel:pubDate frame:CGRectMake(lefx, nickMemoSize.height+cateSize.height+1, dateSize.width, dateSize.height)];
       
    //狀態
    NSString *statusMemo=[self.ItemCircular ApprovalStatusText];
    CGSize statusSize=[statusMemo CalculateStringSize:[UIFont systemFontOfSize:20] with:orginRect.size.width];
    UILabel *labStatus=[[UILabel alloc] initWithFrame:CGRectMake(orginRect.size.width-statusSize.width,(orginRect.size.height-statusSize.height)/2, statusSize.width,statusSize.height)];
    labStatus.font=[UIFont systemFontOfSize:20];
    labStatus.backgroundColor=[UIColor clearColor];
    //[UIFont fontWithName:@"Helvetica Bold" size:17];
    //labStatus.textColor=[UIColor colorWithRed:0.25098 green:0.501961 blue:0 alpha:1];
    if ([self.ItemCircular.ApprovalStatus isEqualToString:@"1"]) {
        labStatus.textColor=[UIColor redColor];
    }else{
        labStatus.textColor=[UIColor colorWithRed:0.25098 green:0.501961 blue:0 alpha:1];
    }
    labStatus.textColor=[UIColor redColor];
    labStatus.text=statusMemo;
    [self addSubview:labStatus];
    [labStatus release];
}
-(void)addLabel:(NSString*)text frame:(CGRect)frame{
    UIFont *f=[UIFont boldSystemFontOfSize:17];
    UILabel *lab=[[UILabel alloc] initWithFrame:frame];
    lab.font=f;
    lab.backgroundColor=[UIColor clearColor];
    lab.text=text;
    [self addSubview:lab];
    [lab release];
    
}
-(CGFloat)stringSizeWith:(NSString*)str{
    if (str==nil||str==NULL||[str length]==0) {
        return 0;
    }
    CGSize textSize=[str CalculateStringSize:[UIFont boldSystemFontOfSize:20] with:orginRect.size.width];
    return textSize.width;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)dealloc{
    [super dealloc];
    [ItemCircular release];
    [CircularIndex release];
}
@end
