//
//  GMAuthShare.m
//  GMAuthShare
//
//  Created by LiJian on 16/1/26.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "GMAuthShareEngine.h"

///qq 相关的头文件
#import "QQEngine.h"
#import "QQTextObject.h"
#import "QQImageObject.h"

///微信相关的头文件
#import "weChatEngine.h"
#import "weChatHtmlObject.h"
#import "weChatTextObject.h"
#import "weChatImageObject.h"
#import "weChatPayObject.h"


///新浪微博
#import "weiBoEngine.h"
#include "weiBoHtmlObject.h"
#import "weiBoImageObject.h"


///支付宝朋友
#import "APOpenAPI.h"
#import "APEngine.h"
#import "APUrlObject.h"
#import "APTextObject.h"
#import "APImageObject.h"






@implementation GMAuthShareEngine

///获取 分享授权  引擎的实例对象
+(instancetype)authShareEngine:(GME_Third_App_Type) shareAuthType
{
    static GMAuthShareEngine *authShareEngine =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authShareEngine =[[[self class] alloc] init];
    });
    authShareEngine.shareAuthType =shareAuthType;
    return authShareEngine;
}

- (BOOL) isInstalled
{
    ///qq 和qq 空间
    if (GME_Third_App_Type_QQ == _shareAuthType)
    {
        return [[QQEngine shareQQSDKEngine] isQQInstalled];
    }
    ///微信
    else if(GME_Third_App_Type_WeChat == _shareAuthType)
    {
        return [[weChatEngine shareWeChatEngine] isInstallWX];
    }
    ///新浪微博
    else if(GME_Third_App_Type_WeiBo == _shareAuthType)
    {
        //return NO;
        return [[weiBoEngine shareWeiBoEngine] isInstallWB];
    }
    ///腾讯微博
    else if(GME_Third_App_Type_TelentWeiBo == _shareAuthType)
    {
        return NO;
    }
    ///支付宝朋友
    else if (GME_Third_App_Type_AP_Friend == _shareAuthType)
    {
        return [[APEngine shareAPSDKEngine] isAPInstalled];
    }
    else
    {
        return NO;
    }

}
- (BOOL) canHandleOpenURL:(NSURL *) URL
{
    ///qq 和qq 空间
    if (GME_Third_App_Type_QQ == _shareAuthType)
    {
        return [[QQEngine shareQQSDKEngine] canHandleOpenUrl:URL];
    }
    ///微信
    else if(GME_Third_App_Type_WeChat == _shareAuthType)
    {
        return [[weChatEngine shareWeChatEngine] canHandleOpenURL:URL];
    }
    ///新浪微博
    else if(GME_Third_App_Type_WeiBo == _shareAuthType)
    {
        //return NO;
        return [[weiBoEngine shareWeiBoEngine] canHandleOpenURL:URL];;
    }
    ///腾讯微博
    else if(GME_Third_App_Type_TelentWeiBo == _shareAuthType)
    {
        return NO;
    }
    ///支付宝朋友
    else if (GME_Third_App_Type_AP_Friend == _shareAuthType)
    {
        return [[APEngine shareAPSDKEngine] canHandleOpenUrl:URL];
    }
    else
    {
        return NO;
    }
}


- (BOOL) handleOpenURL:(NSURL *) URL
{
    ///qq 和qq 空间
    if (GME_Third_App_Type_QQ == _shareAuthType)
    {
        return [[QQEngine shareQQSDKEngine] handleOpenUrl:URL];
    }
    ///微信
    else if(GME_Third_App_Type_WeChat == _shareAuthType)
    {
        return [[weChatEngine shareWeChatEngine] handleOpenURL:URL];
    }
    ///新浪微博
    else if(GME_Third_App_Type_WeiBo == _shareAuthType)
    {
        //return NO;
        return [[weiBoEngine shareWeiBoEngine] handleOpenURL:URL];
    }
    ///腾讯微博
    else if(GME_Third_App_Type_TelentWeiBo == _shareAuthType)
    {
        return NO;
    }
    
    ///支付宝朋友
    else if (GME_Third_App_Type_AP_Friend == _shareAuthType)
    {
        return [[APEngine shareAPSDKEngine] handleOpenUrl:URL];
    }
    else
    {
        return NO;
    }
}


- (NSString*)sdkVersion
{
    ///qq 和qq 空间
    if (GME_Third_App_Type_QQ == _shareAuthType)
    {
        return [[QQEngine shareQQSDKEngine] sdkVersion];
    }
    ///微信
    else if(GME_Third_App_Type_WeChat == _shareAuthType)
    {
        return [[weChatEngine shareWeChatEngine] sdkVersion];
    }
    ///新浪微博
    else if(GME_Third_App_Type_WeiBo == _shareAuthType)
    {
        //return nil;
        return [[weiBoEngine shareWeiBoEngine] sdkVersion];
    }
    ///腾讯微博
    else if(GME_Third_App_Type_TelentWeiBo == _shareAuthType)
    {
        return nil;
    }
    ///支付宝朋友
    else if (GME_Third_App_Type_AP_Friend == _shareAuthType)
    {
        return [[APEngine shareAPSDKEngine] sdkVersion];
    }
    else
    {
        return nil;
    }
}
/**
 *  授权(不带授权参数 )
 *
 *  @param successCallBack 授权成功的回调
 *
 *  @param failCallBack 授权失败的回调
 *
 *  @return
 */



-(void) authWithSuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result = nil;
    ///qq 和qq 空间
    if (GME_Third_App_Type_QQ == _shareAuthType)
    {
        [[QQEngine shareQQSDKEngine] authWithSuccessCallBack:successCallBack
                                                failCallBack:failCallBack];
    }
    ///微信
    else if(GME_Third_App_Type_WeChat == _shareAuthType)
    {
        [[weChatEngine shareWeChatEngine ] authWithSuccessCallBack:successCallBack
                                                      failCallBack:failCallBack];
    }
    ///新浪微博
    else if(GME_Third_App_Type_WeiBo == _shareAuthType)
    {
        [[weiBoEngine shareWeiBoEngine] authWithSuccessCallBack:successCallBack                                                   failCallBack:failCallBack];
        
        //result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    ///腾讯微博
    else if(GME_Third_App_Type_TelentWeiBo == _shareAuthType)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    ///支付宝朋友
    else if (GME_Third_App_Type_AP_Friend == _shareAuthType)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    return;
    
    
    ///失败的情况
failed:
    if (failCallBack)
    {
        failCallBack(result);
    }
    failCallBack = nil;
    successCallBack = nil;
    return;

}


/**
 *  分享
 *
 *  @param mdicShareContent 分享的内容
 *
 *  @param successCallBack 分享成功的回调
 *
 *  @param failCallBack 分享失败的回调
 *
 *  @return
 */

-(void) shareWithContent:(GMMShareModel *) contenOfShare
               objetType:(GME_Share_Object_Type)objectType
                   scene:(GME_Share_Scene)scene
         SuccessCallBack:(GMShareAuthSuccess)successCallBack
            failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result = nil;
    
    ///解析参数
    ///分享的url
    NSString *strUrl = contenOfShare.strShareUrl;
    NSString *strTitle = contenOfShare.strTitle;
    NSString *strDescription = contenOfShare.strPlaceHolder;
    NSArray *aryImage = contenOfShare.aryThumbImgUrlSet;
    
    ///这里为了兼容，可以设置为默认的国美图像路径
    NSString *strPreviewImageURL = @"";
    NSData *dataImage;
    if (nil != aryImage && aryImage.count>0)
    {
        if ([aryImage[0] isKindOfClass:[NSString class]])
        {
            strPreviewImageURL = aryImage[0];
            dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:strPreviewImageURL]];
        }
        else if ([aryImage[0] isKindOfClass:[UIImage class]])
        {
            strPreviewImageURL = @"";
            dataImage = UIImagePNGRepresentation(aryImage[0]);
        }
        else
        {
            strPreviewImageURL = @"http://mobile.gome.com.cn/mobile/images/logo/share/logo.png";
            dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:strPreviewImageURL]];
        }
    }
    else
    {
        strPreviewImageURL = @"http://mobile.gome.com.cn/mobile/images/logo/share/logo.png";
        dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:strPreviewImageURL]];
    }
    
    if (nil == dataImage )
    {
        strPreviewImageURL = @"http://mobile.gome.com.cn/mobile/images/logo/share/logo.png";
        dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:strPreviewImageURL]];
    }
    
    
    
    ///qq 和qq 空间
    if (GME_Third_App_Type_QQ == _shareAuthType)
    {
        ///分享的目的地
        if (GME_Share_Scene_QQSession !=scene && GME_Share_Scene_QQZone !=scene )
        {
            scene = GME_Share_Scene_QQSession;
        }
        QQScene qqScence =(QQScene)scene;
        
        ///分享html 对象
        if(GME_Share_Object_Type_Url == objectType )
        {
            
            QQURLObject *urlObject =[QQURLObject createQQVideoWithQQScene:qqScence
                                                                    htmlUrl:strUrl
                                                                  htmlTitle:strTitle
                                                                   htmlDesc:strDescription
                                                           htmlPreviewImage:dataImage];
            QQEngine *qqEngine =[QQEngine shareQQSDKEngine];
            [qqEngine shareWithObject:urlObject
                      SuccessCallBack:successCallBack
                         failCallBack:failCallBack];
            
        }
        else if(GME_Share_Object_Type_Text == objectType )
        {
            QQTextObject *textObject =[QQTextObject createQQVideoWithQQScene:qqScence
                                                                  content:strDescription];
            QQEngine *qqEngine =[QQEngine shareQQSDKEngine];
            [qqEngine shareWithObject:textObject
                      SuccessCallBack:successCallBack
                         failCallBack:failCallBack];
        }
        
        else if(GME_Share_Object_Type_Image == objectType )
        {
            QQImageObject *imageObject =[QQImageObject createQQVideoWithQQScene:qqScence
                                                                          title:strTitle
                                                                           desc:strDescription
                                                                      imageData:dataImage
                                                               preViewImageData:dataImage];
            QQEngine *qqEngine =[QQEngine shareQQSDKEngine];
            [qqEngine shareWithObject:imageObject
                      SuccessCallBack:successCallBack
                         failCallBack:failCallBack];
        }
        else
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
            goto failed;

        }


    }
    ///微信
    else if(GME_Third_App_Type_WeChat == _shareAuthType)
    {
        ///分享的目的地
        if (GME_Share_Scene_WeChatSession !=scene && GME_Share_Scene_WeChatTimeLine !=scene )
        {
            scene = GME_Share_Scene_WeChatSession;
        }
        WeChatScene weChatScence =(WeChatScene)(scene - (1<<4));
        
        
        ///分享html 对象
        if(GME_Share_Object_Type_Url == objectType )
        {
            weChatHtmlObject *urlObject =[weChatHtmlObject createWeChatHtmlObjectWithScece:weChatScence
                                                                                     title:strTitle
                                                                                      desc:strDescription
                                                                                 thumbData:dataImage
                                                                                webPageUrl:strUrl];
            weChatEngine *wcEngine = [weChatEngine shareWeChatEngine];
            [wcEngine shareWithObject:urlObject SuccessCallBack:successCallBack failCallBack:failCallBack];
            
        }
        ///微信分享的text 对象
        else if (GME_Share_Object_Type_Text == objectType )
        {
            weChatTextObject *textObject =[weChatTextObject createWeChatTextObjectWithScene:weChatScence
                                                                                    content:strDescription];
            weChatEngine *wcEngine = [weChatEngine shareWeChatEngine];
            [wcEngine shareWithObject:textObject SuccessCallBack:successCallBack failCallBack:failCallBack];
        }
        else if (GME_Share_Object_Type_Image == objectType )
        {
            weChatImageObject *imageObject =[weChatImageObject createWeChatVideoObjectWithScece:weChatScence
                                                                                          title:strTitle
                                                                                           desc:strDescription
                                                                                      thumbData:dataImage
                                                                                       imageUrl:strPreviewImageURL];
            weChatEngine *wcEngine = [weChatEngine shareWeChatEngine];
            [wcEngine shareWithObject:imageObject SuccessCallBack:successCallBack failCallBack:failCallBack];
        }
        else
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
            goto failed;
        }
    }
    ///新浪微博
    else if(GME_Third_App_Type_WeiBo == _shareAuthType)
    {
        ///分享html 对象
        if(GME_Share_Object_Type_Url == objectType )
        {
            weiBoHtmlObject *urlObject =[weiBoHtmlObject createWeiBoHtmlObjectWithTitle:strTitle desc:strDescription webPageUrl:strUrl thumbData:dataImage];
            weiBoEngine *wbEngine = [weiBoEngine shareWeiBoEngine];
            [wbEngine shareWithObject:urlObject SuccessCallBack:successCallBack failCallBack:failCallBack];
            
        }
        ///微信分享的text 对象
        else if (GME_Share_Object_Type_Text == objectType )
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
            goto failed;
        }
        else if (GME_Share_Object_Type_Image == objectType )
        {
            weiBoImageObject *imageObject =[weiBoImageObject createWeiBoImageObjectWithText:strTitle thumbData:dataImage];
            weiBoEngine *wbEngine = [weiBoEngine shareWeiBoEngine];
            [wbEngine shareWithObject:imageObject SuccessCallBack:successCallBack failCallBack:failCallBack];
        }
        else
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
            goto failed;
        }

    }
    ///腾讯微博
    else if(GME_Third_App_Type_TelentWeiBo == _shareAuthType)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    
    ///支付宝朋友
    else if (GME_Third_App_Type_AP_Friend == _shareAuthType)
    {
        ///分享html 对象
        if(GME_Share_Object_Type_Url == objectType )
        {
            APUrlObject *urlObject =[APUrlObject createApWebObjectWithWepageUrl:strUrl
                                                                          title:strTitle
                                                                           desc:strDescription
                                                                   thumbImgData:dataImage
                                                                    thumbImgUrl:strPreviewImageURL];
            APEngine *apEngine = [APEngine shareAPSDKEngine];
            [apEngine shareWithObject:urlObject SuccessCallBack:successCallBack failCallBack:failCallBack];
            
        }
        /// 支付宝朋友 分享的text 对象
        else if (GME_Share_Object_Type_Text == objectType )
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
            goto failed;
        }
        else if (GME_Share_Object_Type_Image == objectType )
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
            goto failed;
        }
        else
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
            goto failed;
        }

    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    
    return ;
    
    
    ///失败的情况
failed:
    if (failCallBack)
    {
        failCallBack(result);
    }
    failCallBack = nil;
    successCallBack = nil;
    return;
    
}



/**
 *  支付
 *
 *  @param contentOfPay 支付的参数
 *
 *  @param successCallBack 支付成功的回调
 *
 *  @param failCallBack 支付失败的回调
 *
 *  @return
 */
-(void) payWithContent:(GMMPayModel *) contentOfPay  SuccessCallBack:(GMShareAuthSuccess) successCallBack failCallBack:(GMShareAuthFail)failCallBack
{
    GMFAuthShareResult *result = nil;
    
    
    ///qq 和qq 空间
    if (GME_Third_App_Type_QQ == _shareAuthType)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    
    ///微信
    else if(GME_Third_App_Type_WeChat == _shareAuthType)
    {
        GMMWeChatPayModel *payModel =(GMMWeChatPayModel *)contentOfPay;
        weChatEngine *wechatEngine = [weChatEngine shareWeChatEngine];
        weChatPayObject *payObject = [weChatPayObject createWeChatTextObjectWithScene:WeChatSceneSession
                                                                               openID:payModel.strOpenID
                                                                            partnerId:payModel.strPartnerId
                                                                             prepayId:payModel.strPrepayId
                                                                             nonceStr:payModel.strNonceStr
                                                                            timeStamp:payModel.strTimeStamp
                                                                              package:payModel.strPackage
                                                                                 sign:payModel.strSign];
        [wechatEngine payWithObject:payObject
                  SuccessCallBack:successCallBack
                     failCallBack:failCallBack];
        
    }
    ///新浪微博
    else if(GME_Third_App_Type_WeiBo == _shareAuthType)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    ///腾讯微博
    else if(GME_Third_App_Type_TelentWeiBo == _shareAuthType)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Not_Support failReason:GMM_Error_Reasion_Not_Support];
        goto failed;
    }
    return ;
    
    
    ///失败的情况
failed:
    if (failCallBack)
    {
        failCallBack(result);
    }
    failCallBack = nil;
    successCallBack = nil;
    return;
}
@end
