//
//  HZLBulletView.h
//  Day4-05-BeatPlane
//
//  Created by 黄梓伦 on 2/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZLBulletView : UIImageView

//子弹是否在屏幕上
@property (nonatomic,assign) BOOL isOnScreen;

//子弹速度
@property (nonatomic,assign) int speed;
@end
