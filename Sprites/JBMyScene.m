//
//  JBMyScene.m
//  Sprites
//
//  Created by jbrooks on 7/12/14.
//  Copyright (c) 2014 Jon Brooks. All rights reserved.
//

#import "JBMyScene.h"
#import "JBBallNode.h"

@interface JBMyScene () <SKPhysicsContactDelegate>

@property (nonatomic) BOOL strokeBegan;
@property (nonatomic) CGPoint mouseDownLoc;
@property (nonatomic, strong) SKNode *table;
@property (nonatomic, strong) JBBallNode *cueBall;
@end

@implementation JBMyScene

- (void)createRack {
    CGPoint footSpot = CGPointMake(200, 0);
    CGFloat ballRadius = [JBBallNode ballRadius];
    CGFloat rowStart = footSpot.x;
    CGFloat colStart = footSpot.y;
    
    for (NSUInteger i = 0; i < 5; ++i) {
        for (NSUInteger j = 0; j <= i; ++j) {
            JBBallNode *ball = [JBBallNode getNextBall];
            ball.position = CGPointMake(rowStart, colStart + (j*ballRadius*2));
            [self.table addChild:ball];
        }
        rowStart += (ballRadius * sqrt(3));
        colStart -= ballRadius;
    }
    
    self.cueBall = [JBBallNode cueBall];
    self.cueBall.position = CGPointMake(-200, 0);
    [self.table addChild:self.cueBall];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0,0);
        
        _table = [SKSpriteNode spriteNodeWithImageNamed:@"pool_table"];
        _table.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame));
        [self addChild:_table];
        const CGFloat kHorizBumperSize = 75.0;
        const CGFloat kVerticalBumperSize = 65.0;
        
        CGRect borders = CGRectInset(_table.frame, kVerticalBumperSize, kHorizBumperSize);
//        CGFloat ballRadius = [JBBallNode ballRadius];
//        CGFloat pocketWidth = ballRadius * 4;
//        CGSize pocketSize = CGSizeMake(pocketWidth, pocketWidth);

        
        //create edges for the balls to bounce off of
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:borders];
//
//        //Create pockets:
//        //These are invisible bodies that just track the collision for the purpose of sinking balls
//        SKNode *blPocket = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:pocketSize];
//        blPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pocketSize];
//        blPocket.physicsBody.contactTestBitMask = kBallCategoryMask;
//        blPocket.position = CGPointMake(CGRectGetMinX(borders), CGRectGetMinY(borders));
//        blPocket.zRotation = M_PI_4;
//
//        [self addChild:blPocket];
//
//        SKNode *tlPocket = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:pocketSize];
//        tlPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pocketSize];
//        tlPocket.physicsBody.contactTestBitMask = kBallCategoryMask;
//        tlPocket.position = CGPointMake(CGRectGetMinX(borders), CGRectGetMaxY(borders));
//        tlPocket.zRotation = M_PI_4;
//        [self addChild:tlPocket];
//
//        SKNode *brPocket = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:pocketSize];
//        brPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pocketSize];
//        brPocket.physicsBody.contactTestBitMask = kBallCategoryMask;
//        brPocket.position = CGPointMake(CGRectGetMaxX(borders), CGRectGetMinY(borders));
//        brPocket.zRotation = M_PI_4;
//        [self addChild:brPocket];
//
//        SKNode *trPocket = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:pocketSize];
//        trPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pocketSize];
//        trPocket.physicsBody.contactTestBitMask = kBallCategoryMask;
//        trPocket.position = CGPointMake(CGRectGetMaxX(borders), CGRectGetMaxY(borders));
//        trPocket.zRotation = M_PI_4;
//        [self addChild:trPocket];
//
//        SKNode *blPocket = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:pocketSize];
//        blPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pocketSize];
//        blPocket.zRotation = M_PI_4;
//        blPocket.physicsBody.contactTestBitMask = kBallCategoryMask;
//        blPocket.position = borders.origin;
//        [self addChild:blPocket];
//
//        SKNode *blPocket = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:pocketSize];
//        blPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pocketSize];
//        blPocket.zRotation = M_PI_4;
//        blPocket.physicsBody.contactTestBitMask = kBallCategoryMask;
//        blPocket.position = borders.origin;
//        [self addChild:blPocket];
//
        
        self.physicsWorld.contactDelegate = self;
        
        [self createRack];
    }
    return self;
}

-(void)mouseUp:(NSEvent *)theEvent {
    if (self.strokeBegan) {
    CGPoint location = [theEvent locationInNode:_table];
    const CGFloat kMultiplier = 10.0;

    CGVector vector = CGVectorMake(_mouseDownLoc.x-location.x , _mouseDownLoc.y-location.y);
    vector.dx *=kMultiplier;
    vector.dy *=kMultiplier;

    self.cueBall.physicsBody.velocity = vector;
    self.strokeBegan = NO;
    }
}

-(void)mouseDown:(NSEvent *)theEvent {
    
    if ([self.cueBall containsPoint:[theEvent locationInNode:self.table]]) {
        self.strokeBegan = YES;
        self.cueBall.physicsBody.velocity = CGVectorMake(0.0, 0.0);
        self.mouseDownLoc = [theEvent locationInNode:self.table];
    }

}

#pragma mark SKPhysicsContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    SKNode *bodyA = contact.bodyA.node;
    SKNode *bodyB = contact.bodyB.node;
    
    NSLog(@"Here we are with %@, %@", bodyA, bodyB);
}


@end
