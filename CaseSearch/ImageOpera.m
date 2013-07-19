//
//  ImageScrollViewController.m
//  Eland
//  图片滚动
//  Created by aJia on 2012/10/22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageOpera.h"


@implementation ImageOpera
@synthesize scrollView,listData,delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
		[self loadViewConfigure:frame];
		//[self timerScrollImage];//定时滚动图片
    }
    return self;
}
-(id)initWithListData:(NSArray*)arr withFrame:(CGRect)frame
{
	self.listData=arr;
	return [self initWithFrame:frame];
}
-(void)loadViewConfigure:(CGRect)frame{
	CGFloat fheight=frame.size.height-27;
	self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,fheight)];

    UIImage *bgImg=[[UIImage imageNamed:@"nopic.png"] imageByScalingToSize:CGSizeMake(frame.size.width, fheight)];
    self.scrollView.backgroundColor=[UIColor colorWithPatternImage:bgImg];
    
	//设置ScrollView滚动内容的区域
    //它通常是需要大于ScrollerView的显示区域的
    //这样才有必要在ScrollerView中滚动它
    [self.scrollView setContentSize:CGSizeMake(frame.size.width * [self.listData count], fheight)];
	//开启滚动分页功能，如果不需要这个功能关闭即可
    [self.scrollView setPagingEnabled:YES];
    
    //隐藏横向与纵向的滚动条
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    //在本类中代理scrollView的整体事件
    [self.scrollView setDelegate:self];
	
	UIScrollView *customScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x,self.scrollView.frame.size.height+2,([self.listData count]-1)*42+25, 25)];
	 [customScroll setContentSize:CGSizeMake(([self.listData count]-1)*42+25, 25)];
	//开启滚动分页功能，如果不需要这个功能关闭即可
    [customScroll setPagingEnabled:YES];
    
    //隐藏横向与纵向的滚动条
    [customScroll setShowsVerticalScrollIndicator:NO];
    [customScroll setShowsHorizontalScrollIndicator:NO];
	for (int i =0; i<[self.listData count]; i++)
    {
        //在这里给每一个ScrollView添加一个图片 和一个按钮
        UIImageView *imageView= [[[UIImageView alloc] initWithFrame:CGRectMake(i * frame.size.width,0,frame.size.width,fheight)] autorelease];
		imageView.tag=100+i;
		[imageView setImage:[UIImage imageNamed:[self.listData objectAtIndex:i]]];
        //把每页需要显示的VIEW添加进ScrollerView中
        [self.scrollView addSubview:imageView];
		UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
		UIImage *img=[UIImage imageNamed:@"white_dot.png"];
		[btn setImage:img forState:UIControlStateSelected];
		[btn setImage:[UIImage imageNamed:@"dark_dot.png"] forState:UIControlStateNormal];
		if (i==0) {
			[btn setSelected:YES];
		}else {
			[btn setSelected:NO];
		}
		btn.tag=200+i;
		btn.frame=CGRectMake(i*(img.size.width+17),0, img.size.width,img.size.height);
		[btn addTarget:self action:@selector(buttonImageChange:) forControlEvents:UIControlEventTouchUpInside];
		//NSLog(@"w=%f\n",img.size.width);
		[customScroll addSubview:btn];
		//[self addSubview:btn];

    }
	CGRect srect=customScroll.frame;
	srect.origin.x=(frame.size.width-srect.size.width)/2.0;
	customScroll.frame=srect;
	//NSLog(@"%@\n",NSStringFromCGRect(srect));
	[self addSubview:self.scrollView];
	[self addSubview:customScroll];
	[customScroll release];
	
	curPage=0;
}
//点击事件
-(void)buttonImageChange:(id)sender{
	int selTag=[(UIButton*)sender tag];
	[self selectedScrollImage:selTag];
	//滚动到指定位置
	[self.scrollView setContentOffset:CGPointMake((selTag-200)*self.scrollView.frame.size.width, 0) animated:YES];
	
	curImgTag=selTag;
	UIAlertView *alterView=[[UIAlertView alloc] initWithTitle:@"提示" 
													  message:nil 
													 delegate:self 
											cancelButtonTitle:@"取消" 
											otherButtonTitles:@"拍照",@"相簿",@"移除",nil];
	[alterView show];
	[alterView release];
	
}
-(NSString*)ImagesStringList{
    NSMutableString *soapImage=[NSMutableString stringWithFormat:@""];
    for (int i=100;i<103;i++) {
        UIImageView *v=(UIImageView*)[self viewWithTag:i];
        if (v!=nil&&v.image!=nil) {
            UIImage *img=v.image;
            NSString *imgName=[NSString stringWithFormat:@"%@.jpg",create_guid()];
            [soapImage appendString:@"&lt;CircularImage&gt;"];
            [soapImage appendFormat:@"&lt;Name&gt;%@&lt;/Name&gt;",imgName];
            [soapImage appendFormat:@"&lt;Content&gt;%@&lt;/Content&gt;",[UIImage image2String:img]];
            [soapImage appendString:@"&lt;/CircularImage&gt;"];
        }
    }
    if ([soapImage length]==0) {
        return @"";
    }
    return [NSString stringWithFormat:@"&lt;Images&gt;%@&lt;/Images&gt;",soapImage];
}
-(NSMutableArray*)UploadImageArray{
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=100;i<103;i++) {
        UIImageView *v=(UIImageView*)[self viewWithTag:i];
        if (v!=nil&&v.image!=nil) {
            UIImage *img=v.image;
            NSString *imgName=[NSString stringWithFormat:@"%@.jpg",create_guid()];
            [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:imgName,@"Name",[UIImage image2String:img],@"Content", nil]];
        }
    }
    return arr;
    
}
//生成guid
NSString * create_guid()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}
#pragma mark -
#pragma mark UIAlertView delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (self.delegate!=nil) {
		//[self.delegate changeImage:curImgTag-100];
		[self.delegate changeImage:curImgTag-100 withButtonIndex:buttonIndex];
	}
}
//设置选中的图片
-(void)selectedScrollImage:(int)selectTag{
	UIButton *btn=(UIButton*)[self viewWithTag:selectTag];
	[btn setSelected:YES];
	for (int i=200; i<200+[self.listData count]; i++) {
		UIButton *btn1=(UIButton*)[self viewWithTag:i];
		if (selectTag!=i) {
			[btn1 setSelected:NO];
		}
	}
}
-(void)timerScrollImage{
	BOOL b=YES;
   while (TRUE) {
	   if (b) {
		   curPage++;
	   }else {
		   curPage--;
	   }
	   if (curPage>=[self.listData count]-1) {
		   curPage=[self.listData count]-1;
		   b=NO;
	   }
	   if (curPage<=0) {
		   curPage=0;
		   b=YES;
	   }
	   [NSThread sleepForTimeInterval:2];//延迟两秒
	   [self selectedScrollImage:curPage];
    }
}
#pragma mark -
#pragma mark scrollView delegate Methods
//手指离开屏幕后ScrollView还会继续滚动一段时间只到停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	/**
	if (self.delegate!=nil) {
		[self.delegate finishScroll];
	}
	**/
	//NSLog(@"结束滚动后缓冲滚动彻底结束时调用");
}

-(void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	
	//NSLog(@"结束滚动后开始缓冲滚动时调用");
}

-(void)scrollViewDidScroll:(UIScrollView*)sv
{
	curPage=fabs(sv.contentOffset.x/sv.frame.size.width);//获取当前页
	[self UpdateBtnImg];
    //NSLog(@"视图滚动中X=%f,y=%f",sv.contentOffset.x,sv.contentOffset.y);
	// NSLog(@"视图滚动中y轴坐标%f",);
	//NSLog(@"x=%f,y=%f",scrollView.frame.origin.x,scrollView.frame.origin.y);
}

-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    //NSLog(@"滚动视图开始滚动，它只调用一次");
}

-(void)scrollViewDidEndDragging:(UIScrollView*)sv willDecelerate:(BOOL)decelerate
{
	
	//NSLog(@"滚动视图结束滚动，它只调用一次");
	
}
-(void)UpdateBtnImg{
	int tag=curPage+200;
	[self selectedScrollImage:tag];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[self.scrollView release];
	[self.listData release];
    [super dealloc];
}


@end
