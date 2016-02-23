//
//  weiBoCommon.h
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#ifndef test1_weiBoCommon_h
#define test1_weiBoCommon_h

//com.sina.weibo.SNWeiboSDKDemo

#define SINA_APP_KEY @"3648338736"
#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"
//com.dynamicode.lijian

//#define SINA_APP_KEY @"686166542"
//#define SINA_APP_SECRET @"abf27897df4c5c9ad61cdf80c956495a"
//#define kRedirectURI @"http://www.gome.com.cn"
//com.gome.gomeEShop

/**
 *  标题不能超过512个字节
 */
#define                 WEIBO_ARGUMENT_MAXSIZE_TITLE           1024

/**
 *  图片不能超过10M
 */
#define                 WEIBO_ARGUMENT_MAXSIZE_IMAGE           10*1024*1024

/**
 *  缩略图不能超过32K
 */
#define                 WEIBO_ARGUMENT_MAXSIZE_THUMBIMAGE           32*1024

/**
 *  webPageUrl不能超过255
 */
#define                 WEIBO_ARGUMENT_MAXSIZE_PAGEURL           255

/**
 *  缩略图压缩后的最大宽度
 */
#define                 THUMBIMAGE_MAXWIDTH                     200


/**
 *  缩略图压缩等级低
 */
#define                 THUMBIMAGE_COMPRESSION_QUALITY_LOW      0.8

/**
 *  缩略图压缩等级中
 */
#define                 THUMBIMAGE_COMPRESSION_QUALITY_MEDIUM   0.7

/**
 *  压缩等级高
 */
#define                 THUMBIMAGE_COMPRESSION_QUALITY_HIGH     0.5

@class weiBoResult;
/**
 *  微博分享的回调声明
 */
typedef void(^weiBoCallBackBlock)(weiBoResult *result);

/**
 *  微博分享结果码
 */
typedef NS_ENUM(NSUInteger, weiBoResultCode){
    /**
     *  默认
     */
    weiBoResultCodeNone,
    /**
     *  微博分享成功
     */
    weiBoResultCodeSuccess,
    
    /**
     *  支付失败
     */
    weiBoResultCodePayFail,
    
    /**
     *  分享失败
     */
    weiBoResultCodeShareInSDKFailed,
    
    /**
     *  用户取消分享
     */
    weiBoResultCodeUserCancel,
    /**
     *  微博发送失败
     */
    weiBoResultCodeSendFail,
    /**
     *  微博授权失败
     */
    weiBoResultCodeAuthDeny,
    /**
     *  用户取消微博安装
     */
    weiBoResultCodeCancelInstall,
    /**
     *  不支持的分享
     */
    weiBoResultCodeUnSupport,
    
    /**
     *  没有安装微博
     */
    weiBoResultCodeUnInstall,
    
    /**
     *  分享到微博的文字太长
     */
    weiBoResultCodeTextMaxLength,
    
    /**
     *  缩略图太大
     */
    weiBoResultCodeMaxThumbData,
    
    /**
     *  未知错误
     */
    weiBoResultCodeUnKown,
};

#endif
