//
//  GMFAuthShareResult.m
//  GMAuthShare
//
//  Created by LiJian on 16/1/26.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "GMFAuthShareResult.h"

@implementation GMFAuthShareResult

///初始化方法
-(instancetype )initWithIsSuccessed:(BOOL) isSuccess
                           failCode:(NSInteger) intFailCode
                         failReason:(NSString *) strFailReson
{
    self = [super init];
    if (self)
    {
        _isSuccessed = isSuccess;
        _intFailCode = intFailCode;
        _strFailReason = strFailReson;
    }
    return  self;
}

///初始化方法
-(instancetype ) initWithIsSuccessed:(BOOL) isSuccess
                            failCode:(NSInteger) intFailCode
                          failReason:(NSString *) strFailReson
                            response:(NSMutableDictionary*)mdicResponse
 
{
    self = [super init];
    if (self)
    {
        _isSuccessed = isSuccess;
        _intFailCode = intFailCode;
        _strFailReason = strFailReson;
        if (_mdicResponse == nil)
        {
            _mdicResponse = [NSMutableDictionary dictionary];
            [_mdicResponse addEntriesFromDictionary:mdicResponse];
        }
    }
    return  self;
}

@end
