//
//  weiBoEngine.m
//  test1
//
//  Created by gengzhangjia on 15/8/3.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weiBoEngine.h"
#import "WeiboSDK.h"

@interface weiBoEngine ()<WBHttpRequestDelegate,WeiboSDKDelegate>
{
    /**
     *  微博appID
     */
    NSString  *_weiBoAppID;
    
    /**
     *  微博appToken
     */
    NSString *_weiBoToken;
    
    /**
     *  微博appSchem
     */
    NSString *_weiBoAppSchem;
}


///成功回调的block
@property(nonatomic, copy) GMShareAuthSuccess successCallBack;


///失败回调的block
@property(nonatomic, copy) GMShareAuthFail failCallBack;

@end

@implementation weiBoEngine

 +(instancetype)shareWeiBoEngine
{
    static weiBoEngine *wBEngine =nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        wBEngine =[[weiBoEngine alloc] init];
    });
    return wBEngine;
}

- (instancetype)init
{
    self =[super init];
    if(self)
    {
        [self readWeiBoAppID];
        [WeiboSDK registerApp:_weiBoAppID];
        //[WeiboSDK registerApp:SINA_APP_KEY];
        
        //[WeiboSDK enableDebugMode:YES];
        
    }
    
    return self;
}

- (NSString *) readWeiBoAppID
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray *array = [infoDic objectForKey:@"CFBundleURLTypes"];
    for (NSDictionary *dic in array) {
        NSString *name = [dic objectForKey:@"CFBundleURLName"];
        if (name && name.length > 0 && [name isEqualToString:@"com.weibo"]) {
            NSArray *QQArray = [dic objectForKey:@"CFBundleURLSchemes"];
            if (QQArray && QQArray.count > 0) {
                _weiBoAppSchem = [QQArray objectAtIndex:0];
                _weiBoAppID = [_weiBoAppSchem substringFromIndex:[@"wb" length]];
                break;
            }
        }
    }

    return _weiBoAppID;
}

- (BOOL) canHandleOpenURL:(NSURL *)url
{
    BOOL ret = [url.scheme isEqualToString:_weiBoAppSchem];
    return ret;
}

- (BOOL) handleOpenURL:(NSURL *) url
{
    BOOL ret = NO;
    
    ret = [WeiboSDK handleOpenURL:url delegate:self];
    return ret;
}

- (BOOL) isInstallWB
{
    return  [WeiboSDK isWeiboAppInstalled];
}


- (NSString*)sdkVersion
{
    return [WeiboSDK getSDKVersion];
}

///授权
-(void) authWithSuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result ;
    
    
    ///初始化必要的属性
    _operationType = GME_Operation_Auth;
    _successCallBack =successCallBack;
    _failCallBack = failCallBack;
    
   
    
    weiBoAuthObject *authObject =[weiBoAuthObject createWeiBoAuth];
    WBBaseRequest *req =[authObject WBMessage];
    if(![WeiboSDK sendRequest:req])
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
-(void) shareWithObject:(weiBoBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    
    GMFAuthShareResult *result = nil;
    ///初始化必要的属性
    _operationType = GME_Operation_Auth;
    _successCallBack =successCallBack;
    _failCallBack = failCallBack;
    WBBaseRequest *wbBaseRequest;
    
    
    if(![self isInstallWB])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Install_App failReason:GMM_Error_Reasion_Not_Install_App];
        goto failed;
    }
    
    result =[sendObject verifyData];
    if(result)
    {
        goto failed;
    }
    
    wbBaseRequest =[sendObject WBMessage];
    
    if (![WeiboSDK sendRequest:wbBaseRequest])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Unknown failReason:GMM_Error_Reasion_Unknown];
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



#pragma mark --WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    GMFAuthShareResult *result = nil;
   
    if([response isKindOfClass:[WBAuthorizeResponse class]])
    {
        if (response.statusCode ==WeiboSDKResponseStatusCodeSuccess)
        {
            WBAuthorizeResponse *authRespone = (WBAuthorizeResponse*)response;
            NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
           
            [mdic setObject:authRespone.userID forKey:@"userID"];
            [mdic setObject:authRespone.accessToken forKey:@"accessToken"];
            [mdic setObject:authRespone.expirationDate forKey:@"expirationDate"];
            [mdic setObject:authRespone.refreshToken forKey:@"refreshToken"];

            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:YES failCode:0 failReason:nil response:mdic];
            if(_successCallBack )
            {
                _successCallBack(result);
            }
        }
        else
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:response.statusCode    failReason:@"" ];
            if(_failCallBack )
            {
                _failCallBack(result);
            }
        }
    }
    else if([response isKindOfClass:[WBSendMessageToWeiboResponse class]])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:YES failCode:0 failReason:nil];
        if(_successCallBack )
        {
            _successCallBack(result);
        }
    }
   
    _successCallBack = nil;
    _failCallBack = nil;
    
    
}

@end
