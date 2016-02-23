//
//  weiBoHtmlObject.h
//  test1
//
//  Created by gengzhangjia on 15/8/3.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weiBoBaseObject.h"

@interface weiBoHtmlObject : weiBoBaseObject

+ (instancetype) createWeiBoHtmlObjectWithTitle:(NSString *) title
                                           desc:(NSString *)desc
                                        webPageUrl:(NSString *) webPageUrl
                                        thumbData:(NSData *) thumbData ;
@end
