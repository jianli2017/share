//
//  QQEngine.m
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "QQEngine.h"
#import "GMFAuthShareResult.h"

@interface QQEngine ()
<QQApiInterfaceDelegate,
TencentLoginDelegate,
TencentSessionDelegate
>

@property (nonatomic, strong) NSString *QQAppId;

@property (nonatomic, strong) TencentOAuth *tencentOAuth;


///发送的对象
@property (nonatomic, strong)QQBaseObject * sendObject;


///成功回调的block
@property(nonatomic, copy) GMShareAuthSuccess successCallBack;


///失败回调的block
@property(nonatomic, copy) GMShareAuthFail failCallBack;



@end

@implementation QQEngine
+ (QQEngine *) shareQQSDKEngine
{
    static QQEngine *qqEngine =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        qqEngine =[[QQEngine alloc] init];
    });
    
    return qqEngine;
}

-(instancetype)init
{
    self =[super init];
    if(self)
    {
        _QQAppId =[self readQQAppID];
        _tencentOAuth =[[TencentOAuth alloc] initWithAppId:_QQAppId andDelegate:self];
    }
    
    return self;
}

- (NSString*) readQQAppID
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray *array = [infoDic objectForKey:@"CFBundleURLTypes"];
    NSString *QQAppID = nil;
    for (NSDictionary *dic in array) {
        NSString *name = [dic objectForKey:@"CFBundleURLName"];
        if (name && name.length > 0 && [name isEqualToString:@"tencent"]) {
            NSArray *QQArray = [dic objectForKey:@"CFBundleURLSchemes"];
            if (QQArray && QQArray.count > 0) {
                QQAppID = [QQArray objectAtIndex:0];
                QQAppID = [QQAppID substringFromIndex:[@"tencent" length]];
                break;
            }
        }
    }
    return QQAppID;
}

- (NSString*) readQQApiInterfaceAppID
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray *array = [infoDic objectForKey:@"CFBundleURLTypes"];
    NSString *strApiInterfaceAppID = nil;
    for (NSDictionary *dic in array) {
        NSString *name = [dic objectForKey:@"CFBundleURLName"];
        if (name && name.length > 0 && [name isEqualToString:@"mqqapi"]) {
            NSArray *QQArray = [dic objectForKey:@"CFBundleURLSchemes"];
            if (QQArray && QQArray.count > 0) {
                strApiInterfaceAppID = [QQArray objectAtIndex:0];
                break;
            }
        }
    }
    return strApiInterfaceAppID;
}


- (BOOL) canHandleOpenUrl:(NSURL *) URL
{
    ///tencent100271288://qzapp/mqzone/0?generalpastboard=1
    ///QQ05FA04B8://response_from_qq?source=qq&source_scheme=mqqapi&error=0&version=1
    BOOL isCanHandleUrl = NO;
    isCanHandleUrl = [TencentOAuth CanHandleOpenURL:URL];
    if (isCanHandleUrl)
    {
        return isCanHandleUrl;
    }
    else
    {
        if ([URL.absoluteString hasPrefix:[self readQQAppID]] )
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

- (BOOL) handleOpenUrl:(NSURL *) URL
{
    BOOL isSuccess = NO;
    isSuccess =[TencentOAuth HandleOpenURL:URL];
    if (isSuccess)
    {
        return YES;
    }
    else
    {
        if ([URL.absoluteString hasPrefix:[self readQQAppID]] )
        {
            return [QQApiInterface handleOpenURL:URL delegate:self];
        }
        else
        {
            return NO;
        }

    }
}

- (BOOL) isQQInstalled
{
    return [QQApiInterface isQQInstalled];
}

- (BOOL) isQQAppSupportAPI
{
    return [QQApiInterface isQQSupportApi];
}


- (NSString*)sdkVersion
{
    return [TencentOAuth sdkVersion];
}


///授权
-(void) authWithSuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    ///初始化必要的属性
    _operationType = GME_Operation_Auth;
    _successCallBack = successCallBack;
    _failCallBack = failCallBack;
    
    ///发送认证请求对象
    GMFAuthShareResult *result = nil;
    
    /*kOPEN_PERMISSION_GET_INFO,kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO*/
    NSArray *permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO,kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,kOPEN_PERMISSION_ADD_SHARE, nil];
    
    
    if (NO == [_tencentOAuth authorize:permissions inSafari:NO])
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Auth_Fail failReason:GMM_Error_Reasion_Auth_Fail];
        if(failCallBack)
        {
            failCallBack(result);
        }
        _failCallBack = nil;
        _successCallBack = nil;
    }
    
}


///分享
-(void) shareWithObject:(QQBaseObject *) sendObject SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result =nil;
    
    ///初始化必要的属性
    _operationType = GME_Operation_Share;
    _successCallBack =successCallBack;
    _failCallBack = failCallBack;
    
    if(![self isQQInstalled])
    {
        result =[[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Install_App failReason:GMM_Error_Reasion_Not_Install_App];
        goto failed;
    }
    else if(![self isQQAppSupportAPI])
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
    
    

    /*///  这段代码可能导致二次登录
    if (NO ==  _isLogined)
    {
        _sendObject = sendObject;
        NSArray *permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO,kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,kOPEN_PERMISSION_ADD_SHARE, nil];
        if (NO == [_tencentOAuth authorize:permissions inSafari:NO])
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Auth_Fail failReason:GMM_Error_Reasion_Auth_Fail];
            if(failCallBack)
            {
                failCallBack(result);
                _failCallBack = nil;
                _successCallBack = nil;
            }
        }
    }
    else
    */
    ///发送请求
    {
        QQBaseReq *req =[sendObject messageObj];
        if(req)
        {
            QQApiSendResultCode resultCode ;
            if (sendObject.scene == QQSceneZone) {
                resultCode = [QQApiInterface SendReqToQZone:req];
            }
            else
            {
                resultCode = [QQApiInterface sendReq:req];
            }
            [self handleSendResult:resultCode];
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


#pragma mark --TencentSessionDelegate
- (void)tencentDidLogin
{
    GMFAuthShareResult *result ;
    if (0 != [_tencentOAuth.accessToken length])
    {
        
        //登陆成功，记录登录用户的OpenID、Token以及过期时间
        if (GME_Operation_Share == _operationType)
        {
            QQBaseReq *req =[_sendObject messageObj];
            if(req)
            {
                QQApiSendResultCode resultCode = [QQApiInterface sendReq:req];
                [self handleSendResult:resultCode];
            }
        }
        else if(GME_Operation_Auth == _operationType)  ///如果是登录 ，登录成功后，获取用户信息
        {
            if(![_tencentOAuth getUserInfo])
            {
                result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Auth_Fail failReason:GMM_Error_Reasion_Auth_Fail];
                goto  failed;
            }
        }
        else
        {
            goto failed;
        }
        
    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Auth_Fail failReason:GMM_Error_Reasion_Auth_Fail];
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

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    GMFAuthShareResult *result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Auth_Fail failReason:GMM_Error_Reasion_Auth_Fail];
    
    
    if (_failCallBack)
    {
        _failCallBack(result);
        
    }
    _failCallBack = nil;
    _successCallBack = nil;
}

- (void)tencentDidNotNetWork
{
    GMFAuthShareResult *result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Auth_Fail failReason:GMM_Error_Reasion_Auth_Fail];
    
    
    if (_failCallBack)
    {
        _failCallBack(result);
    }
    _failCallBack = nil;
    _successCallBack = nil;
}

- (void)tencentDidLogout
{
    /*if(_callBackBlock)
    {
        _callBackBlock(nil);
        _callBackBlock = nil;
    }*/
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    if (GME_Operation_Auth == _operationType)
    {
        if (_successCallBack)
        {
            NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:response.jsonResponse];
            [mdic setObject:_tencentOAuth.accessToken forKey:@"accessToken"];
            [mdic setObject:_tencentOAuth.expirationDate forKey:@"expirationDate"];
            [mdic setObject:_tencentOAuth.openId forKey:@"openId"];
            GMFAuthShareResult *result = [[GMFAuthShareResult alloc ] initWithIsSuccessed:YES failCode:GME_Error_Code_Success failReason:nil response:mdic];
            _successCallBack(result);
        }
    }
    
    _successCallBack = nil;
    _failCallBack = nil;
}

#pragma mark - QQApiInterfaceDelegate
- (void)onResp:(QQBaseResp *)resp
{
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            if (_successCallBack)
            {
                GMFAuthShareResult *result;
                NSString *strResult = resp.result ;
                if (strResult!= nil && strResult.integerValue == 0)
                {
                    result = [[GMFAuthShareResult alloc] initWithIsSuccessed:YES failCode:0 failReason:nil];
                    if (_successCallBack )
                    {
                        _successCallBack(result);
                    }
                }
                else
                {
                    NSString *strFailedReason  = @"分享失败";
                    if (-4 == resp.result.integerValue )
                    {
                        strFailedReason = @"用户取消";
                    }
                    result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:resp.result.integerValue failReason:strFailedReason];
                    if (_failCallBack )
                    {
                        _failCallBack(result);
                    }
                }
            }
            _successCallBack = nil;
            _failCallBack = nil;

        }
        default:
        {
            break;
        }
    }
}


- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    GMFAuthShareResult *result ;
    NSString *strError ;
    if(EQQAPISENDSUCESS != sendResult)
    {
        switch (sendResult)
        {
            case EQQAPIAPPNOTREGISTED:
            {
                strError = GMM_Error_Reasion_APP_Not_Register;
                break;
            }
            case EQQAPIMESSAGECONTENTINVALID:
            case EQQAPIMESSAGECONTENTNULL:
            case EQQAPIMESSAGETYPEINVALID:
            {
                strError = GMM_Error_Reasion_Param_Error;
                break;
            }
            case EQQAPIQQNOTINSTALLED:
            {
                strError = GMM_Error_Reasion_Not_Install_App;
                break;
            }
            case EQQAPIQQNOTSUPPORTAPI:
            {
                strError = GMM_Error_Reasion_API_Too_Low;
                break;
            }
            case EQQAPISENDFAILD:
            {
                strError = GMM_Error_Reasion_Fail_Send;
                break;
            }
            default:
            {
                strError = GMM_Error_Reasion_other;
                break;
            }
        }
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:sendResult failReason:strError];
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


@end
