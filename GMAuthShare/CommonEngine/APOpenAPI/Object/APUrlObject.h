//
//  APUrlObject.h
//  GMAuthShare
//
//  Created by LiJian on 16/2/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "APBaseObject.h"

@interface APUrlObject : APBaseObject


/**
 *  构建 支付宝好友 webpage分享对象
 *
 *
 *  @param strWepageUrl           webpage url
 *  @param strTitle              分享的标题
 *  @param strDesc                 分享的描述
 *  @param dataOfThumb              分享的缩略图数据
 *  @param strThumbImgUrl           分享的缩略图的url
 *  @return 返回 webpage 分享对象
 */
+ (instancetype) createApWebObjectWithWepageUrl:(NSString *) strWepageUrl
                                title:(NSString *) strTitle
                                 desc:(NSString *) strDesc
                         thumbImgData:(NSData *)  dataOfThumb
                                    thumbImgUrl:(NSString *)strThumbImgUrl;

@end

