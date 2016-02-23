//
//  GMAuthShareCommon.h
//  GMAuthShare
//
//  Created by LiJian on 16/1/26.
//  Copyright © 2016年 LJ. All rights reserved.
//


#ifndef GMAuthShareCommon_h
#define GMAuthShareCommon_h

@class GMFAuthShareResult;
///分享、授权的成功回调block
typedef void(^ GMShareAuthSuccess)(GMFAuthShareResult *result);

///分享、授权的失败回调block
typedef void(^ GMShareAuthFail)(GMFAuthShareResult *result);


///相关的宏定义

/// 分享、 授权的app 的类型
typedef NS_ENUM(NSInteger,GME_Third_App_Type)
{
    ///qq
    GME_Third_App_Type_QQ =1,
    
    ///微信
    GME_Third_App_Type_WeChat,
    
    /// 新浪微博
    GME_Third_App_Type_WeiBo,
    
    
    GME_Third_App_Type_TelentWeiBo,
    
    GME_Third_App_Type_AP_Friend  ///支付宝朋友
};


///操作的类型 （分为 授权，支付、分享）
typedef NS_ENUM(NSInteger,GME_Operation_Type)
{
    ///认证
    GME_Operation_Auth =1,
    
    ///分享
    GME_Operation_Share,
    
    /// 支付
    GME_Operation_Pay
    

};

///分享的目的地
typedef NS_ENUM(NSInteger,GME_Share_Scene)
{
    GME_Share_Scene_QQSession, ///qq 好友
   
    GME_Share_Scene_QQZone, ///qq 空间
    
    
    GME_Share_Scene_WeChatSession = 1<<4,  /// 微信好友
    
    
    GME_Share_Scene_WeChatTimeLine, ///微信朋友圈
    
    GME_Share_Scene_WeChatFavoritee, ///微信收藏
    
    GME_Share_Scene_Sina_WeiBo = 1<<5, ///新浪微博
    
    GME_Share_Scene_Tencent_WeiBo = 1<<6, ///腾讯微博
    
    GME_Share_Scene_AP_Friend = 1<<7, ///支付宝朋友
};

///分享的对象的类型 （目前支持的类型为url、图像、文本）
typedef NS_ENUM(NSInteger,GME_Share_Object_Type)
{
    ///url 对象
    GME_Share_Object_Type_Url ,
    
    ///文本对象
    GME_Share_Object_Type_Text,
    
    /// 图像退休
    GME_Share_Object_Type_Image
    
    
};


/**
 *  QQ分享的目的地
 */
typedef NS_ENUM(NSInteger,QQScene)
{
    /**
     *  默认
     */
    QQSceneNone,
    /**
     *  QQ好友
     */
    QQSceneSession = QQSceneNone,
    
    /**
     *  QQ空间
     */
    QQSceneZone,
};



/**
 *  微信分享的目的地
 */
typedef NS_ENUM(NSInteger,WeChatScene)
{
    /**
     *  默认
     */
    WeChatSceneNone,
    /**
     *  聊天界面
     */
    WeChatSceneSession = WeChatSceneNone,
    
    /**
     *  朋友圈
     */
    WeChatSceneTimeLine,
    
    /**
     *  收藏
     */
    WeChatSceneFavorite,
};


///错误码
typedef NS_ENUM(NSInteger,GME_Error_Code)
{
    ///成功
    GME_Error_Code_Success =0x00000000,
    
    ///标题为空
    GME_Error_Code_Title_Empty =0xff0000,
    
    ///标题太长
    GME_Error_Code_Title_Too_Long,
    
    ///描述为空
    GME_Error_Code_Desc_Empty,
    
    ///描述太长
    GME_Error_Code_Desc_Too_Long,
    
    ///图片太大
    GME_Error_Code_Image_Too_Big,
    
    
    ///缩略图太大
    GME_Error_Code_PreImage_Too_Big,
    
    ///缩略图不能为空
    GME_Error_Code_Image_Empty,
    
    
    ///分享的文字内容不能为空
    GME_Error_Code_Content_Empty,
    
    
    ///分享的文字内容太长
    GME_Error_Code_Content_Too_Long,
    
    ///分享的URL太长
    GME_Error_Code_URL_Too_Long,
    
    ///分享的URL不能为空
    GME_Error_Code_URL_Empty,
    
    ///没有安装客户端
    GME_Error_Code_Not_Install_App,
    
    ///请更新,现有版本不支持API
    GME_Error_Code_API_Too_Low,
    
    ///授权失败
    GME_Error_Code_Auth_Fail,
    
    ///参数错误
    GME_Error_Code_Param_Error,
    
    ///不支持的操作类型
    GME_Error_Code_Not_Support,
    
    
    
    ///未知错误
    GME_Error_Code_Unknown,
    
};


///错误码  对应的错误原因
#define GMM_Error_Reasion_Title_Empty @"分享的标题不能为空"
#define GMM_Error_Reasion_Title_Too_Long @"分享的标题太长"
#define GMM_Error_Reasion_Desc_Too_Long @"分享的描述太长"
#define GMM_Error_Reasion_Desc_Desc_Empty @"分享的描述为空"

#define GMM_Error_Reasion_Image_Too_Big @"图片太大"
#define GMM_Error_Reasion_Image_Empty @"缩略图不能为空"
#define GMM_Error_Reasion_PreImage_Too_Big @"缩略图太大"
#define GMM_Error_Reasion_Content_Empty @"分享的文字内容不能为空"
#define GMM_Error_Reasion_Content_Too_Long @"分享的文字内容太长"
#define GMM_Error_Reasion_URL_Too_Long @"分享的URL太长"
#define GMM_Error_Reasion_URL_Empty @"分享的URL不能为空"

#define GMM_Error_Reasion_Not_Install_App @"没有安装客户端"

#define GMM_Error_Reasion_API_Too_Low @"请更新,现有版本不支持API"
#define GMM_Error_Reasion_Auth_Fail @"授权失败"
#define GMM_Error_Reasion_Not_Support @"不支持的操作类型"





#define GMM_Error_Reasion_APP_Not_Register @"App未注册"
#define GMM_Error_Reasion_Param_Error @"发送参数错误"
#define GMM_Error_Reasion_Fail_Send @"发送失败"
#define GMM_Error_Reasion_other @"其他错误"

#define GMM_Error_Reasion_Unknown @"未知错误"

#endif /* GMAuthShareCommon_h */
