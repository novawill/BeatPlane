//
//  HZLPlaneView.m
//  Day4-05-BeatPlane
//
//  Created by 黄梓伦 on 2/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLPlaneView.h"
#import "HZLBulletView.h"

@interface HZLPlaneView()

//创建一个数组，专门用来存储所有的子弹

@property (nonatomic,strong)NSMutableArray *bulletArray;



@end
@implementation HZLPlaneView


-(NSMutableArray *)bulletArray
{
    if(_bulletArray == nil)
    {
        _bulletArray = [[NSMutableArray alloc] init];
        
  
        
        //创建50个子弹
        for (int i = 0; i <50; i++) {
            HZLBulletView *bullet = [[HZLBulletView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            bullet.image = [UIImage imageNamed:@"zidan2.png"];
            
            //设置初始化状态
            bullet.isOnScreen = NO;
            
            //设置初始化速度
            
            bullet.speed = 30;
            
            //设置子弹的tag值
            
            bullet.tag = Bullet_tag;
            
            //添加子弹到数组中
            [_bulletArray addObject:bullet];
        }
    }
    
    return _bulletArray;
}


//发射子弹
-(void)shootBullet:(UIView *)place
{
    //遍历数组,找到一个不再屏幕上的子弹。发射出去
    for (HZLBulletView *bullet in self.bulletArray) {
        if (!bullet.isOnScreen) {
            
            //将子弹显示在指定的位置
            bullet.center = CGPointMake(self.center.x+5, self.center.y - self.frame.size.height/2-10);
            
            //放在屏幕上
            
            [place addSubview:bullet];
            
            //改变子弹状态为YES
            
            bullet.isOnScreen = YES;
            
           
            //拿到一个就行
            
            break;
        }
    }
    
}

@end
