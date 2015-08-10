@implementation UIImage (Resize)

+ (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)size
               cornerRadius:(CGFloat)cornerRadius
{
    UIGraphicsBeginImageContext(size);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    [image drawInRect:rect];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end