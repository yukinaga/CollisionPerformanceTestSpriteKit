//
//  GameScene.m
//  SKPerformanceTest
//
//  Created by Yukinaga Azuma on 2015/01/03.
//  Copyright (c) 2015年 Yukinaga Azuma. All rights reserved.
//

#import "GameScene.h"

@interface GameScene () <SKPhysicsContactDelegate>
{
    int count;
}
@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    count = 0;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.contactDelegate = self;
}

-(void)createBall{
    CGFloat radius = 5;
    float angle = (arc4random() % UINT32_MAX)*2*M_PI;
    float speed = 60.0;
    CGFloat velocityX = speed * cosf(angle);
    CGFloat velocityY = speed * sinf(angle);

    SKShapeNode *ball = [SKShapeNode node];
    ball.name = @"ball";
    ball.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) );
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 0, 0, radius, 0, M_PI * 2, YES);
    ball.path = path;
    ball.fillColor = [SKColor orangeColor];
    ball.strokeColor = [SKColor clearColor];
    
    CGPathRelease(path);
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    ball.physicsBody.affectedByGravity = NO;
    ball.physicsBody.velocity = CGVectorMake(velocityX, velocityY);
    ball.physicsBody.restitution = 1.0f;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.friction = 0;
    ball.physicsBody.usesPreciseCollisionDetection = NO;
    ball.physicsBody.allowsRotation = NO;
    
    [self addChild:ball];
}

-(void)update:(CFTimeInterval)currentTime {
    //100回のボールが出現
    if (count < 100) {
        [self createBall];
        count++;
    }
}

@end
