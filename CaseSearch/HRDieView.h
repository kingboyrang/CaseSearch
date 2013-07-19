//
//  HRDieView.h
//  CaseSearch
//
//  Created by rang on 13-4-16.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUISelect.h"
@interface HRDieView : UIViewController
@property(nonatomic,retain) CVUISelect *ddlRelative;
@property(nonatomic,retain) CVUISelect *ddlCategory;
@property (retain, nonatomic) IBOutlet UITextField *txtDieName;
@property (retain, nonatomic) IBOutlet UITextField *txtDieAddress;


-(BOOL)isVerify;
- (IBAction)buttonExitToEdit:(id)sender;

@end
