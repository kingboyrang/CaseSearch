//
//  CVUIActivityBar.h
//  iphoneDemo
//
//  Created by rang on 13-4-26.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVUIActivityBar : UIView{
    
@private
    UIActivityIndicatorView *_activityView;
}
@property(nonatomic,copy) NSString *loadMessage;
@property(nonatomic,copy) NSString *successMessage;
@property(nonatomic,copy) NSString *errorMessage;
-(id)initWithTitle:(NSString*)msg;
-(id)netWorkWithTitle:(NSString*)msg;
-(void)show;
-(void)showSuccess;
-(void)showFailed;
-(void)hide;
@end
