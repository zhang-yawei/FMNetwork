//
//  FMRequestDefine.h
//  FMNetwok
//
//  Created by chengdonghai on 16/5/11.
//  Copyright © 2016年 天翼文化. All rights reserved.
//

#ifndef FMRequestDefine_h
#define FMRequestDefine_h


#endif /* FMRequestDefine_h */
/**
 HTTP request Method
 */
typedef enum : NSUInteger {
    FMRequestMethodGET = 0,
    FMRequestMethodPOST,
    FMRequestMethodHEAD,
    FMRequestMethodPUT,
    FMRequestMethodBATCH,
    FMRequestMethodDELETE
} FMRequestMethod;

/**
 HTTP request type
 */
typedef enum : NSUInteger {
    FMRequesttypeNormal = 0,
    FMRequesttypeUpload
} FMRequesttype;
