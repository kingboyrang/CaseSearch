//
//  NetworkConnectionRequest.h
//  MediaCenter
//
//  Created by rang on 13-1-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

//网络请求类
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef void(^failedNetworkConnection)(NSError *error);
typedef void(^successNetworkConnection)();

@interface NetworkConnectionRequest : NSObject{
    failedNetworkConnection _failedNetworkConnection;
    successNetworkConnection _successNetworkConnection;
}

@property(nonatomic,retain) ASIHTTPRequest *httpRequest;
//单例模式
+ (NetworkConnectionRequest *)sharedInstance;
-(void)startNetworkRequest:(NSString*)url successConnection:(successNetworkConnection)successAct failedConnection:(failedNetworkConnection)complete;
@end
