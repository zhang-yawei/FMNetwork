//
//  FMUploadUserProfileRequest.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/28.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMUploadUserProfileRequest.h"

@implementation FMUploadUserProfileRequest

- (instancetype)initWithImage:(UIImage *)profileimage
{
    self = [super init];
    if (self) {
        self.profileimage = profileimage;
        self.action = @"faceUpload";
    }
    return self;
}
-(FMRequesttype)requesttype
{
    return FMRequesttypeUpload;
}

-(FMRequestMethod)requestMethod
{
    return FMRequestMethodPOST;
}

-(FMConstructingBlock)requestConstructingBlock
{
    void (^constructingBlock)(id<AFMultipartFormData> ) = ^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:UIImagePNGRepresentation(self.profileimage)
//                                    name:@"file"
//                                fileName:@"tmpHeadImage.png"
//                                mimetype:@"image/png"];
    };
    return constructingBlock;
}
    
-(id)responseDataAfterConverted:(id)responseObj
{
    if ([responseObj isKindOfClass:[NSArray class]]) {
        NSArray *respArr = (NSArray *)responseObj;
        if (respArr.count > 0) {
             return respArr[0];
        }
       
    } else if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return responseObj[@"url"];
    }
    return nil;
}
@end
