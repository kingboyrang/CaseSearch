//
//  CustomShowAlert.m
//  CaseSearch
//
//  Created by aJia on 13/1/22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CustomShowAlert.h"
#import <QuartzCore/QuartzCore.h>
@implementation CustomShowAlert
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadConfigure:frame];
    }
    return self;
}
-(void)loadConfigure:(CGRect)frame{
    
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    coverView=[[UIView alloc] initWithFrame:screenRect];
    coverView.backgroundColor=[UIColor darkGrayColor];
    coverView.alpha=0.85;
    [window addSubview:coverView];
    [window bringSubviewToFront:coverView];
    
    
    
    self.backgroundColor=[UIColor colorWithRed:0.25098 green:0.501961 blue:0 alpha:1];
    self.layer.borderWidth=1.0;
    self.layer.borderColor=[UIColor whiteColor].CGColor;
    self.layer.cornerRadius=5.0;
    
    //标题
    NSString *strTitle=@"提示";
    CGSize titleSize=[strTitle CalculateStringSize:[UIFont boldSystemFontOfSize:17] with:frame.size.width];
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,titleSize.height)];
    labTitle.textAlignment=NSTextAlignmentCenter;
    labTitle.text=strTitle;
    labTitle.backgroundColor=[UIColor clearColor];
    labTitle.font=[UIFont boldSystemFontOfSize:17];
    labTitle.textColor=[UIColor whiteColor];
    [self addSubview:labTitle];
    [labTitle release];
    
    //内容
    NSString *str=[AppSystem infoMessageMemo];
    CGSize textSize=[str CalculateStringSize:[UIFont systemFontOfSize:17] with:frame.size.width];
    UILabel *labContent=[[UILabel alloc] initWithFrame:CGRectMake(0, titleSize.height+2, frame.size.width,textSize.height)];
    //labContent.textAlignment=NSTextAlignmentLeft;
    
    labContent.lineBreakMode=NSLineBreakByWordWrapping;
    labContent.numberOfLines=0;
    labContent.text=str;
    labContent.backgroundColor=[UIColor clearColor];
    labContent.font=[UIFont systemFontOfSize:17];
    labContent.textColor=[UIColor whiteColor];
    
    [self addSubview:labContent];
    [labContent release];
    
    //按钮
    CGFloat top=titleSize.height+2+textSize.height+5;
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(frame.size.width/3, top,frame.size.width/3, 30);
    [button setBackgroundImage:[[UIImage imageNamed:@"bar_bg.png"] imageByScalingToSize:CGSizeMake(frame.size.width/3, 30)] forState:UIControlStateNormal];
    [button setTitle:@"確定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonCloseWin:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
    //重设大小
    //CGRect bound=[[UIScreen mainScreen] bounds];
    CGRect orginRect=frame;
    orginRect.size.height=top+35;
    orginRect.origin.y=orginRect.size.height*-1;
    //orginRect.origin.x=(bound.size.width-orginRect.size.width)/2;
    //orginRect.origin.y=(bound.size.height-orginRect.size.height)/2;
    self.frame=orginRect;
    

}
-(IBAction)buttonCloseWin:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeWin" object:self];
    [coverView removeFromSuperview];
    [coverView release];
    coverView=nil;
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
