//
//  ViewController.m
//  Day4-05-BeatPlane
//
//  Created by 黄梓伦 on 2/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "ViewController.h"
#define ScreenW (int)[UIScreen mainScreen].bounds.size.width
#define ScreenH (int)[UIScreen mainScreen].bounds.size.height
#import "HZLPlaneView.h"
#import "HZLBulletView.h"
#import "HZLEnemyPlane.h"
#define Enemy_tag 200
@interface ViewController ()
{
    //玩家
    HZLPlaneView *_player;
    NSTimer *_timer;

}
@property (nonatomic,strong) NSMutableArray *enemyPlaneArray;
@end

@implementation ViewController

-(NSMutableArray *)enemyPlaneArray
{
    if(_enemyPlaneArray == nil)
    {
        _enemyPlaneArray = [[NSMutableArray alloc] init];
        
        //创建敌机
        for (int i = 0; i< 10;i++) {
            
            //创建敌机对象
            HZLEnemyPlane *enemyPlane = [[HZLEnemyPlane alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            
            //设置图片
            enemyPlane.image = [UIImage imageNamed:@"diji"];
            
            //设置状态
            enemyPlane.isOnScreen = NO;
            enemyPlane.speed = 2;
            
            //设置Tag值
            enemyPlane.tag = Enemy_tag;
            
            //添加到数组
            [_enemyPlaneArray addObject:enemyPlane];
            
        }
    }
    return _enemyPlaneArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建界面
    [self creatUI];

    //启动定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
}
#pragma mark ---CreatUI-----
-(void)creatUI
{
    //=====背景图=====
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"bg_02.jpg"];
    [self.view addSubview:background];
    
    
    //======创建玩家=====
    _player = [[HZLPlaneView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _player.center = CGPointMake(ScreenW/2.0f, ScreenH -180);
    //设置图片
    _player.image = [UIImage imageNamed:@"feiji"];
    
    //设置初始状态
    _player.isMoving = NO;
    //设置速度
    _player.speed = 3;
    [self.view addSubview:_player];
    
    //======按钮========
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    leftButton.center = CGPointMake(ScreenW/4.0f, ScreenH - 60);
    //设置图片
    [leftButton setImage:[UIImage imageNamed:@"button_left.png"] forState:UIControlStateNormal];
    //添加按下事件
    [leftButton addTarget:self action:@selector(planeStartMove:) forControlEvents:UIControlEventTouchDown];
    //添加弹起事件
    [leftButton addTarget:self action:@selector(planeEndMove:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leftButton];
    //添加tag值
    leftButton.tag = Left;
    
    //右按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    rightButton.center = CGPointMake(3*ScreenW/4.0f, ScreenH - 60);
    //设置图片
    [rightButton setImage:[UIImage imageNamed:@"button_right.png"] forState:UIControlStateNormal];
    //添加按下事件
    [rightButton addTarget:self action:@selector(planeStartMove:) forControlEvents:UIControlEventTouchDown];
    //添加弹起事件
    [rightButton addTarget:self action:@selector(planeEndMove:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightButton];
    //设置tag值
    rightButton.tag = Right;

}

#pragma mark ---按钮点击---
-(void)planeStartMove:(UIButton *)button
{
    //让玩家移动
    _player.isMoving = YES;
    //设置方向
    _player.direction = button.tag;
    
}
#pragma  mark ---弹起按钮---
-(void)planeEndMove:(UIButton *)button
{
    //让玩家停止移动
    _player.isMoving = NO;
    
}
#pragma mark ----gameLoop----
-(void)gameLoop
{
    static long time = 0;
    time++;
    //让玩家移动
    [self playerMove];
    
    //发射子弹
    //每一秒发射一次
    if(time % 5 == 0){
    [_player shootBullet:self.view];

    }
    [self bulletFly];
    
    //敌机出现
    if(time % 10 == 0)
    {
    [self creatEnemy];
    }
    
    //敌机进攻
    [self enemyAttack];
}
#pragma mark ---EnemyAttack---
-(void)enemyAttack
{
    NSArray *subviews = [self.view subviews];
    for (UIView *subview in subviews) {
        
        //拿到敌机
        
        if(subview.tag == Enemy_tag)
        {
            HZLEnemyPlane *enemyPlane = (HZLEnemyPlane *)subview;
            
            //改变y坐标
            CGRect rect  = enemyPlane.frame;
            rect.origin.y += enemyPlane.speed;
            
            //更新位置
            enemyPlane.frame =rect;
            
            //判断和子弹相撞
            //遍历所有的子弹
            for (UIView *subview2 in subviews) {
                if (subview2.tag == Bullet_tag) {
                    //找到子弹
                    
                    HZLBulletView *bullet = (HZLBulletView *)subview2;
                    //判断子弹和敌机是否有交集
                    if (CGRectIntersectsRect(enemyPlane.frame, bullet.frame)) {
                        
                        //子弹打中敌机
                        [enemyPlane bombing];
//                        [enemyPlane removeFromSuperview];
//                        enemyPlane.isOnScreen = NO;
                        [bullet removeFromSuperview];
                        bullet.isOnScreen = NO;
                        //找到一个打中敌机的子弹就行
                        break;
                    }
                }
            }
            
            if (rect.origin.y + rect.size.height> ScreenH ) {
                [enemyPlane removeFromSuperview];
                enemyPlane.isOnScreen = NO;
            }

        }
    }
}
#pragma mark ---creatEnemy---
-(void)creatEnemy
{
    //在敌机数组中找到一个不再屏幕上的敌机，显示在屏幕上
    
    for (HZLEnemyPlane *enemyPlane in self.enemyPlaneArray) {
        if (!enemyPlane.isOnScreen) {
            
            //x: 0 ~ 屏宽-敌机宽度
            enemyPlane.frame = CGRectMake(arc4random() % (ScreenW - (int)enemyPlane.frame.size.width/2), 0, enemyPlane.frame.size.width, enemyPlane.frame.size.height);
            
            //显示在屏幕上
            [self.view addSubview:enemyPlane];
            
            //改变状态
            enemyPlane.isOnScreen = YES;
            
            //找到一个就行
            break;
            
        }
    }
}
#pragma  mark ---playerMove---
-(void)playerMove
{
    //判断玩家是否可以移动
    if (_player.isMoving) {
        CGRect rect = _player.frame;
        //向左移动
        if (_player.direction == Left) {
            
            rect.origin.x -= _player.speed;
            
            
        //向右移动
        }else{
            
            rect.origin.x += _player.speed;
        }
        //边界判断
        if (!(rect.origin.x <= 0 || rect.origin.x +rect.size.width>= ScreenW)) {
            //更新位置
            _player.frame =rect;
           
        }
        
        
    }
}
#pragma mark --让子弹飞---
-(void)bulletFly
{
    //拿到屏幕上所有的子弹
    NSArray *subViews = [self.view subviews];
    for (UIView *subview in subViews) {
        if (subview.tag == Bullet_tag) {
            //拿到子弹
            HZLBulletView *bullet = (HZLBulletView *)subview;
            
            //改变子弹的y坐标
            
            CGRect rect = bullet.frame;
            
            rect.origin.y -= bullet.speed;
            
            //刷新坐标
            
            bullet.frame = rect;
            
            //判断子弹是否飞出屏幕
            
            if (rect.origin.y+rect.size.height < 0) {
                [bullet removeFromSuperview];
                bullet.isOnScreen = NO;
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
