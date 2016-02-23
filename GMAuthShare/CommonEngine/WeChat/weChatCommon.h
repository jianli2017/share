//
//  weChatCommon.h
//  test1
//
//  Created by gengzhangjia on 15/7/29.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#ifndef test1_weChatCommon_h
#define test1_weChatCommon_h

#import <UIKit/UIKit.h>

/**
 *  标题不能超过512个字节
 */
#define                 WEIXIN_ARGUMENT_MAXSIZE_TITLE           512

/**
 *  缩略图压缩后的最大宽度
 */
#define                 THUMBIMAGE_MAXWIDTH                     200

/**
 *  描述内容长度不能超过1K
 */
#define                 WEIXIN_ARGUMENT_MAXSIZE_DESCRIPTION     1024

/**
 *  缩略图数据大小不能超过32K
 */
#define                 WEIXIN_ARGUMENT_MAXSIZE_THUMBIMAGE      32 * 1024

/**
 *  网页的地址不能为空且长度不能超过10K
 */
#define                 WEIXIN_ARGUMENT_MAXSIZE_URL             10 * 1024

/**
 *  文本消息不能超过10k
 */
#define                 WEIXIN_ARGUMENT_MAXSIZE_TEXT            10 * 1024

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

@class weChatResult;
/**
 *  微信分享回调定义
 */
typedef void(^weChatCallBackBlock)(weChatResult *result);


/**
 *  微信返回码
 */
typedef NS_ENUM(NSUInteger,WeChatResultCode)
{
    /**
     *  默认
     */
    WeChatResultCodeNone,
    
    /**
     *  成功
     */
    WeChatResultCodeSuccess,
    
    /**
     *  普通错误
     */
    WeChatResultCodeCommon,
    
    /**
     *  用户点击取消
     */
    WeChatResultCodeUserCancel,
    
    /**
     *  发送失败
     */
    WeChatResultCodeSendFail,
    
    /**
     *  授权失败
     */
    WeChatResultCodeAuthDeny,
    
    /**
     *  微信不支持
     */
    WeChatResultCodeUnSupport,
    
    /**
     *  未安装微信
     */
    WeChatResultCodeUnInstalled,
    
    /**
     *  条件错误
     */
    WeChatResultCodeConditionError,
};

#endif
