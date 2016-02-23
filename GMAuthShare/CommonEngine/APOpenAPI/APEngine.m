//
//  APEngine.m
//  GMAuthShare
//
//  Created by LiJian on 16/2/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "APEngine.h"
#import "APOpenAPI.h"
#import "GMFAuthShareResult.h"

@interface APEngine ()
<
APOpenAPIDelegate
>

///appID
@property(nonatomic, copy) NSString * strAPAppId;

///成功回调的block
@property(nonatomic, copy) GMShareAuthSuccess successCallBack;


///失败回调的block
@property(nonatomic, copy) GMShareAuthFail failCallBack;


@end

////支付宝朋友 分享引擎
@implementation APEngine


/**
 *  创建单例对象
 *
 *  @return 返回单例对象
 */
+ (APEngine *) shareAPSDKEngine
{
    static APEngine *APEngineInstance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        APEngineInstance =[[APEngine alloc] init];
    });
    
    return APEngineInstance;
}


-(instancetype)init
{
    self =[super init];
    if(self)
    {
        _strAPAppId =[self readApAppID];
        [APOpenAPI registerApp:_strAPAppId];
    }
    
    return self;
}

- (NSString*) readApAppID
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray *array = [infoDic objectForKey:@"CFBundleURLTypes"];
    NSString *strAPAppID = nil;
    for (NSDictionary *dic in array) {
        NSString *name = [dic objectForKey:@"CFBundleURLName"];
        if (name && name.length > 0 && [name isEqualToString:@"alipayShare"]) {
            NSArray *aryAPInfo = [dic objectForKey:@"CFBundleURLSchemes"];
            if (aryAPInfo && aryAPInfo.count > 0) {
                strAPAppID = [aryAPInfo objectAtIndex:0];
                strAPAppID = [strAPAppID substringFromIndex:[@"ap" length]];
                break;
            }
        }
    }
    return strAPAppID;
}



/**
 *  判断URL是否为 支付宝好友 跳转相关
 *
 *  @param URL 跳转回的相关URL
 *
 *  @return YES 支付宝好友相关 否则其它相关
 */
- (BOOL) canHandleOpenUrl:(NSURL *) URL
{
    ///ap2016020501138777://platformapi/shareService?action=sendResp
    if ([URL.absoluteString hasPrefix:[NSString stringWithFormat:@"ap%@",[self readApAppID]]] )
    {
        return YES;
    }
    else
    {
        return NO;
    }

}


/**
 *  处理 支付宝好友 跳转回来的回调处理
 *
 *  @param URL 跳转回的相关URL
 */
- (BOOL) handleOpenUrl:(NSURL *) URL
{
    return [APOpenAPI handleOpenURL:URL delegate:self];
}

/**
 *  是否安装 支付宝好友
 *
 *  @return YES安装 否则未安装
 */
- (BOOL) isAPInstalled
{
    return [APOpenAPI isAPAppInstalled];
}

/**
 *  当前 支付宝好友 是否支持相应的API
 *
 *  @return YES支持 否则不支持
 */
- (BOOL) isAPAppSupportAPI
{
    return  [APOpenAPI isAPAppSupportOpenApi];
}


- (NSString*)sdkVersion
{
    return  [APOpenAPI getApiVersion];
}


///分享
-(void) shareWithObject:(APBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result =nil;
    
    ///初始化必要的属性
    _operationType = GME_Operation_Share;
    _successCallBack =successCallBack;
    _failCallBack = failCallBack;
    
    if(![self isAPInstalled])
    {
        result =[[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Install_App failReason:GMM_Error_Reasion_Not_Install_App];
        goto failed;
    }
    else if(![self isAPAppSupportAPI])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_API_Too_Low failReason:GMM_Error_Reasion_API_Too_Low];
        goto failed;
    }
    
    ///根据传入的内容对象，构造 对应的分享对象
    result =[sendObject verifyData];
    if(result)
    {
        goto failed;
    }
    

    {
        APBaseReq *req =[sendObject messageObj];
        if(req)
        {
            if (![APOpenAPI sendReq:req])
            {
                result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
                goto failed;
            }
        }
        else
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
            goto failed;
        }
    }
    return;
    
failed:
    if (_failCallBack)
    {
        _failCallBack(result);
    }
    _failCallBack = nil;
    _successCallBack = nil;
    return;

}

/*! @brief 发送一个sendReq后，收到支付宝的回应
 *
 * 收到一个来自支付宝的处理结果。调用一次sendReq后会收到onResp。
 * @param resp具体的回应内容
 */
-(void) onResp:(APBaseResp*)resp
{
    GMFAuthShareResult *result = nil;
    ///成功
    if ([resp isKindOfClass:[APSendMessageToAPResp class]])
    {
        if (resp.errCode == APSuccess)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:YES failCode:GME_Error_Code_Success failReason:nil response:nil];
            if (_successCallBack)
            {
                _successCallBack(result);
            }
            
        }
        else ///失败
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:resp.errCode failReason:resp.errStr];
            goto failed;
        }
    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
        goto failed;
    }
    
    _successCallBack = nil;
    _failCallBack = nil;
    return;

failed:
    if (_failCallBack)
    {
        _failCallBack(result);
    }
    _failCallBack = nil;
    _successCallBack = nil;
    return;
    
}


@end
