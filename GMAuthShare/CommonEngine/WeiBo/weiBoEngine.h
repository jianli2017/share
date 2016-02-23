//
//  weiBoEngine.h
//  test1
//
//  Created by gengzhangjia on 15/8/3.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weiBoAuthObject.h"
#import "weiBoImageObject.h"
#import "weiBoLogOutObject.h"
#import "GMFAuthShareResult.h"

@interface weiBoEngine : NSObject


///操作类型(分享、授权、 支付)
@property(nonatomic, assign) GME_Operation_Type operationType;


/**
 *  构建微博分享引擎单例
 *
 *  @return 返回微博分享引擎单例
 */
+ (instancetype) shareWeiBoEngine;

/**
 *  读取微博appID
 *
 *  @return 返回微博appID
 */
- (NSString *) readWeiBoAppID;

/**
 *  判断是否安装了微博
 *
 *  @return YES安装 NO没有安装
 */
- (BOOL) isInstallWB;

///**
// *  发送微博相关请求
// *
// *  @param baseBehavior  微博相关的请求
// *  @param callBackBlock 微博请求相关的回调执行体
// */
//- (void) sendReqWithObject:(weiBoBaseObject *) baseObject
//             callBackBlock:(weiBoCallBackBlock) callBackBlock;

- (BOOL) canHandleOpenURL:(NSURL *)url;
- (BOOL) handleOpenURL:(NSURL *) url;


- (NSString*)sdkVersion;


///分享
-(void) shareWithObject:(weiBoBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack;


///授权
-(void) authWithSuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack;


@end
