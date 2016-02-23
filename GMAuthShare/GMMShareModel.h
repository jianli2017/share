//
//  GMMShareModel.h
//  GMAuthShare
//
//  Created by LiJian on 16/2/1.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMMShareModel : NSObject


///分享的标题
@property(nonatomic, copy) NSString *strTitle;

///分享的描述 （description）
@property(nonatomic, copy) NSString *strPlaceHolder;

///分享的url 地址
@property(nonatomic, copy) NSString *strShareUrl;

///没有url 的description
@property(nonatomic, copy) NSString *strStrNoShareUrlPlaceHolder;

///分享的图片地址
@property(nonatomic, strong) NSArray *aryThumbImgUrlSet;


@end
