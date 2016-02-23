//
//  weiBoMessageObject.m
//  test1
//
//  Created by gengzhangjia on 15/7/30.
//  Copyright (c) 2015年 gengzhangjia. All rights reserved.
//

#import "weiBoImageObject.h"

@interface weiBoImageObject ()
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSData *thumbData;

@end

@implementation weiBoImageObject
+ (instancetype) createWeiBoImageObjectWithText:(NSString *) text
                                        thumbData:(NSData *) thumbData
{
    weiBoImageObject *messageObject =[[weiBoImageObject alloc] init];
    messageObject.text =text;
    messageObject.thumbData =thumbData;
    
    return messageObject;
}

- (GMFAuthShareResult *)verifyTitle
{
    GMFAuthShareResult *result =nil;
    if(_text)
    {
        const char *textByte =[_text cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger textSize =strlen(textByte);
        if(textSize >=WEIBO_ARGUMENT_MAXSIZE_TITLE)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Title_Too_Long failReason:GMM_Error_Reasion_Title_Too_Long ];
        }
    }
    return result;
}

- (GMFAuthShareResult *)verifyThumbData
{
    GMFAuthShareResult *result =nil;
    if(_thumbData)
    {
        if(_thumbData.length >=WEIBO_ARGUMENT_MAXSIZE_IMAGE)
        {
            result = [[GMFAuthShareResult alloc] initWithIsSuccessed:NO failCode:GME_Error_Code_Desc_Too_Long failReason:GMM_Error_Reasion_Desc_Too_Long ];
        }
    }
    
    return  result;
}

-(GMFAuthShareResult *)verifyData
{
    GMFAuthShareResult *result =nil;
    
    result =[self verifyTitle];
    if(!result)
    {
        result =[self verifyThumbData];
    }
    
    return result;
}

- (WBBaseRequest *)WBMessage
{
    WBMessageObject *message =[WBMessageObject message];
    
    WBImageObject *weImage =[WBImageObject object];
    weImage.imageData =_thumbData;
    
    message.text =_text;
    message.imageObject =weImage;
    
    WBSendMessageToWeiboRequest *request =[WBSendMessageToWeiboRequest requestWithMessage:message];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    
    return  request;
}

@end
