//
//  UIBarButtonItem+CustomBarButtonItem.m
//  Bullet
//
//  Created by rang on 12-11-13.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "UIBarButtonItem+CustomBarButtonItem.h"
#import <QuartzCore/QuartzCore.h>
#import "NetWorkConnection.h"
#import "NetworkConnectionRequest.h"
@implementation UIBarButtonItem (CustomBarButtonItem)
-(id)CustomViewButtonItem:(NSString*)conent target:(id)tar action:(SEL)act{
    if (self=[super init]) {
        CGFloat h=31;
        CGFloat w=(132*h)/67;
        UIImage *leftImage=[[UIImage imageNamed:@"back.png"] imageByScalingToSize:CGSizeMake(w, h)];
        UIButton *customBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customBackButton.frame=CGRectMake(0, 0, w, h);
        [customBackButton setBackgroundImage:leftImage forState:UIControlStateNormal];
        [customBackButton addTarget:tar action:act forControlEvents:UIControlEventTouchDown];
        [self initWithCustomView:customBackButton];
    }
    return self;
}
-(id)showNetWorkStatus{
    if (self=[super init]) {
        //gps wifi
        NSString *gpsName=@"gps_of.png";
        __block NSString *wifiName=@"wifi_off.png";
        if ([NetWorkConnection isOpenGps]) {
            gpsName=@"gps_on.png";
        }
        if ([NetWorkConnection IsEnableWIFI]) {
            wifiName=@"wifi_on.png";
        }
        
        [[NetworkConnectionRequest sharedInstance] startNetworkRequest:defaultWebServiceUrl successConnection:^(){
            wifiName=@"wifi_on.png";
        
        } failedConnection:^(NSError *error){
            wifiName=@"wifi_off.png";
        
        }];
        
        UIImage *img1=[[UIImage imageNamed:gpsName] imageByScalingToSize:CGSizeMake(25, 25)];
        UIImageView *imgView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [imgView1 setImage:img1];
        
        UIImage *img2=[[UIImage imageNamed:wifiName] imageByScalingToSize:CGSizeMake(25, 25)];
        UIImageView *imgView2=[[UIImageView alloc] initWithFrame:CGRectMake(27, 0, 25,25)];
        [imgView2 setImage:img2];
        
        UIView *customView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, imgView2.frame.origin.x+imgView2.frame.size.width, imgView2.frame.size.height)];
        
        [customView addSubview:imgView1];
        [customView addSubview:imgView2];
        customView.backgroundColor=[UIColor clearColor];
        
        self.width=customView.frame.size.width;
        
        [self initWithCustomView:customView];
        [imgView1 release];
        [imgView2 release];
        [customView release];
        //UIImageView *image1=[];
    }
    return self;
}
@end
