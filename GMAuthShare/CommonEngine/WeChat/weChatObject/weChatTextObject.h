//
//  weChatTextObject.h
//  test1
//
//  Created by gengzhangjia on 15/7/29.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weChatBaseObject.h"

@interface weChatTextObject : weChatBaseObject
/**
 *  创建微信文字分享请求对象
 *
 *  @param xScene    分享的目的地
 *  @param content     文字内容
 *
 *  @return 返回微信图片请求对象
 */
+(instancetype) createWeChatTextObjectWithScene:(WeChatScene)scene content:(NSString *)content;

@end
