//
//  QQImageObject.h
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "QQBaseObject.h"

@interface QQImageObject : QQBaseObject
/**
 *  构建QQ 图片分享对象
 *
 *  @param scene             分享目的地
 *  @param title             分享标题
 *  @param desc              分享描述
 *  @param imageData         分享图片数据
 *  @param preViewImageData  分享预览的图片数据
 *
 *  @return 返回文字分享对象
 */
+ (instancetype) createQQVideoWithQQScene:(QQScene) scene
                                    title:(NSString *) title
                                     desc:(NSString *)desc
                                imageData:(NSData *)imageData
                         preViewImageData:(NSData *)preViewImageData;
@end
