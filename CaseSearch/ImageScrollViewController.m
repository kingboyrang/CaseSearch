//
//  ImageScrollViewController.m
//  Eland
//  圖片捲動
//  Created by aJia on 2012/10/22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageScrollViewController.h"


@implementation ImageScrollViewController
@synthesize scrollView,listData,delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
		[self loadViewConfigure:frame];
		//[self timerScrollImage];//定時捲動圖片
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

	//設定ScrollView捲動區域
    //通常必需大於ScrollerView的顯示區域
    //這樣才需要在ScrollerView中捲動圖片
    [self.scrollView setContentSize:CGSizeMake(frame.size.width * [self.listData count], fheight)];
	//開啟捲動分頁功能，如果不需要這個功能關閉即可
    [self.scrollView setPagingEnabled:YES];
    
    //隐藏横向與縱向的捲軸
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    //在本類別中繼承scrollView的整體事件
    [self.scrollView setDelegate:self];
	
	UIScrollView *customScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x,self.scrollView.frame.size.height+2,([self.listData count]-1)*42+25, 25)];
	 [customScroll setContentSize:CGSizeMake(([self.listData count]-1)*42+25, 25)];
	//開啟捲動分頁功能，如果不需要這個功能關閉即可
    [customScroll setPagingEnabled:YES];
    
    //隐藏横向與縱向的捲軸
    [customScroll setShowsVerticalScrollIndicator:NO];
    [customScroll setShowsHorizontalScrollIndicator:NO];
	for (int i =0; i<[self.listData count]; i++)
    {
        //在這裡幫每一個ScrollView新增一張圖片和一個按鈕
        UIImageView *imageView= [[[UIImageView alloc] initWithFrame:CGRectMake(i * frame.size.width,0,frame.size.width,fheight)] autorelease];
		//[imageView setImage:[UIImage imageNamed:[self.listData objectAtIndex:i]]];
		//透過url載入圖片
        //NSLog(@"path=%@\n",[self.listData objectAtIndex:i]);
		[imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.listData objectAtIndex:i]]]]];
		
        //把每頁需要顯示的VIEW新增到ScrollerView中
        [self.scrollView addSubview:imageView];
        if ([self.listData count]>1) {
       
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
            
        }
		
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
//點擊事件
-(void)buttonImageChange:(id)sender{
	int selTag=[(UIButton*)sender tag];
	[self selectedScrollImage:selTag];
	//捲動到指定位置
	[self.scrollView setContentOffset:CGPointMake((selTag-200)*self.scrollView.frame.size.width, 0) animated:YES];
}
//設定選中的圖片
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
	   [NSThread sleepForTimeInterval:2];//延遲兩秒
	   [self selectedScrollImage:curPage];
    }
}
#pragma mark -
#pragma mark scrollView delegate Methods
//手指離開螢幕後ScrollView還會繼續捲動一段時間直到停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	
	if (self.delegate!=nil) {
		[self.delegate finishScroll];
	}
	
	//NSLog(@"捲動結束後，緩衝捲動徹底完結時呼叫");
}

-(void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	
	//NSLog(@"捲動結束後，開始緩衝捲動時呼叫");
}

-(void)scrollViewDidScroll:(UIScrollView*)sv
{
	curPage=fabs(sv.contentOffset.x/sv.frame.size.width);//取得目前頁面
	[self UpdateBtnImg];
    //NSLog(@"圖片捲動中X=%f,y=%f",sv.contentOffset.x,sv.contentOffset.y);
	// NSLog(@"圖片捲動中y軸座標%f",);
	//NSLog(@"x=%f,y=%f",scrollView.frame.origin.x,scrollView.frame.origin.y);
}

-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    //NSLog(@"捲動圖片開始捲動，它只呼叫一次");
}

-(void)scrollViewDidEndDragging:(UIScrollView*)sv willDecelerate:(BOOL)decelerate
{
	
	//NSLog(@"捲動圖片結束捲動，它只呼叫一次");
	
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
