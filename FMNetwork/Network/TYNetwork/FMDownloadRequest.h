//
//  FMDownloadRequest.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/28.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDownloadRequest;

typedef void(^FMDownloadRequestBlock)(FMDownloadRequest *req);

@protocol FMDownloadRequestDelegate <NSObject>

@required

//request url
-(NSString *)downloadUrl;
//downloaded local path
-(NSString *)downloadDestinationPath;

@end

@interface FMDownloadRequest : NSObject<FMDownloadRequestDelegate>

@property (nonatomic, copy) FMDownloadRequestBlock inProgress;
@property (nonatomic, copy) FMDownloadRequestBlock completionHandler;
/**
 The dispatch group for `completionBlock`. If `NULL` (default), a private dispatch group is used.
 */
@property (nonatomic, strong) dispatch_group_t completionGroup;

/**
 The dispatch queue for `completionBlock`. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, strong) dispatch_queue_t completionQueue;
/**
 *  @brief request progress.
 */
@property (nonatomic, strong) NSProgress *progress;
@property (nonatomic, strong) NSURL *filePath;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *destinationPath;

- (instancetype)initWithUrl:(NSString *)url andDestinationPath:(NSString *)destinationPath;
-(void)startDownload;
-(void)startDownloadWithCompletionHandle:(FMDownloadRequestBlock)completionHandle;
-(void)startDownloadWithProgress:(FMDownloadRequestBlock)progressBlock completionHandle:(FMDownloadRequestBlock )completionHandle;

-(void)cancelDownload;

-(void)suspendDownload;
//continue
-(void)contiueDownload;

-(void)clearBlock;


@end
