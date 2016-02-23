//
//  weChatEngine.m
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weChatEngine.h"
#import "WXApi.h"

#import "weChatAuthObject.h"
#import "GMFAuthShareResult.h"
#import "weChatBaseObject.h"

@interface weChatEngine () <WXApiDelegate>
{
    /**
     *  微信AppID
     */
    NSString *_weChatAppID;
}


///成功回调的block
@property(nonatomic, copy) GMShareAuthSuccess successCallBack;


///失败回调的block
@property(nonatomic, copy) GMShareAuthFail failCallBack;


@end

@implementation weChatEngine

+(instancetype)shareWeChatEngine
{
    static weChatEngine *weChatEngine =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weChatEngine =[[[self class] alloc] init];
    });
    return weChatEngine;
}

- (instancetype) init
{
    if(self = [super init])
    {
        _weChatAppID = [self readWeChatAppID];
        [WXApi registerApp:_weChatAppID];
    }
    return self;
}

- (BOOL) canHandleOpenURL:(NSURL *) URL
{
    BOOL ret = [URL.scheme isEqualToString:_weChatAppID];
    return ret;
}

- (BOOL) handleOpenURL:(NSURL *) URL
{
    BOOL ret =NO;
    if([self canHandleOpenURL:URL])
    {
        ret =[WXApi handleOpenURL:URL delegate:self];
    }
    return  ret;
}

- (NSString *) getInstallUrl
{
    return [WXApi getWXAppInstallUrl];
}


- (NSString*)sdkVersion
{
    return [WXApi getApiVersion];
}


- (BOOL) openApp
{
    return [WXApi openWXApp];
}

- (BOOL) isInstallWX
{
    return [WXApi isWXAppInstalled];
}

- (BOOL) isAppSupportAPI
{
    return [WXApi isWXAppSupportApi];
}

- (NSString *) readWeChatAppID
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray *array = [infoDic objectForKey:@"CFBundleURLTypes"];
    
    for (NSDictionary *dic in array) {
        NSString *name = [dic objectForKey:@"CFBundleURLName"];
        if (name && name.length > 0 && [name isEqualToString:@"weixin"]) {
            NSArray *weixinArray = [dic objectForKey:@"CFBundleURLSchemes"];
            if (weixinArray && weixinArray.count > 0) {
                _weChatAppID = [weixinArray objectAtIndex:0];
                break;
            }
        }
    }
    return _weChatAppID;
}

///授权
-(void) authWithSuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result ;
    
    
    ///初始化必要的属性
    _operationType = GME_Operation_Share;
    _successCallBack =successCallBack;
    _failCallBack = failCallBack;
    
    
    weChatAuthObject *authObject =[weChatAuthObject createWeChatAuthObject];
    BaseReq *req =[authObject wxMessage];
    if(![WXApi sendReq:req])
    {
        result =[[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
        goto failed;
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


///分享
-(void) shareWithObject:(weChatBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result ;
    
    
    ///初始化必要的属性
    _operationType = GME_Operation_Share;
    _successCallBack =successCallBack;
    _failCallBack = failCallBack;
    BaseReq *req;
    
    
    if(!sendObject ||![sendObject isKindOfClass:[weChatBaseObject class]])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
        goto failed;
    }
    
    if(![self isInstallWX])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Install_App failReason:GMM_Error_Reasion_Not_Install_App];
        goto failed;
    }
    
    if(![self isAppSupportAPI])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_API_Too_Low failReason:GMM_Error_Reasion_API_Too_Low];
        goto failed;
    }
    
    result =[sendObject verifyData];
    if(result)
    {
        goto failed;
    }
    
    req =[sendObject wxMessage];
    if(!req)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
        goto failed;
    }
    if(![WXApi sendReq:req])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
        goto failed;
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

///支付
-(void) payWithObject:(weChatBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result ;
    
    
    ///初始化必要的属性
    _operationType = GME_Operation_Pay;
    _successCallBack =successCallBack;
    _failCallBack = failCallBack;
    BaseReq *req;
    
    
    if(!sendObject ||![sendObject isKindOfClass:[weChatBaseObject class]])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Param_Error failReason:GMM_Error_Reasion_Param_Error];
        goto failed;
    }
    
    if(![self isInstallWX])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Install_App failReason:GMM_Error_Reasion_Not_Install_App];
        goto failed;
    }
    
    if(![self isAppSupportAPI])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_API_Too_Low failReason:GMM_Error_Reasion_API_Too_Low];
        goto failed;
    }
    
    result =[sendObject verifyData];
    if(result)
    {
        goto failed;
    }
    
    req =[sendObject wxMessage];
    if(!req)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
        goto failed;
    }
    if(![WXApi sendReq:req])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
        goto failed;
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



#pragma mark WXApiDelegate
-(void) onResp:(BaseResp*)resp
{
    GMFAuthShareResult *result =nil;
    if([resp isKindOfClass:[SendAuthResp class]])
    {
        ///成功
        if (resp.errCode == 0)
        {
            SendAuthResp *authResp =(SendAuthResp*)resp;
            NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
            [mdic setObject:authResp.code forKey:@"code"];
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:YES failCode:GME_Error_Code_Success failReason:nil response:mdic];
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
    else if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (resp.errCode == 0)
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
    
    else if([resp isKindOfClass:[PayResp class]])
    {
        if (resp.errCode == 0)
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
    
    if (WXErrCodeCommon == result.intFailCode)
    {
        result.strFailReason = @"普通错误类型";
    }
    if (WXErrCodeUserCancel == result.intFailCode)
    {
        result.strFailReason = @"用户取消";
    }
    if (WXErrCodeSentFail == result.intFailCode)
    {
        result.strFailReason = @"发送失败";
    }
    if (WXErrCodeAuthDeny == result.intFailCode)
    {
        result.strFailReason = @"授权失败";
    }
    if (WXErrCodeUnsupport == result.intFailCode)
    {
        result.strFailReason = @"微信不支持";
    }

    
    if (_failCallBack)
    {
        _failCallBack(result);
    }
    _failCallBack = nil;
    _successCallBack = nil;
    return;
    
    
}
@end
