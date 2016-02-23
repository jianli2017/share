//
//  weiBoAuthObject.m
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weiBoAuthObject.h"


@implementation weiBoAuthObject
+ (instancetype) createWeiBoAuth
{
    weiBoAuthObject *AuthObject =[[weiBoAuthObject alloc] init];
    
    return AuthObject;
}

-(WBBaseRequest *)WBMessage
{
    WBAuthorizeRequest *request =[WBAuthorizeRequest request];
    request.redirectURI =kRedirectURI;
    request.scope =@"all";
    request.userInfo =@{@"SSO_From": @"SendMessageToWeiboViewController",
                        @"Other_Info_1": [NSNumber numberWithInt:123],
                        @"Other_Info_2": @[@"obj1", @"obj2"],
                        @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return  request;
}

@end
