//
//  weChatBaseObject.m
//  test1
//
//  Created by gengzhangjia on 15/7/29.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weChatBaseObject.h"



@interface weChatBaseObject ()

@property (nonatomic, assign) WeChatScene wScene;

@end

@implementation weChatBaseObject

- (instancetype) initWithScene:(WeChatScene)scene
{
    if(self =[super init])
    {
        _wScene =scene;
    }
    return self;
}

- (enum WXScene) scene
{
    enum WXScene wxScene =WXSceneSession;
    if(_wScene ==WXSceneSession)
    {
        wxScene =WXSceneSession;
    }
    else if(_wScene ==WXSceneTimeline)
    {
        wxScene =WXSceneTimeline;
    }
    else if(_wScene ==WXSceneFavorite)
    {
        wxScene =WXSceneFavorite;
    }
    
    return wxScene;
}

- (GMFAuthShareResult *) verifyData
{
    return nil;
}

- (BaseReq *) wxMessage
{
    return nil;
}
@end
