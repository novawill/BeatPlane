//
//  HZLPlaneView.h
//  Day4-05-BeatPlane
//
//  Created by 黄梓伦 on 2/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

//子弹Tag值
#define  Bullet_tag 100
//玩家移动方向的枚举
typedef enum : NSUInteger{
    Left = 1,
    Right,
} PlayerDirection;
@interface HZLPlaneView : UIImageView
//添加属性 是否正在移动
@property (nonatomic, assign) BOOL isMoving;

//移动速度
@property (nonatomic,assign) int speed;



//移动方向
@property (nonatomic,assign)PlayerDirection direction;

//发射子弹
-(void)shootBullet:(UIView *)place;
@end
