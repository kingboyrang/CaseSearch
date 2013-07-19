//
//  ImageScrollViewController.h
//  Eland
//
//  Created by aJia on 2012/10/22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageScrollDelegate
@optional
-(void)finishScroll;
@end


@interface ImageScrollViewController : UIView<UIScrollViewDelegate>{
  int curPage;
}
@property(nonatomic,assign)  id<ImageScrollDelegate> delegate;
@property(nonatomic,retain)  UIScrollView *scrollView;
@property(nonatomic,retain)  NSArray *listData;//圖片來源
-(void)timerScrollImage;
//@property(nonatomic,retain) NSTimer *timer;//定時器
//載入元件
-(void)loadViewConfigure:(CGRect)frame;
//初始化
-(id)initWithListData:(NSArray*)arr withFrame:(CGRect)frame;
//圖片切換時更新選中狀態的圖片
-(void)UpdateBtnImg;
//設置第幾張圖片被選中
-(void)selectedScrollImage:(int)selectTag;
@end
