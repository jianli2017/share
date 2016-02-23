//
//  weiBoHtmlObject.m
//  test1
//
//  Created by gengzhangjia on 15/8/3.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weiBoHtmlObject.h"
#import "UIImage+Common.h"
@interface weiBoHtmlObject ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc ;
@property (nonatomic, strong) NSString *webPageUrl;
@property (nonatomic, strong) NSData *thumbData;

@end

@implementation weiBoHtmlObject

+ (instancetype) createWeiBoHtmlObjectWithTitle:(NSString *) title
                                           desc:(NSString *)desc
                                     webPageUrl:(NSString *) webPageUrl
                                      thumbData:(NSData *) thumbData
{
    weiBoHtmlObject *htmlObject =[[weiBoHtmlObject alloc]init];
    htmlObject.title =title;
    htmlObject.desc =desc;
    htmlObject.webPageUrl =webPageUrl;
    htmlObject.thumbData =thumbData;
    
    return htmlObject;
}

- (GMFAuthShareResult *)verifyTitle
{
    GMFAuthShareResult *result =nil;
    if(_title)
    {
        const char *textByte =[_title cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger textSize =strlen(textByte);
        if(textSize <=0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Title_Empty failReason:GMM_Error_Reasion_Title_Empty ];
        }
        else if(textSize >=WEIBO_ARGUMENT_MAXSIZE_TITLE)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Title_Too_Long failReason:GMM_Error_Reasion_Title_Too_Long ];
        }
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
        if(descSize >=WEIBO_ARGUMENT_MAXSIZE_TITLE)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Desc_Too_Long failReason:GMM_Error_Reasion_Desc_Too_Long ];
        }
    }
    return  result;
}

//- (GMFAuthShareResult *)verifyThumData
//{
//    GMFAuthShareResult *result =nil;
//    if(_thumbData)
//    {
//        if(_thumbData.length >=WEIBO_ARGUMENT_MAXSIZE_THUMBIMAGE)
//        {
//            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_PreImage_Too_Big failReason:GMM_Error_Reasion_PreImage_Too_Big ];
//        }
//    }
//    
//    return  result;
//}

- (GMFAuthShareResult *)verifyPageUrl
{
    GMFAuthShareResult *result =nil;
    if(_webPageUrl)
    {
        const char *urlByte = [_webPageUrl cStringUsingEncoding:NSUTF8StringEncoding];
        NSUInteger urlSize = strlen(urlByte);
        
        if (urlSize <= 0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO
                                                            failCode:GME_Error_Code_URL_Empty failReason:GMM_Error_Reasion_URL_Empty];
        }
        else if(urlSize >= WEIBO_ARGUMENT_MAXSIZE_PAGEURL)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO
                                                            failCode:GME_Error_Code_URL_Empty failReason:GMM_Error_Reasion_URL_Too_Long];
        }
    }
    return result;
}
- (NSData *) getThumbData
{
    NSData *thumbImageData = _thumbData;
    NSUInteger thumbImagSize = [_thumbData length];
    if (thumbImagSize <= 0 || thumbImagSize >= WEIBO_ARGUMENT_MAXSIZE_THUMBIMAGE)
    {
        UIImage *thumbImage = [UIImage imageWithData:_thumbData];
        CGFloat w = thumbImage.size.width;
        CGFloat h = thumbImage.size.height;
        CGSize maxSize = CGSizeMake(THUMBIMAGE_MAXWIDTH, h  * THUMBIMAGE_MAXWIDTH / w);
        UIImage *resizeImage =  [thumbImage resizeInArea:maxSize];
        
        NSData *tempData = UIImageJPEGRepresentation(resizeImage, THUMBIMAGE_COMPRESSION_QUALITY_LOW);
        if(tempData.length >= WEIBO_ARGUMENT_MAXSIZE_THUMBIMAGE)
        {
            tempData = UIImageJPEGRepresentation(resizeImage, THUMBIMAGE_COMPRESSION_QUALITY_MEDIUM);
            if(tempData.length >= WEIBO_ARGUMENT_MAXSIZE_THUMBIMAGE)
                tempData = UIImageJPEGRepresentation(resizeImage, THUMBIMAGE_COMPRESSION_QUALITY_HIGH);
        }
        thumbImageData = tempData;
    }
    return thumbImageData;
}

- (GMFAuthShareResult *) verifyThumData
{
    GMFAuthShareResult *result = nil;
    NSData *thumbImageData = [self getThumbData];
    NSUInteger newThumbImagSize = [thumbImageData length];
    if (newThumbImagSize <= 0 || newThumbImagSize >= WEIBO_ARGUMENT_MAXSIZE_THUMBIMAGE)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_PreImage_Too_Big failReason:GMM_Error_Reasion_PreImage_Too_Big ];
    }
    return result;
}
-(GMFAuthShareResult *)verifyData
{
    GMFAuthShareResult  *result =nil;
    result =[self verifyTitle];
    if(!result)
    {
        result =[self verifyDesc];
    }
    if(!result)
    {
        result =[self verifyThumData];
    }
    if(!result)
    {
        result =[self verifyPageUrl];
    }
    return result;
}

-(WBBaseRequest *)WBMessage
{
    WBMessageObject *message =[WBMessageObject message];
    
    WBWebpageObject *webObject =[WBWebpageObject object];
    webObject.objectID =@"identifier1";
    webObject.title =_title;
    webObject.description =_desc;
    webObject.thumbnailData =[self getThumbData];
    webObject.webpageUrl =_webPageUrl;
    
    message.mediaObject =webObject;
    
    WBSendMessageToWeiboRequest *request =[WBSendMessageToWeiboRequest requestWithMessage:message];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    
    return  request;
}

@end
