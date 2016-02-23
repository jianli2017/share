//
//  weChatPayObject.h
//  GMAuthShare
//
//  Created by LiJian on 16/2/1.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "weChatBaseObject.h"

@interface weChatPayObject : weChatBaseObject


/**
 *  创建微信支付对象
 *
 *  @param xScene    分享的目的地
 *  @param  strOpenID
 *
 *  @param  strPartnerId  商家向财付通申请的商家id
 *
 *  @param  strPrepayId  预支付订单
 *
 *  @param  strNonceStr
 *
 *  @param  strTimeStamp 时间戳，防重发
 *
 *  @param  strPackage  商家根据财付通文档填写的数据和签名
 *
 *  @param  strSign  商家根据微信开放平台文档对数据做的签名
 *
 *  @return 返回微信支付对象
 */

+(instancetype) createWeChatTextObjectWithScene:(WeChatScene)scene
                                        openID:(NSString *)strOpenID
                                      partnerId:(NSString *)strPartnerId
                                       prepayId:(NSString *)strPrepayId
                                       nonceStr:(NSString *)strNonceStr

                                      timeStamp:(NSString *)strTimeStamp
                                        package:(NSString *)strPackage
                                        sign:(NSString *)strSign;


@end
