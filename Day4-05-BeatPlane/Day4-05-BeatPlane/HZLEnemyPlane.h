//
//  HZLEnemyPlane.h
//  Day4-05-BeatPlane
//
//  Created by 黄梓伦 on 2/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZLEnemyPlane : UIImageView
//是否在屏幕上
@property (nonatomic,assign) BOOL isOnScreen;

//移动速度
@property (nonatomic,assign) int speed;

//生命值
@property (nonatomic,assign) int liveCount;
-(void)bombing;
@end
