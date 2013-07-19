//
//  PhotoViewController.h
//  iphoneDemo
//
//  Created by rang on 13-4-18.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    int total;
    int curPage;
}
@property (retain, nonatomic) IBOutlet UIView *phoneFrame;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollImage;
@property (retain, nonatomic) IBOutlet UIView *dotContainer;

@property(retain,nonatomic) UIPopoverController *popoverController;

@property(nonatomic,retain) UIViewController *popController;

- (IBAction)buttonPhoneClick:(id)sender;
- (IBAction)buttonCameraClick:(id)sender;
-(NSMutableArray*)imageToArray;
@end
