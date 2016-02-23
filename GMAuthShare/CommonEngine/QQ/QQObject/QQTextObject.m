//
//  QQTextObject.m
//  test1
//
//  Created by gengzhangjia on 15/8/4.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "QQTextObject.h"
#import "GMFAuthShareResult.h"

@interface QQTextObject ()
@property (nonatomic, strong) NSString *text;
@end

@implementation QQTextObject
+ (instancetype) createQQVideoWithQQScene:(QQScene) scene
                                  content:(NSString *) text
{
    QQTextObject *textObject =[[QQTextObject alloc] initWithScene:scene];
    textObject.text =text;
    
    return textObject;
}

-(GMFAuthShareResult *)verifyText
{
    GMFAuthShareResult *result =nil;
    if(_text)
    {
        const char *textByte =[_text cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger textSize =strlen(textByte);
        if(textSize >QQ_TEXT_MAXSIZE)
        {
            result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Content_Too_Long failReason:GMM_Error_Reasion_Content_Too_Long];
    
        }
    }
    return  result;
}

-(GMFAuthShareResult *)verifyData
{
    GMFAuthShareResult *result =nil;
    
    return  result;
}

-(QQBaseReq *)messageObj
{
    QQApiTextObject *textObject =[QQApiTextObject objectWithText:_text];
    SendMessageToQQReq *req =[SendMessageToQQReq reqWithContent:textObject];
    
    return req;
}
@end
