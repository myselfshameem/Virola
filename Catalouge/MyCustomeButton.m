//
//  MyCustomeButton.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/23/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "MyCustomeButton.h"

@implementation MyCustomeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [[touches allObjects] lastObject];
    BeganPoint = [touch locationInView:self.superview];
    NSLog(@"touchesBegan");

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [[touches allObjects] lastObject];
    currentPoint = [touch locationInView:self.superview];
    float diff = currentPoint.x-BeganPoint.x;
    
    NSLog(@"touchesMoved X = %f",currentPoint.x);
    CGRect frame = self.superview.frame;

    float expectedOrigin = frame.origin.x + (currentPoint.x-BeganPoint.x);
    
    
    if (expectedOrigin <= 0) {
        frame.origin.x += (currentPoint.x-BeganPoint.x);
        [[self superview] setFrame:frame];
    }
    

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    
    
    UITouch *touch = [[touches allObjects] lastObject];
    currentPoint = [touch locationInView:self.window];
    float diff = currentPoint.x-BeganPoint.x;
    
    __block CGRect frame = self.superview.frame;

    if (diff < 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            frame.origin.x = -200;
            [[self superview] setFrame:frame];

        } completion:^(BOOL finished) {
            

        }];
    }

    
    NSLog(@"touchesEnded");

}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{

    NSLog(@"touchesCancelled");

}

@end
