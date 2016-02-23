//
//  UIImage+Common.h
//  Pods
//
//  Created by l 15/4/27.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

/**
 *  按指定大小缩放图像
 *
 *  @param area 指定需要缩放的大小
 *
 *  @return 返回缩放后的图像
 */
- (UIImage*)resizeInArea:(CGSize) area;

@end
