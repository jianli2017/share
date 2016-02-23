//
//  APEngine.h
//  GMAuthShare
//
//  Created by LiJian on 16/2/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "GMAuthShareCommon.h"
#import "APBaseObject.h"


////支付宝好友 分享引擎
@interface APEngine : NSObject


///操作类型(分享、授权、 支付)
@property(nonatomic, assign) GME_Operation_Type operationType;

/**
 *  创建单例对象
 *
 *  @return 返回单例对象
 */
+ (APEngine *) shareAPSDKEngine;

/**
 *  判断URL是否为 支付宝好友 跳转相关
 *
 *  @param URL 跳转回的相关URL
 *
 *  @return YES 支付宝好友相关 否则其它相关
 */
- (BOOL) canHandleOpenUrl:(NSURL *) URL;


/**
 *  处理 支付宝好友 跳转回来的回调处理
 *
 *  @param URL 跳转回的相关URL
 */
- (BOOL) handleOpenUrl:(NSURL *) URL;

/**
 *  是否安装 支付宝好友
 *
 *  @return YES安装 否则未安装
 */
- (BOOL) isAPInstalled;

/**
 *  当前 支付宝好友 是否支持相应的API
 *
 *  @return YES支持 否则不支持
 */
- (BOOL) isAPAppSupportAPI;


- (NSString*)sdkVersion;

///分享
-(void) shareWithObject:(APBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack;


@end
