//
//  FMRequest.m
//  FMNetwok
//
//  Created by chengdonghai on 16/5/11.
//  Copyright © 2016年 天翼文化. All rights reserved.
//

#import "FMRequest.h"
#import "FMRequestHandler.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation FMRequest


-(void) start {
    [self startWithSuccess:nil];
}

-(void)startWithSuccess:(FMRequestBlock)success
{
    [self startWithSuccess:success andFailure:nil];
}

-(void)startWithSuccess:(FMRequestBlock)success andFailure:(FMRequestBlock)failure
{
    [self startWithSuccess:success inRequest:nil andFailure:failure];
}

-(void)startWithSuccess:(FMRequestBlock)success inRequest:(FMRequestBlock)inRequest
{
    [self startWithSuccess:success inRequest:inRequest andFailure:nil];
}

-(void)startWithSuccess:(FMRequestBlock)success inRequest:(FMRequestBlock)inRequest andFailure:(FMRequestBlock)failure
{
    
    if (success) {
        self.sucess = success;
    }
    if (inRequest) {
        self.inRequest = inRequest;
    }
    if (failure) {
        self.failure = failure;
    }
    [[FMRequestHandler sharedInstance] addRequest:self];
    
    
}

-(void) cancel {
    [[FMRequestHandler sharedInstance] removeRequest:self];
    [self clearBlock];
}

-(void)clear {
    [self cancel];
}

-(void)clearBlock {
    self.sucess = nil;
    self.inRequest = nil;
    self.failure = nil;
}

#pragma mark -
#pragma mark - FMRequestDelegate
-(NSString *)requestUrl
{
    return @"";
}

-(NSDictionary *)requestHeaders
{
    return nil;
}

-(NSDictionary *)requestParameters
{
    return nil;
}

-(FMRequestMethod)requestMethod
{
    return FMRequestMethodGET;
}

-(FMRequesttype)requesttype
{
    return FMRequesttypeNormal;
}

-(FMConstructingBlock)requestConstructingBlock
{
    return nil;
}

-(AFHTTPRequestSerializer *)requestSerializer
{
    return [AFHTTPRequestSerializer serializer];
}

#pragma mark -
#pragma mark - FMResponseDelegate

-(FMError *)checkSuccessedResponseObj:(id)responseObj andResponseHeaders:(NSDictionary *)headers
{
    //For Example:
    //FMError *eor = [[FMError alloc]initWithErrorCode:@"code" errorMessage:@"msg"];
    //return eor;
    return nil;
}

-(FMError *)responseDidFailedWithError:(NSError *)error
{
    return nil;
}

-(AFHTTPResponseSerializer *)responseSerializer
{
    return [AFJSONResponseSerializer serializer];
}


- (void)dealloc
{
    [self clear];
}

@end
