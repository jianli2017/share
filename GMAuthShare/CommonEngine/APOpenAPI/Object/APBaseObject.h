//
//  APBaseObject.h
//  GMAuthShare
//
//  Created by LiJian on 16/2/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APOpenAPIObject.h"
#import "GMFAuthShareResult.h"



@interface APBaseObject : NSObject

@property (nonatomic,assign) APScene scene;
/**
 *  验证当前消息数据合法性校验
 *
 *  @return
 */


- (instancetype) initWithScene:(APScene) scene;


-(GMFAuthShareResult *)verifyData;

/**
 *  返回合适的 支付宝好友 相关消息对象
 *
 *  @return 支付宝好友  相关消息对象
 */
- (APBaseReq *) messageObj;


@end
