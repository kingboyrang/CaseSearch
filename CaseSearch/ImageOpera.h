//
//  ImageScrollViewController.h
//  Eland
//
//  Created by aJia on 2012/10/22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageOperaDelegate
@optional
//-(void)finishScroll;
-(void)changeImage:(int)tag withButtonIndex:(int)buttonIndex;
@end


@interface ImageOpera : UIView<UIAlertViewDelegate,UIScrollViewDelegate>{
  int curPage;
	int curImgTag;
}
@property(nonatomic,assign)  id<ImageOperaDelegate> delegate;
@property(nonatomic,retain)  UIScrollView *scrollView;
@property(nonatomic,retain)  NSArray *listData;//图片数据源
-(void)timerScrollImage;
//@property(nonatomic,retain) NSTimer *timer;//定时器
//加载控件
-(void)loadViewConfigure:(CGRect)frame;
//初始化
-(id)initWithListData:(NSArray*)arr withFrame:(CGRect)frame;
//图片切换时更新选中状态的图片
-(void)UpdateBtnImg;
//设置第几张图片被选中
-(void)selectedScrollImage:(int)selectTag;

-(NSString*)ImagesStringList;
-(NSMutableArray*)UploadImageArray;
@end
