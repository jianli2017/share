//
//  weChatTextObject.m
//  test1
//
//  Created by gengzhangjia on 15/7/29.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weChatTextObject.h"


@interface weChatTextObject ()
@property (nonatomic, strong) NSString *contentText;
@end

@implementation weChatTextObject

+(instancetype) createWeChatTextObjectWithScene:(WeChatScene)scene content:(NSString *)content
{
    weChatTextObject *textObject =[[weChatTextObject alloc] initWithScene:scene];
    textObject.contentText =content;
    
    return textObject;
}

- (GMFAuthShareResult *)verifyText
{
    GMFAuthShareResult *result =nil;
    if(_contentText)
    {
        const char *text =[_contentText cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger textSize =strlen(text);
        if(textSize <=0)
        {
            result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Content_Empty failReason:GMM_Error_Reasion_Content_Empty];
        }
        else if(textSize >WEIXIN_ARGUMENT_MAXSIZE_TITLE)
        {
            result  = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Content_Too_Long failReason:GMM_Error_Reasion_Content_Too_Long];
        }
    }
    return result;
}

-(GMFAuthShareResult *)verifyData
{
    GMFAuthShareResult *result =nil;
    result =[self verifyText];
    return  result;
}

- (BaseReq *)wxMessage
{
    SendMessageToWXReq *textReq =[[SendMessageToWXReq alloc] init];
    textReq.bText =YES;
    textReq.scene =self.scene;
    textReq.text =self.contentText;
    
    return textReq;
}
@end
