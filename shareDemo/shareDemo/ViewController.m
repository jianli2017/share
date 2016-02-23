//
//  ViewController.m
//  shareDemo
//
//  Created by LiJian on 16/2/22.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "ViewController.h"
#import "GMAuthShareEngine.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)QQLogin:(id)sender
{
    [[GMAuthShareEngine authShareEngine:GME_Third_App_Type_QQ]
    authWithSuccessCallBack:^(GMFAuthShareResult *result)
    {
        
    }
     failCallBack:^(GMFAuthShareResult *result) {
        
    }];
}
- (IBAction)QQShare:(id)sender {
    
    GMMShareModel *shareContent = [self buildShareContent];
    [[GMAuthShareEngine authShareEngine:GME_Third_App_Type_QQ]
    shareWithContent:shareContent
            objetType:GME_Share_Object_Type_Url
                scene:GME_Share_Scene_QQSession
    SuccessCallBack:^(GMFAuthShareResult *result)
    {
        
    }
     failCallBack:^(GMFAuthShareResult *result) {
        
    }];
}

- (IBAction)weiXinLogin:(id)sender {
    [[GMAuthShareEngine authShareEngine:GME_Third_App_Type_WeChat]
     authWithSuccessCallBack:^(GMFAuthShareResult *result)
     {
         
     }
     failCallBack:^(GMFAuthShareResult *result) {
         
     }];
}
- (IBAction)weiXinShare:(id)sender {
    GMMShareModel *shareContent = [self buildShareContent];
    [[GMAuthShareEngine authShareEngine:GME_Third_App_Type_WeChat]
     shareWithContent:shareContent
     objetType:GME_Share_Object_Type_Url
     scene:GME_Share_Scene_WeChatSession
     SuccessCallBack:^(GMFAuthShareResult *result)
     {
         
     }
     failCallBack:^(GMFAuthShareResult *result) {
         
     }];
}
- (IBAction)sinaLogin:(id)sender {
    
    [[GMAuthShareEngine authShareEngine:GME_Third_App_Type_WeiBo]
     authWithSuccessCallBack:^(GMFAuthShareResult *result)
     {
         
     }
     failCallBack:^(GMFAuthShareResult *result) {
         
     }];
    
}
- (IBAction)sinaShare:(id)sender {
    GMMShareModel *shareContent = [self buildShareContent];
    [[GMAuthShareEngine authShareEngine:GME_Third_App_Type_WeiBo]
     shareWithContent:shareContent
     objetType:GME_Share_Object_Type_Url
     scene:GME_Share_Scene_Sina_WeiBo
     SuccessCallBack:^(GMFAuthShareResult *result)
     {
         
     }
     failCallBack:^(GMFAuthShareResult *result) {
         
     }];
}
- (IBAction)apShare:(id)sender {
    GMMShareModel *shareContent = [self buildShareContent];
    [[GMAuthShareEngine authShareEngine:GME_Third_App_Type_AP_Friend]
     shareWithContent:shareContent
     objetType:GME_Share_Object_Type_Url
     scene:GME_Share_Scene_AP_Friend
     SuccessCallBack:^(GMFAuthShareResult *result)
     {
         
     }
     failCallBack:^(GMFAuthShareResult *result) {
         
     }];
}
-(GMMShareModel *) buildShareContent
{
    GMMShareModel *shareModel = [[GMMShareModel alloc] init];
    shareModel.strTitle =@"分享的例子";
    shareModel.strPlaceHolder =@"我在 @ShareDemo 发现了一个分享的例子 ";
    shareModel.strShareUrl =@"http://jianli2017.github.io/LJBlog/";
    NSArray *aryImage = [NSArray arrayWithObject:@"http://jianli2017.github.io/LJBlog/images/2016-02-16-1.png"];
    shareModel.aryThumbImgUrlSet =aryImage;
    
    return shareModel;
}
@end
