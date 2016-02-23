//
//  weChatHtmlObject.h
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weChatBaseObject.h"

@interface weChatHtmlObject : weChatBaseObject
/**
 *  创建微信图片分享请求对象
 *
 *  @param xScene    分享的目的地
 *  @param title     图片标题
 *  @param desc      图片描述
 *  @param thumbData 缩略图
 *  @param imageUrl  图片网络地址
 *
 *  @return 返回微信图片请求对象
 */
+ (instancetype) createWeChatHtmlObjectWithScece:(WeChatScene) xScene
                                              title:(NSString *) title
                                               desc:(NSString *) desc
                                          thumbData:(NSData *) thumbData
                                           webPageUrl:(NSString *) webPageUrl;
@end
