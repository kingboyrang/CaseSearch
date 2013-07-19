//
//  HRMarryView.h
//  CaseSearch
//
//  Created by rang on 13-4-16.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUISelect.h"
@interface HRMarryView : UIViewController
@property(nonatomic,retain) CVUISelect *ddlCategory;
@property (retain, nonatomic) IBOutlet UITextField *boyName;
@property (retain, nonatomic) IBOutlet UITextField *girlName;
@property (retain, nonatomic) IBOutlet UITextField *boyAddress;
@property (retain, nonatomic) IBOutlet UITextField *girlAddress;
-(BOOL)isVerify;
- (IBAction)buttonExitToEditor:(id)sender;

@end
