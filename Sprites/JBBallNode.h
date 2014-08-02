//
//  JBBallNode.h
//  Sprites
//
//  Created by jbrooks on 7/12/14.
//  Copyright (c) 2014 Jon Brooks. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

extern const UInt32 kBallCategoryMask;

@interface JBBallNode : SKCropNode

+ (CGFloat)ballRadius;
+ (instancetype)cueBall;
@end

@interface JBBallNode (BallGenerator)


+ (void)resetBallGeneration;

+ (instancetype)getNextBall;

@end
