//
//  PushViewController.h
//  CaseSearch
//
//  Created by aJia on 12/11/26.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushViewController : UITableViewController{
    int selectRow;
}
- (IBAction)buttonEditClick:(id)sender;

@property(nonatomic,retain) NSMutableArray *listData;

-(void)updatePushData;
@end
