//
//  QQTextObject.h
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "QQBaseObject.h"

@interface QQTextObject : QQBaseObject
/**
 *  构建QQ 文字分享对象
 *
 *  @param scene             分享目的地
 *  @param text              分享文字
 *
 *  @return 返回文字分享对象
 */
+ (instancetype) createQQVideoWithQQScene:(QQScene) scene
                                  content:(NSString *) text;
@end
