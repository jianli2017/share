//
//  weChatPayObject.m
//  GMAuthShare
//
//  Created by LiJian on 16/2/1.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "weChatPayObject.h"

@interface weChatPayObject ()



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

@implementation weChatPayObject

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
                                           sign:(NSString *)strSign
{
    weChatPayObject *payObject =[[weChatPayObject alloc] initWithScene:scene];
    payObject.strOpenID =strOpenID;
    payObject.strPartnerId =strPartnerId;
    payObject.strPrepayId =strPrepayId;
    payObject.strNonceStr =strNonceStr;
    payObject.strTimeStamp =strTimeStamp;
    payObject.strPackage =strPackage;
    payObject.strSign =strSign;
    
    return payObject;
}

- (GMFAuthShareResult *)verifyContect
{
    GMFAuthShareResult *result =nil;
    if(!_strOpenID)
    {
        result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
      
    }
    
    if(!_strPartnerId)
    {
        result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
        
    }
    
    if(!_strPrepayId)
    {
        result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
        
    }
    
    if(!_strTimeStamp)
    {
        result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
        
    }
    
    if(!_strPackage)
    {
        result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
        
    }
    
    if(!_strSign)
    {
        result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
        
    }
    
    if(!_strNonceStr)
    {
        result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
        
    }
    return result;
}

-(GMFAuthShareResult *)verifyData
{
    GMFAuthShareResult *result =nil;
    result =[self verifyContect];
    return  result;
}

- (BaseReq *)wxMessage
{
    PayReq* req = [[PayReq alloc] init];
    req.openID      = _strOpenID;
    req.partnerId   = _strPartnerId;
    req.prepayId    = _strPrepayId;
    req.nonceStr    = _strNonceStr;
    req.timeStamp   = _strTimeStamp.intValue;
    req.package     = _strPackage;
    req.sign        = _strSign;
    
    return req;
}




@end
