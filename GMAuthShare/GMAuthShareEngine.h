//
//  GMAuthShare.h
//  GMAuthShare
//
//  Created by LiJian on 16/1/26.
//  Copyright © 2016年 LJ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GMFAuthShareResult.h"
#import "GMAuthShareCommon.h"
#import "GMMShareModel.h"
#import "GMMPayModel.h"

///国美app 分享的引擎，可能包含国美的处理流程，根据不同的参数 ，跳转到不同的处理流程

@interface GMAuthShareEngine : NSObject

///分享授权的 第三方app类型
@property(nonatomic, assign) GME_Third_App_Type shareAuthType;


///获取 分享授权  引擎的实例对象
+(instancetype)authShareEngine:(GME_Third_App_Type) shareAuthType;


/**
 *  处理第三方app通过URL启动本App时传递的数据,需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 *
 *  @param URL 第三方app 启动本应用时传递过来的URL
 *
 *  @return 成功返回YES，失败返回NO
 */

- (BOOL) canHandleOpenURL:(NSURL *) URL;


- (BOOL) handleOpenURL:(NSURL *) URL;


/**
 *  是否安装第三方App
 *
 *  @return YES安装 否则未安装
 */
- (BOOL) isInstalled;


///获取skd 的版本
- (NSString*)sdkVersion;

/**
 *  授权(不带授权参数 )
 *
 *  @param successCallBack 授权成功的回调
 *
 *  @param failCallBack 授权失败的回调
 *
 *  @return
 */

-(void) authWithSuccessCallBack:(GMShareAuthSuccess) successCallBack
                   failCallBack:(GMShareAuthFail)failCallBack;


/**
 *  分享
 *
 *  @param contenOfShare 分享的内容
 *
 *  @param successCallBack 分享成功的回调
 *
 *  @param failCallBack 分享失败的回调
 *
 *  @return  YES 执行成功
 */
-(void) shareWithContent:(GMMShareModel *) contenOfShare
               objetType:(GME_Share_Object_Type)objectType
                   scene:(GME_Share_Scene)scene
                        SuccessCallBack:(GMShareAuthSuccess)
successCallBack failCallBack:(GMShareAuthFail)failCallBack;



/**
 *  支付
 *
 *  @param mdicPayContent 支付的参数
 *
 *  @param successCallBack 支付成功的回调
 *
 *  @param failCallBack 支付失败的回调
 *
 *  @return
 */
-(void) payWithContent:(GMMPayModel *) contentOfPay
       SuccessCallBack:(GMShareAuthSuccess) successCallBack
          failCallBack:(GMShareAuthFail)failCallBack;


@end
