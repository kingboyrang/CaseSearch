//
//  ServiceHelper.h
//  HttpRequest
//
//  Created by aJia on 2012/10/27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ServiceArgs.h"
//block
typedef void (^progressRequestBlock)(ASIHTTPRequest *request);
typedef void (^blockFinished)(NSString *xml);
typedef void (^blockFailed)(NSError *error);
//队列
typedef void (^finishBlockRequest)(NSString *xml,NSDictionary *userInfo);
typedef void (^failedBlockRequest)(NSError *error,NSDictionary *userInfo);
typedef void (^finishBlockQueueComplete)();
//protocol
@protocol ServiceHelperDelegate<NSObject>
@optional
-(void)progressRequest:(ASIHTTPRequest*)request;
-(void)finishedRequest:(NSString*)xml;
-(void)failedRequest:(NSError*)error;
//队列
-(void)finishSoapRequest:(NSString*)xml userInfo:(NSDictionary*)dic;
-(void)failedSoapRequest:(NSError*)error userInfo:(NSDictionary*)dic;
-(void)finishQueueComplete;
@end

@interface ServiceHelper : NSObject{
    
    finishBlockRequest _finishBlock;
    failedBlockRequest _failedBlock;
    finishBlockQueueComplete _finishQueueBlock;
    
    
    progressRequestBlock _progressBlock;
    blockFinished _blockFinished;
    blockFailed _blockFailed;
     
}
@property(nonatomic,assign) id<ServiceHelperDelegate> delegate;
@property(nonatomic,retain) ASIHTTPRequest *httpRequest;
@property(nonatomic,retain) NSMutableArray *requestList;
@property(nonatomic,retain) ASINetworkQueue *networkQueue;
//单例模式
+ (ServiceHelper *)sharedInstance;
//初始化
-(id)initWithDelegate:(id<ServiceHelperDelegate>)theDelegate;


/******设置公有的请求****/
-(ASIHTTPRequest*)commonSharedRequest:(ServiceArgs*)args;
+(ASIHTTPRequest*)commonSharedRequest:(ServiceArgs*)args;

/******同步请求******/
-(NSString*)syncService:(ServiceArgs*)args;
/******异步请求******/
-(void)asynService:(ServiceArgs*)args;
-(void)asynService:(ServiceArgs*)args delegate:(id<ServiceHelperDelegate>)theDelegate;
-(void)asynService:(ServiceArgs*)args completed:(blockFinished)finish failed:(blockFailed)failed;
-(void)asynService:(ServiceArgs*)args progress:(progressRequestBlock)progress completed:(blockFinished)finish failed:(blockFailed)failed;
/******队列请求******/
//添加队列
-(void)addQueue:(ASIHTTPRequest*)request;
-(void)startQueue;
-(void)startQueue:(id<ServiceHelperDelegate>)theDelegate;
-(void)startQueue:(finishBlockRequest)finish failed:(failedBlockRequest)failed complete:(finishBlockQueueComplete)finishQueue;
@end
