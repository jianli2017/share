//
//  GMFAuthShareResult.h
//  GMAuthShare
//
//  Created by LiJian on 16/1/26.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMAuthShareCommon.h"

///第三方 分享、授权 处理的结果
@interface GMFAuthShareResult : NSObject

///分享、授权  是否成功
@property(nonatomic, assign) BOOL isSuccessed;

///分享、授权  操作失败的错误码(包括之定义错误GME_Error_Code 和 原生的错误)
@property(nonatomic, assign) NSInteger intFailCode;

///分享、授权  操作失败的错误信息
@property(nonatomic, copy) NSString *strFailReason;

///分享、授权  操作成功的响应数据
@property(nonatomic, strong) NSMutableDictionary *mdicResponse;


///初始化方法
-(instancetype )initWithIsSuccessed:(BOOL) isSuccess
                            failCode:(NSInteger) intFailCode
                          failReason:(NSString *) strFailReson;

///初始化方法
-(instancetype ) initWithIsSuccessed:(BOOL) isSuccess
                            failCode:(NSInteger) intFailCode
                          failReason:(NSString *) strFailReson
                            response:(NSMutableDictionary*)mdicResponse;

@end
