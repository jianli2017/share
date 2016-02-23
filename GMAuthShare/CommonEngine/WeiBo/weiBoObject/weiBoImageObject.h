//
//  weiBoMessageObject.h
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weiBoBaseObject.h"

@interface weiBoImageObject : weiBoBaseObject

+ (instancetype) createWeiBoImageObjectWithText:(NSString *) text
                                          thumbData:(NSData *) thumbData;
@end
