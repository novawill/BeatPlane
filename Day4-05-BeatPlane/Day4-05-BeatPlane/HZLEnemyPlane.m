//
//  HZLEnemyPlane.m
//  Day4-05-BeatPlane
//
//  Created by 黄梓伦 on 2/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLEnemyPlane.h"

@implementation HZLEnemyPlane

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //创建动画数组
        NSMutableArray *images = [[NSMutableArray alloc] init];
        
        for (int i = 1; i < 4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"baoza1_%d",i]];
            
            [images addObject:image];
        }
        
        //给每一个敌机创建了对应得爆炸动画图片
        self.animationImages = images;
        self.animationDuration = 0.5f;
        self.animationRepeatCount = 1;
        
    }
    return self;
    
    
}
-(void)bombing{
    
    [self startAnimating];
   
    [self performSelector:@selector(endBombing) withObject:self afterDelay:0.4];
    
}
-(void)endBombing
{
    [self removeFromSuperview];
    self.isOnScreen = NO;
}

@end
