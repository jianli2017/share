//
//  APUrlObject.m
//  GMAuthShare
//
//  Created by LiJian on 16/2/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "APUrlObject.h"

@interface APUrlObject ()
/*
*  @param strWepageUrl           webpage url
*  @param strTitle              分享的标题
*  @param strDesc                 分享的描述
*  @param dataOfThumb              分享的缩略图数据
*  @param strThumbImgUrl           分享的缩略图的url
*/
///分享的url 地址
@property (nonatomic, copy) NSString *strWebPage;

///分享的标题
@property (nonatomic ,copy) NSString *strTitle;

 /// 分享的内容描述
@property( nonatomic, copy) NSString *strDesc;

///分享的缩略图的url
@property(nonatomic, copy) NSString *strThumbImgUrl;

///分享的缩略图的数据
@property(nonatomic, strong) NSData *dataThumbIma;


@end


@implementation APUrlObject


+ (instancetype) createApWebObjectWithWepageUrl:(NSString *) strWepageUrl
                                          title:(NSString *) strTitle
                                           desc:(NSString *) strDesc
                                   thumbImgData:(NSData *)  dataOfThumb
                                    thumbImgUrl:(NSString *)strThumbImgUrl
{
    APUrlObject *urlObject =[[APUrlObject alloc] initWithScene:APSceneSession];
    urlObject.strTitle = strTitle;
    urlObject.strWebPage = strWepageUrl;
    urlObject.strDesc = strDesc;
    urlObject.dataThumbIma = dataOfThumb;
    urlObject.strThumbImgUrl = strThumbImgUrl;
    return urlObject;

}


- (GMFAuthShareResult *)verifyUrl
{
    GMFAuthShareResult * result =nil;
    if(_strWebPage)
    {
        const char *urlByte =[_strWebPage cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger urlSize =strlen(urlByte);
        if(urlSize <=0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO
                                                            failCode:GME_Error_Code_URL_Empty failReason:GMM_Error_Reasion_URL_Empty];
        }
    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO
                                                        failCode:GME_Error_Code_URL_Empty failReason:GMM_Error_Reasion_URL_Empty];
    }
    
    return result;
}


- (GMFAuthShareResult *)verifyTitle
{
    GMFAuthShareResult * result =nil;
    if(_strTitle)
    {
        const char *textByte =[_strTitle cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger textSize =strlen(textByte);
        if(textSize <=0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Title_Empty failReason:GMM_Error_Reasion_Title_Empty ];
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
    GMFAuthShareResult * result =nil;
    if(_strDesc)
    {
        const char *descByte =[_strDesc cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger descSize =strlen(descByte);
        if(descSize <=0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Desc_Empty failReason:GMM_Error_Reasion_Desc_Desc_Empty ];
        }
    }
    else
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Desc_Empty failReason:GMM_Error_Reasion_Desc_Desc_Empty ];
    }
    
    return result;
}

-(GMFAuthShareResult *)verifyImageData
{
    GMFAuthShareResult * result =nil;
    if(_dataThumbIma == nil)
    {
        result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Image_Empty failReason:GMM_Error_Reasion_Image_Empty ];
    }
    else
    {
        if (_dataThumbIma.length ==0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Image_Empty failReason:GMM_Error_Reasion_Image_Empty ];
        }
    }
    return result;
}

-(GMFAuthShareResult *)verifyData
{
    GMFAuthShareResult * result =nil;
    result =[self verifyTitle];
    
    if(!result)
    {
        result =[self verifyUrl];
    }
    
    if (!result)
    {
        result = [self verifyDesc];
    }
    if(!result)
    {
        result =[self verifyImageData];
    }
    
    return result;
}


-(APBaseReq *)messageObj
{
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    
    message.title = _strTitle;
    message.desc = _strDesc;
    //  此处填充缩略图data数据,例如 UIImagePNGRepresentation(UIImage对象)
    //  此处必须填充有效的image NSData类型数据，否则无法正常分享
    message.thumbData = _dataThumbIma;
    //message.wepageUrl = _strThumbImgUrl;
    
    APShareWebObject *webObj = [[APShareWebObject alloc] init];
    webObj.wepageUrl = _strWebPage;
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = webObj;
    
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
//    //  发送请求
//    BOOL result = [APOpenAPI sendReq:request];
//    if (!result) {
//        //失败处理
//        NSLog(@"发送失败");
//    }
    return request;
}




@end
