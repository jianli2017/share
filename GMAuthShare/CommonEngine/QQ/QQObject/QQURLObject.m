//
//  QQURLObject.m
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "QQURLObject.h"
#import "GMFAuthShareResult.h"

@interface QQURLObject ()
@property (nonatomic, strong) NSString *htmlUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSData *imageData;
@end

@implementation QQURLObject
+ (instancetype) createQQVideoWithQQScene:(QQScene) scene
                                  htmlUrl:(NSString *) htmlUrl
                                htmlTitle:(NSString *) htmlTitle
                                 htmlDesc:(NSString *) htmlDesc
                         htmlPreviewImage:(NSData *)  htmlPreViewImageData
{
    QQURLObject *urlObject =[[QQURLObject alloc] initWithScene:scene];
    urlObject.htmlUrl =htmlUrl;
    urlObject.title =htmlTitle;
    urlObject.desc =htmlDesc;
    urlObject.imageData =htmlPreViewImageData;
    
    return urlObject;
}
- (GMFAuthShareResult *)verifyUrl
{
    GMFAuthShareResult * result =nil;
    if(_htmlUrl)
    {
        const char *urlByte =[_htmlUrl cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger urlSize =strlen(urlByte);
        if(urlSize <=0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO
                                                            failCode:GME_Error_Code_URL_Empty failReason:GMM_Error_Reasion_URL_Empty];
        }
        else if(urlSize >=QQ_MAXSIZE_URL)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO
                                                            failCode:GME_Error_Code_URL_Too_Long failReason:GMM_Error_Reasion_URL_Too_Long];
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
    if(_title)
    {
        const char *textByte =[_title cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger textSize =strlen(textByte);
        if(textSize <=0)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Title_Empty failReason:GMM_Error_Reasion_Title_Empty ];
        }
        else if(textSize >=QQ_MAXSIZE_TITLE)
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
    GMFAuthShareResult * result =nil;
    if(_desc)
    {
        const char *descByte =[_desc cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger descSize =strlen(descByte);
        if(descSize >=QQ_MAXSIZE_DESC)
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

-(GMFAuthShareResult *)verifyImageData
{
    GMFAuthShareResult * result =nil;
    if(_imageData)
    {
        if(_imageData.length >=QQ_MAXSIZE_URL_PREVIEWIMAGE)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_PreImage_Too_Big failReason:GMM_Error_Reasion_PreImage_Too_Big ];
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
        result =[self verifyDesc];
    }
    
    if(!result)
    {
        result =[self verifyUrl];
    }
    
    if(!result)
    {
        result =[self verifyImageData];
    }
    
    return result;
}

-(QQBaseReq *)messageObj
{
    NSURL *url =[NSURL URLWithString:_htmlUrl];
    QQApiNewsObject *newsObject =[QQApiNewsObject objectWithURL:url title:_title description:_desc previewImageData:_imageData targetContentType:QQApiURLTargetTypeNews];
    if(self.scene ==QQSceneZone)
    {
        //[newsObject setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    }
    
    SendMessageToQQReq *req =[SendMessageToQQReq reqWithContent:newsObject];
    
    return req;
}

@end
