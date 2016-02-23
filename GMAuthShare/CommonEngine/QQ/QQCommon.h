//
//  QQCommon.h
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#ifndef test1_QQCommon_h
#define test1_QQCommon_h
@class QQResult;
typedef void(^QQCallBackBlock)(QQResult *result);

/**
 *  text不能超过1536个字节
 */
#define                 QQ_TEXT_MAXSIZE          1536

/**
 *  标题不能超过128个字节
 */
#define                 QQ_MAXSIZE_TITLE          128

/**
 *  描述不能超过512个字节
 */
#define                 QQ_MAXSIZE_DESC           512

/**
 *  URL不能超过512个字节
 */
#define                 QQ_MAXSIZE_URL           512

/**
 *  urlPreViewImage不能超过1M
 */
#define                 QQ_MAXSIZE_URL_PREVIEWIMAGE           1024*1024

/**
 *  urlImage不能超过5M
 */
#define                 QQ_MAXSIZE_URL_IMAGE          5*1024*1024



/**
 *  QQ返回码
 */
typedef NS_ENUM(NSUInteger, QQResultCode){
    QQResultCodeSuccess,
    QQResultCodeNotInstall,
    QQResultCodeNotSupportAPI,
    QQResultCodeMessageTypeInvalid,
    QQResultCodeMessageContentNULL,
    QQResultCodeMessageContentInvalid,
    QQResultCodeAppNotRegisted,
    QQResultCodeAppShareAsync,
    QQResultCodeQQNotSupportAPI_With_ErrorShow,
    QQResultCodeEndFaild,
    QQResultCodeQZoneNotSupportText,
    QQResultCodeQZoneNotSupportImage,
    QQAuthResultUserCancel,
};
#endif
