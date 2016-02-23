//
//  weiBoBaseObject.h
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMFAuthShareResult.h"
#import "WeiboSDK.h"
#import "weiBoCommon.h"

@interface weiBoBaseObject : NSObject

/**
 *  验证数据的合法性
 *
 *  @return nil表示数据合法 否则返回错误对象
 */
- (GMFAuthShareResult *) verifyData;


/**
 *  获取分享微博消息对象
 *
 *  @return nil非法，否则返回分享微博消息对象
 */
- (WBBaseRequest *) WBMessage;
@end
