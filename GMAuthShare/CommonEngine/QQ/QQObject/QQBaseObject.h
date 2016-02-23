//
//  QQBaseObject.h
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QQCommon.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "GMFAuthShareResult.h"

@interface QQBaseObject : NSObject
/**
 *  分享到第三方
 */
@property (nonatomic,assign) QQScene scene;

/**
 *  初始化对象
 *
 *  @param scene 分享到目的地
 *
 *  @return 返回新创建对象
 */
- (instancetype) initWithScene:(QQScene) scene;

/**
 *  验证当前消息数据合法性校验
 *
 *  @return
 */
-(GMFAuthShareResult *)verifyData;

/**
 *  返回合适的QQ相关消息对象
 *
 *  @return QQ相关消息对象
 */
- (QQBaseReq *) messageObj;
@end
