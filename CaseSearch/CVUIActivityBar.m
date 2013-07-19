//
//  CVUIActivityBar.m
//  iphoneDemo
//
//  Created by rang on 13-4-26.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CVUIActivityBar.h"
#import <QuartzCore/QuartzCore.h>

#define RADIANS(deg) ((deg) * M_PI / 180.0f)

@interface CVUIActivityBar()
-(void)_initLoadView;
-(void)success;
-(void)failed;
-(void)addImage:(NSString*)name;
-(void)setMessage:(NSString*)msg;
@end

@implementation CVUIActivityBar
@synthesize loadMessage,successMessage,errorMessage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initLoadView];
    }
    return self;
}
-(id)initWithTitle:(NSString*)msg{
    if (self=[super init]) {
        [self _initLoadView];
        self.loadMessage=msg;
    }
    return self;
}
-(id)netWorkWithTitle:(NSString*)msg{
    if (self=[super init]) {
        self.alpha=0.9;
        self.backgroundColor=[UIColor blackColor];
        
        CGFloat h=40,leftX=5;
        
        CGRect rect=[[UIScreen mainScreen] bounds];
        CGRect orginRect=self.frame;
        orginRect.size.width=rect.size.width;
        orginRect.size.height=h;
        self.frame=orginRect;
        
        
        [self addImage:@"error.png"];
        
        UILabel *lab=(UILabel*)[self viewWithTag:100];
        if (lab==nil) {
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(leftX+25+5, 0, rect.size.width-35, h)];
            label.backgroundColor=[UIColor clearColor];
            label.font=[UIFont boldSystemFontOfSize:14];
            label.tag=100;
            label.textColor=[UIColor whiteColor];
            [self addSubview:label];
            [label release];
        }
        self.loadMessage=msg;
    }
    return self;
}
-(void)setLoadMessage:(NSString *)msg{
    if (loadMessage!=msg) {
        [loadMessage release];
        loadMessage=[msg copy];
    }
    [self setMessage:loadMessage];
}
#pragma mark -
#pragma mark 公有方法
-(void)show{
    CGRect rect=self.frame;
    rect.origin.x=0;
    rect.origin.y=0;
    [self setFrame:rect];
    
    CGPoint animateToCenter = self.center;
    [self setCenter:CGPointMake(self.center.x, self.center.y-self.bounds.size.height)];
    
    [UIView animateWithDuration:0.5f animations:^{
        self.center=animateToCenter;
    }];
}
-(void)showSuccess{
    [self success];
    [self hide];
}
-(void)showFailed{
    [self failed];
    [self hide];
}
-(void)hide{
    //CATransform3D viewOutEndTransform = CATransform3DMakeRotation(RADIANS(180), 1.0, 0.0, 0.0);
    //viewOutEndTransform.m34 = -1.0 / 100.0;
    [UIView animateWithDuration:0.3 delay:1.0f options:UIViewAnimationCurveEaseInOut animations:^{
        [self setCenter:CGPointMake(self.center.x, -self.bounds.size.height)];
        //self.layer.transform=viewOutEndTransform;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
#pragma mark -
#pragma mark 私有方法
-(void)_initLoadView{
    self.alpha=0.9;
    self.backgroundColor=[UIColor blackColor];
    //[UIColor whiteColor];
    
    CGFloat h=40,leftX=5;
    
    CGRect rect=[[UIScreen mainScreen] bounds];
    CGRect orginRect=self.frame;
    orginRect.size.width=rect.size.width;
    orginRect.size.height=h;
    self.frame=orginRect;
    
    
    _activityView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(leftX,(h-25)/2, 25, 25)];
    _activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    _activityView.hidesWhenStopped=YES;
    [self addSubview:_activityView];
    
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(leftX+25+5, 0, rect.size.width-35, h)];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont boldSystemFontOfSize:14];
    label.tag=100;
    label.textColor=[UIColor whiteColor];
    [self addSubview:label];
    [label release];
    
    [_activityView startAnimating];
}
-(void)addImage:(NSString*)name{
    if (_activityView) {
         [_activityView stopAnimating];
         [_activityView removeFromSuperview];
    }
   
    
    UIImage *img=[UIImage imageNamed:name];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(5,(40-img.size.height)/2, img.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.backgroundColor=[UIColor clearColor];
    [self addSubview:btn];
    
    
    //_sView=[[UIView alloc] initWithFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    
    
}
-(void)success{
    [self addImage:@"success.png"];
    [self setMessage:self.successMessage];
}
-(void)failed{
    [self addImage:@"error.png"];
    [self setMessage:self.errorMessage];
}
-(void)setMessage:(NSString*)msg{
    if (msg!=nil&&[msg length]>0) {
        UILabel *label=(UILabel*)[self viewWithTag:100];
        label.text=msg;
    }
}
-(void)dealloc{
    [loadMessage release];
    [successMessage release];
    [errorMessage release];
    [super dealloc];
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
