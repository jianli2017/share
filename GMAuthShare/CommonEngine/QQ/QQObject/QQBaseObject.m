//
//  QQBaseObject.m
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "QQBaseObject.h"

@implementation QQBaseObject

- (instancetype) initWithScene:(QQScene) scene
{
    if(self = [super init])
    {
        _scene = scene;
    }
    return self;
}

-(QQResult *)verifyData
{
    QQResult * result =nil;
    
    
    return result;
}

- (QQBaseReq *) messageObj
{
    return nil;
}
@end
