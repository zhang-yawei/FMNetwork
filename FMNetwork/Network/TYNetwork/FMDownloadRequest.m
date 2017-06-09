//
//  FMDownloadRequest.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/28.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMDownloadRequest.h"
#import "FMDownloadRequestHandler.h"

@implementation FMDownloadRequest

- (instancetype)initWithUrl:(NSString *)url andDestinationPath:(NSString *)destinationPath
{
    self = [super init];
    if (self) {
        self.url = url;
        self.destinationPath = destinationPath;
    }
    return self;
}
-(NSString *)downloadUrl
{
    return self.url;
}

-(NSString *)downloadDestinationPath
{
    return self.destinationPath;
}

-(void)startDownload
{
    [self startDownloadWithCompletionHandle:nil];
}

-(void)startDownloadWithCompletionHandle:(FMDownloadRequestBlock)completionHandle
{
    [self startDownloadWithProgress:nil completionHandle:completionHandle];
}

-(void)startDownloadWithProgress:(FMDownloadRequestBlock)progressBlock completionHandle:(FMDownloadRequestBlock )completionHandle
{
    if (progressBlock) {
        self.inProgress = progressBlock;
    }
    if (completionHandle) {
        self.completionHandler = completionHandle;
    }
    
    [[FMDownloadRequestHandler sharedInstance] addDownloadRequest:self];
}



-(void)cancelDownload
{
    [[FMDownloadRequestHandler sharedInstance] removeDownloadRequest:self];
}

-(void)suspendDownload
{
    [self.downloadTask suspend];
}

-(void)contiueDownload
{
    [self.downloadTask resume];
}

-(void)clearBlock
{
    self.inProgress = nil;
    self.completionHandler = nil;
}

- (void)dealloc
{
    [self clearBlock];
}
@end
