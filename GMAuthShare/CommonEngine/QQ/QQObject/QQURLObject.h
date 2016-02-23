//
//  QQURLObject.h
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "QQBaseObject.h"
#import "QQCommon.h"
@interface QQURLObject : QQBaseObject
/**
 *  构建QQ HTML分享对象
 *
 *  @param scene             分享目的地
 *  @param htmlUrl           html的url
 *  @param htmlTitle         html的标题
 *  @param htmlDesc          html的描述
 *  @param htmlPreViewImage  html的预览图
 *
 *  @return 返回视频分享对象
 */
+ (instancetype) createQQVideoWithQQScene:(QQScene) scene
                                  htmlUrl:(NSString *) htmlUrl
                                htmlTitle:(NSString *) htmlTitle
                                 htmlDesc:(NSString *) htmlDesc
                         htmlPreviewImage:(NSData *)  htmlPreViewImageData;
@end
