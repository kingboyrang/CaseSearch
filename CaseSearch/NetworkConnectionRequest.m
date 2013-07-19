//
//  NetworkConnectionRequest.m
//  MediaCenter
//
//  Created by rang on 13-1-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "NetworkConnectionRequest.h"
#import "NetWorkConnection.h"
#import "AlterMessage.h"
@implementation NetworkConnectionRequest
@synthesize httpRequest;
//单例模式
+ (NetworkConnectionRequest *)sharedInstance{
    static dispatch_once_t  onceToken;
    static NetworkConnectionRequest * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[NetworkConnectionRequest alloc] init];
    });
    return sSharedInstance;
}
-(void)startNetworkRequest:(NSString*)url successConnection:(successNetworkConnection)successAct failedConnection:(failedNetworkConnection)complete{
    
    Block_release(_failedNetworkConnection);
    Block_release(_successNetworkConnection);
    _failedNetworkConnection=Block_copy(complete);
    _successNetworkConnection=Block_copy(successAct);
    
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:NO];//是否显示网络请求信息在status bar上：
    
    [self.httpRequest clearDelegatesAndCancel];
    [self setHttpRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.httpRequest setDelegate:self];
    [self.httpRequest startAsynchronous];
}
#pragma mark -
#pragma mark ASIHTTPRequest delegate Methods
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    if ([request contentLength]>0) {//表示可以请求
        [self.httpRequest clearDelegatesAndCancel];//取消请求
        
        if (_successNetworkConnection) {
            _successNetworkConnection();
        }
    }
}
//下载成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
}
//下载失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
  
    if (_failedNetworkConnection) {
        _failedNetworkConnection([request error]);
    }

}
-(void)dealloc{
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    Block_release(_failedNetworkConnection);
    Block_release(_successNetworkConnection);
    [super dealloc];
}
@end
