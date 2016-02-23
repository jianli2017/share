//
//  QQImageObject.m
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "QQImageObject.h"
//#import "QQResult.h"
#include "GMFAuthShareResult.h"

@interface QQImageObject ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSData *preViewImageData;

@end

@implementation QQImageObject

+ (instancetype) createQQVideoWithQQScene:(QQScene) scene
                                    title:(NSString *) title
                                     desc:(NSString *)desc
                                imageData:(NSData *)imageData
                         preViewImageData:(NSData *)preViewImageData
{
    QQImageObject *imageObject =[[QQImageObject alloc] initWithScene:scene];
    imageObject.title =title;
    imageObject.desc =desc;
    imageObject.imageData =imageData;
    imageObject.preViewImageData =preViewImageData;
    
    return imageObject;
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
    
    return result;
}

-(GMFAuthShareResult *)verifyImageData
{
    GMFAuthShareResult * result =nil;
    if(_imageData)
    {
        if(_imageData.length >=QQ_MAXSIZE_URL_IMAGE)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Image_Too_Big failReason:GMM_Error_Reasion_Image_Too_Big ];
        }
    }
    
    return result;
}

- (GMFAuthShareResult *)verifyPreViewImageData
{
    GMFAuthShareResult * result =nil;
    if(_preViewImageData)
    {
        if(_preViewImageData.length >=QQ_MAXSIZE_URL_PREVIEWIMAGE)
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
        result =[self verifyPreViewImageData];
    }
    if(!result)
    {
        result =[self verifyImageData];
    }
    
    return result;
}

-(QQBaseReq *)messageObj
{
    QQApiImageObject *imageObject =[QQApiImageObject objectWithData:self.imageData previewImageData:self.preViewImageData title:self.title description:self.desc];
    
    SendMessageToQQReq *req =[SendMessageToQQReq reqWithContent:imageObject];
    return req;
}
@end
