//
//  QQEngine.h
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QQCommon.h"
#include "GMAuthShareCommon.h"
#import "QQBaseObject.h"
#import "QQAuthObject.h"
#import "QQLogOutObject.h"
#import "QQURLObject.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@interface QQEngine : NSObject

///操作类型(分享、授权、 支付)
@property(nonatomic, assign) GME_Operation_Type operationType;

/**
 *  创建单例对象
 *
 *  @return 返回单例对象
 */
+ (QQEngine *) shareQQSDKEngine;

/**
 *  判断URL是否为QQ跳转相关
 *
 *  @param URL 跳转回的相关URL
 *
 *  @return YES QQ相关 否则其它相关
 */
- (BOOL) canHandleOpenUrl:(NSURL *) URL;


/**
 *  处理QQ跳转回来的回调处理
 *
 *  @param URL 跳转回的相关URL
 */
- (BOOL) handleOpenUrl:(NSURL *) URL;

/**
 *  是否安装QQ
 *
 *  @return YES安装 否则未安装
 */
- (BOOL) isQQInstalled;

/**
 *  当前QQ是否支持相应的API
 *
 *  @return YES支持 否则不支持
 */
- (BOOL) isQQAppSupportAPI;


- (NSString*)sdkVersion;

///分享
-(void) shareWithObject:(QQBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack;


///授权
-(void) authWithSuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack;


@end
