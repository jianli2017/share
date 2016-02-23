//
//  weChatBaseObject.h
//  test1
//
//  Created by gengzhangjia on 15/7/29.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weChatCommon.h"
#import "WXApiObject.h"
#import "GMFAuthShareResult.h"

@interface weChatBaseObject : NSObject
/**
 *  初始化
 *
 *  @param scene 目的地
 *
 *  @return 返回响应实例对象
 */
- (instancetype) initWithScene:(WeChatScene) scene;

/**
 *  获得微信分享的目的地
 *
 *  @return 返回微信分享的目的地
 */
- (enum WXScene) scene;

/**
 *  验证数据合法性
 *
 *  @return nil表示合法，否则错误信息
 */
- (GMFAuthShareResult*) verifyData;

/**
 *  获得跳转微信响应的数据请求
 *
 *  @return 微信请求对象
 */
- (BaseReq *) wxMessage;
@end
