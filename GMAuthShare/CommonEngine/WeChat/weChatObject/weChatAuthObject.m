//
//  weChatAuthObject.m
//  test1
//
//  Created by gengzhangjia on 15/7/29.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weChatAuthObject.h"

@implementation weChatAuthObject

+ (instancetype) createWeChatAuthObject
{
    weChatAuthObject *authObject =[[weChatAuthObject alloc] init];
    return authObject;
}

-(BaseReq *)wxMessage
{
    SendAuthReq *req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
    req.state = @"Gome1234";
    
    return req;
}
@end
