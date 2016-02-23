//
//  GMMPayModel.h
//  GMAuthShare
//
//  Created by LiJian on 16/2/1.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMMPayModel : NSObject


@end


@interface GMMWeChatPayModel : GMMPayModel


@property (nonatomic, copy) NSString *strOpenID;

/** 商家向财付通申请的商家id */
@property (nonatomic, copy) NSString *strPartnerId;
/** 预支付订单 */
@property (nonatomic, copy) NSString *strPrepayId;


@property (nonatomic, copy) NSString *strNonceStr;

/** 时间戳，防重发 */
@property (nonatomic, copy) NSString *strTimeStamp;

/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, copy) NSString *strPackage;

/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, copy) NSString *strSign;



@end

