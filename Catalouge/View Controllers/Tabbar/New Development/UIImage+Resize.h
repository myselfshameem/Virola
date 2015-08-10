//
//  UIImage+Resize.h
//  Catalouge
//
//  Created by Shameem Ahamad on 8/4/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

+ (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)size;

+ (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)size
               cornerRadius:(CGFloat)cornerRadius;
@end

