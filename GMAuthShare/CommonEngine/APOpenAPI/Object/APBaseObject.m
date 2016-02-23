//
//  APBaseObject.m
//  GMAuthShare
//
//  Created by LiJian on 16/2/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "APBaseObject.h"

@implementation APBaseObject

- (instancetype) initWithScene:(APScene) scene
{
    if(self = [super init])
    {
        _scene = scene;
    }
    return self;
}


@end
