//
//  weChatEngine.h
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weChatBaseObject.h"
#import "weChatCommon.h"
#import "GMAuthShareCommon.h"

@interface weChatEngine : NSObject

/**
 *  构建微信分享引擎单例
 *
 *  @return 返回微信引擎实例
 */
+ (instancetype) shareWeChatEngine;


///操作类型(分享、授权、 支付)
@property(nonatomic, assign) GME_Operation_Type operationType;


/**
 *  处理微信通过URL启动App时传递的数据,需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 *
 *  @param URL 微信启动第三方应用时传递过来的URL
 *
 *  @return 成功返回YES，失败返回NO
 */
- (BOOL) handleOpenURL:(NSURL *) URL;

- (BOOL) canHandleOpenURL:(NSURL *) URL;

/**
 *  获取微信安装地址
 *
 *  @return 返回微信安装地址
 */
- (NSString *) getInstallUrl;


/**
 *  获取当前微信SDK版本
 *
 *  @return 返回当前微信SDK版本
 */
- (NSString*)sdkVersion;

/**
 *  打开微信
 *
 *  @return 成功返回YES，失败返回NO
 */
- (BOOL) openApp;

/**
 *  是否安装微信
 *
 *  @return YES安装了 NO没有安装
 */
- (BOOL) isInstallWX;

/**
 *  是否支持当前版本的微信API
 *
 *  @return YES支持 NO不知
 */
- (BOOL) isAppSupportAPI;

/**
 *  读取微信AppID
 *
 *  @return 返回微信AppID
 */
- (NSString *) readWeChatAppID;



///分享
-(void) shareWithObject:(weChatBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack;


///授权
-(void) authWithSuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack;

///支付
-(void) payWithObject:(weChatBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack;

@end
