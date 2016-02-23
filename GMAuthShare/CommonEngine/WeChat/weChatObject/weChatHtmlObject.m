//
//  weChatHtmlObject.m
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weChatHtmlObject.h"

#import "UIImage+Common.h"

@interface weChatHtmlObject ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSData *thumbData;
@property (nonatomic, strong) NSString *webPageUrl;

@end

@implementation weChatHtmlObject
+ (instancetype) createWeChatHtmlObjectWithScece:(WeChatScene) xScene
                                           title:(NSString *) title
                                            desc:(NSString *) desc
                                       thumbData:(NSData *) thumbData
                                      webPageUrl:(NSString *) webPageUrl
{
    weChatHtmlObject *htmlObject =[[weChatHtmlObject alloc] initWithScene:xScene];
    htmlObject.title =title;
    htmlObject.desc =desc;
    htmlObject.thumbData =thumbData;
    htmlObject.webPageUrl =webPageUrl;
    
    return htmlObject;
}

- (GMFAuthShareResult *)verifyTitle
{
    GMFAuthShareResult *result =nil;
    if(_title)
    {
        const char *titleByte =[_title cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger titleSize =strlen(titleByte);
        if(titleSize <=0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Title_Empty failReason:GMM_Error_Reasion_Title_Empty ];
        }
        else if(titleSize > WEIXIN_ARGUMENT_MAXSIZE_TITLE)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Title_Too_Long failReason:GMM_Error_Reasion_Title_Too_Long ];
        }
    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Title_Empty failReason:GMM_Error_Reasion_Title_Empty ];
    }
    return result;
}
- (GMFAuthShareResult *)verifyDesc
{
    GMFAuthShareResult *result =nil;
    if(_desc)
    {
        const char *descByte =[_desc cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger descSize =strlen(descByte);
        if(descSize >WEIXIN_ARGUMENT_MAXSIZE_DESCRIPTION)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Desc_Too_Long failReason:GMM_Error_Reasion_Desc_Too_Long ];
        }
    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Desc_Empty failReason:GMM_Error_Reasion_Desc_Desc_Empty ];
    }
    return result;
    
}

- (NSData *) getThumbData
{
    NSData *thumbImageData = _thumbData;
    NSUInteger thumbImagSize = [_thumbData length];
    if (thumbImagSize <= 0 || thumbImagSize >= WEIXIN_ARGUMENT_MAXSIZE_THUMBIMAGE)
    {
        UIImage *thumbImage = [UIImage imageWithData:_thumbData];
        CGFloat w = thumbImage.size.width;
        CGFloat h = thumbImage.size.height;
        CGSize maxSize = CGSizeMake(THUMBIMAGE_MAXWIDTH, h  * THUMBIMAGE_MAXWIDTH / w);
        UIImage *resizeImage =  [thumbImage resizeInArea:maxSize];
        
        NSData *tempData = UIImageJPEGRepresentation(resizeImage, THUMBIMAGE_COMPRESSION_QUALITY_LOW);
        if(tempData.length >= WEIXIN_ARGUMENT_MAXSIZE_THUMBIMAGE)
        {
            tempData = UIImageJPEGRepresentation(resizeImage, THUMBIMAGE_COMPRESSION_QUALITY_MEDIUM);
            if(tempData.length >= WEIXIN_ARGUMENT_MAXSIZE_THUMBIMAGE)
                tempData = UIImageJPEGRepresentation(resizeImage, THUMBIMAGE_COMPRESSION_QUALITY_HIGH);
        }
        thumbImageData = tempData;
    }
    return thumbImageData;
}

- (GMFAuthShareResult *) verifyThumbData
{
    GMFAuthShareResult *result = nil;
    NSData *thumbImageData = [self getThumbData];
    NSUInteger newThumbImagSize = [thumbImageData length];
    if (newThumbImagSize <= 0 || newThumbImagSize >= WEIXIN_ARGUMENT_MAXSIZE_THUMBIMAGE)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_PreImage_Too_Big failReason:GMM_Error_Reasion_PreImage_Too_Big ];
    }
    return result;
}

- (GMFAuthShareResult *) verifyWebPageUrl
{
    GMFAuthShareResult *result = nil;
    if(_webPageUrl)
    {
        const char *urlByte = [_webPageUrl cStringUsingEncoding:NSUTF8StringEncoding];
        NSUInteger urlSize = strlen(urlByte);
        
        if (urlSize <= 0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO
                                                            failCode:GME_Error_Code_URL_Empty failReason:GMM_Error_Reasion_URL_Empty];
        }
        else if(urlSize >= WEIXIN_ARGUMENT_MAXSIZE_URL)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO
                                                            failCode:GME_Error_Code_URL_Empty failReason:GMM_Error_Reasion_URL_Too_Long];
        }
    }
    return result;
}

-(GMFAuthShareResult *)verifyData
{
    GMFAuthShareResult *result =nil;
    result =[self verifyTitle];
    if(!result)
    {
        [self verifyDesc];
    }
    if(!result)
    {
        [self verifyThumbData];
    }
    if(!result)
    {
        [self verifyWebPageUrl];
    }
    return result;
}

-(BaseReq *)wxMessage
{
    SendMessageToWXReq *req =[[SendMessageToWXReq alloc] init];
    WXMediaMessage *message =[WXMediaMessage message];
    message.title =_title;
    message.description =_desc;
    [message setThumbData:[self getThumbData]];
    
    WXWebpageObject *ext =[WXWebpageObject object];
    ext.webpageUrl =_webPageUrl;
    
    message.mediaObject =ext;
    
    req.bText =NO;
    req.scene =self.scene;
    req.message =message;
    return req;
}
@end
