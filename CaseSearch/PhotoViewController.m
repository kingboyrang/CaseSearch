//
//  PhotoViewController.m
//  iphoneDemo
//
//  Created by rang on 13-4-18.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "PhotoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"
@interface PhotoViewController ()
-(void)updateButtonPostion;
-(void)updateImagePosition;
-(void)updateButtonSelected:(int)index;
-(void)showConfirmAndCancel:(NSString*)title
                withMessage:(NSString*)msg
              cancelMessage:(NSString*)cancelMsg
             confirmMessage:(NSString*)confirmMsg
               cancelAction:(void (^)(void))act
              confirmAction:(void (^)(void))confirmAct;
-(void)initPopoverController;
@end

@implementation PhotoViewController
@synthesize popController,popoverController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.phoneFrame.layer.borderWidth=2.0;
    self.phoneFrame.layer.borderColor=[UIColor grayColor].CGColor;
    self.phoneFrame.layer.cornerRadius=5.0;
    
    total=0;
    
    //设置背景
    CGRect bound=self.scrollImage.bounds;
    UIImage *bgImg=[[UIImage imageNamed:@"nopic.png"] imageByScalingToSize:CGSizeMake(bound.size.width, bound.size.height)];
    self.scrollImage.backgroundColor=[UIColor colorWithPatternImage:bgImg];
    
    //开启滚动分页功能，如果不需要这个功能关闭即可
    [self.scrollImage setPagingEnabled:YES];
    
    //隐藏横向与纵向的滚动条
    [self.scrollImage setShowsVerticalScrollIndicator:NO];
    [self.scrollImage setShowsHorizontalScrollIndicator:NO];
    
    //在本类中代理scrollView的整体事件
    [self.scrollImage setDelegate:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//相册
- (IBAction)buttonPhoneClick:(id)sender {
    UIButton *btn=(UIButton*)sender;
    if (total==3) {
        return;
    }
    
    [self initPopoverController];
    
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.allowsEditing=YES;//是否允许编辑
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if ([AppSystem isIPad]) {
        self.popoverController.contentViewController=picker;
        [self.popoverController presentPopoverFromRect:btn.frame inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
        [self.popController presentViewController:picker animated:YES completion:nil];
    }
    [picker release];
}
//照相机
- (IBAction)buttonCameraClick:(id)sender {
    if (total==3) {
        return;
    }
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.allowsEditing=YES;//是否允许编辑
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        [picker release];
        return;
    }
    [self.popController presentViewController:picker animated:YES completion:nil];
    [picker release];
}
-(void)buttonDotClick:(id)sender{
    UIButton *btn=(UIButton*)sender;
    int index=btn.tag;
    [self showConfirmAndCancel:@"提示"
                   withMessage:nil
                 cancelMessage:@"取消"
                confirmMessage:@"移除"
                  cancelAction:nil confirmAction:^(){
                      UIImageView *img=(UIImageView*)[self.scrollImage viewWithTag:500+index-100];
                      if (img) {
                          [img removeFromSuperview];
                          total--;
                      }
                      [btn removeFromSuperview];
                      [self updateButtonPostion];
                      [self updateImagePosition];
                  }];
}
#pragma mark -
#pragma mark 公有方法
-(NSMutableArray*)imageToArray{
    NSMutableArray *arr=[NSMutableArray array];
    for (UIImageView *imageView in self.scrollImage.subviews) {
        if (imageView) {
            UIImage *img=imageView.image;
            NSString *imgName=[NSString stringWithFormat:@"%@.jpg",[NSString NewGuid]];
            [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:imgName,@"Name",[UIImage image2String:img],@"Content", nil]];
        }
    }
   
    return arr;
}
#pragma mark -
#pragma mark 私有方法
-(void)updateButtonPostion{
    CGFloat space=5,leftX=(self.dotContainer.bounds.size.width-(25*total+(total-1)*space))/2;
    int count=1;
    for (id v in self.dotContainer.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton*)v;
            CGRect rect=btn.frame;
            rect.origin.x=leftX+(count-1)*(25+space);
            btn.frame=rect;
            btn.tag=100+count;
            count++;
        }
    }
}
-(void)updateImagePosition{
    int count=1;
    for (id v in self.scrollImage.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView=(UIImageView*)v;
            imageView.tag=500+count;
            CGRect rect=imageView.frame;
            rect.origin.x=(count-1)*self.scrollImage.bounds.size.width;
            imageView.frame=rect;
            count++;
        }
    }
    CGFloat f=self.scrollImage.bounds.size.width;
    if (total>2) {
        f=f*total;
    }
    self.scrollImage.contentSize=CGSizeMake(f,self.scrollImage.bounds.size.height);
}
-(void)updateButtonSelected:(int)index{
    int tag=100+index+1;
    UIButton *btn=(UIButton*)[self.dotContainer viewWithTag:tag];
    btn.selected=YES;
    for (id  v in self.dotContainer.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *button=(UIButton*)v;
            if (button.tag!=tag) {
                button.selected=NO;
            }
        }
    }
}
-(void)showConfirmAndCancel:(NSString*)title withMessage:(NSString*)msg cancelMessage:(NSString*)cancelMsg confirmMessage:(NSString*)confirmMsg cancelAction:(void (^)(void))act confirmAction:
(void (^)(void))confirmAct{
    
    RIButtonItem *cancelButton=[RIButtonItem item];
    cancelButton.label=cancelMsg;
    cancelButton.action=act;
    
    
    RIButtonItem *button=[RIButtonItem item];
    button.label=confirmMsg;
    button.action=confirmAct;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title
                                                  message:msg
                                         cancelButtonItem:cancelButton
                                         otherButtonItems:button, nil];
    [alert show];
    [alert release];
}
-(void)initPopoverController{
    if ([AppSystem isIPad]) {
        if (!self.popoverController) {
            CGSize s=CGSizeMake(320, 300);
            UIViewController *popView=[[UIViewController alloc] init];
            popView.contentSizeForViewInPopover=s;
            self.popoverController=[[UIPopoverController alloc] initWithContentViewController:popView];
            self.popoverController.popoverContentSize=s;
            [popView release];
        }
    }
}
#pragma mark -
#pragma mark UIImagePickerController  Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    total++;
	
	UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(total*self.scrollImage.bounds.size.width, 0,self.scrollImage.bounds.size.width, self.scrollImage.bounds.size.height)];
    imageView.tag=500+total;
    [imageView setImage:image];
    [self.scrollImage addSubview:imageView];
    [imageView release];
    
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 25, 25);
    btn.tag=100+total;
    [btn setImage:[UIImage imageNamed:@"dot_default.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"dot_selected.png"] forState:UIControlStateSelected];
    btn.selected=YES;
    [btn addTarget:self action:@selector(buttonDotClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.dotContainer addSubview:btn];
    [self updateButtonPostion];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark scrollView delegate Methods
//手指离开屏幕后ScrollView还会继续滚动一段时间只到停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	//NSLog(@"结束滚动后缓冲滚动彻底结束时调用");
}

-(void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	//NSLog(@"结束滚动后开始缓冲滚动时调用");
}
-(void)scrollViewDidScroll:(UIScrollView*)sv
{
	curPage=fabs(sv.contentOffset.x/sv.frame.size.width);//获取当前页
	[self updateButtonSelected:curPage];
    //NSLog(@"视图滚动中X=%f,y=%f",sv.contentOffset.x,sv.contentOffset.y);
	// NSLog(@"视图滚动中y轴坐标%f",);
}
-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    //NSLog(@"滚动视图开始滚动，它只调用一次");
}
-(void)scrollViewDidEndDragging:(UIScrollView*)sv willDecelerate:(BOOL)decelerate
{
	//NSLog(@"滚动视图结束滚动，它只调用一次");
}
- (void)dealloc {
    [_phoneFrame release];
    [_scrollImage release];
    [_dotContainer release];
    [popoverController release];
    [super dealloc];
}
@end
