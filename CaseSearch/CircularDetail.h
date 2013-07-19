//
//  CircularDetail.h
//  CaseSearch
//
//  Created by rang on 12-11-24.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCircular.h"
@interface CircularDetail : UIView{
    CGRect orginRect;
}
@property(nonatomic,retain) VCircular *ItemCircular;
@property(nonatomic,retain) NSString *CircularIndex;
-(id)initWithData:(VCircular*)item WithIndex:(NSString*)index withFrame:(CGRect)frame;
-(void)loadConfigure;
-(CGFloat)stringSizeWith:(NSString*)str;
-(void)addLabel:(NSString*)text frame:(CGRect)frame;
@end
