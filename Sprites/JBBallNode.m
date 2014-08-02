//
//  JBBallNode.m
//  Sprites
//
//  Created by jbrooks on 7/12/14.
//  Copyright (c) 2014 Jon Brooks. All rights reserved.
//

#import "JBBallNode.h"

const UInt32 kBallCategoryMask = 1;


static const CGFloat kBallRadius = 18.0;
static const CGFloat kFontSize = 16.0;
static const CGFloat kNumCircleRadius = 7.0;

@interface JBBallNode ()

@property (nonatomic, weak) SKLabelNode *label;

@end

@implementation JBBallNode



- (id) initWithColor:(SKColor *)color isStripe:(BOOL)isStripe {
    
    self = [super init];
    
    if (self) {
        CGSize ballSize = CGSizeMake(kBallRadius * 2, kBallRadius * 2);

        SKColor *ballColor;
        
        if (isStripe) {
            ballColor = [SKColor whiteColor];
        } else {
            ballColor = color;
        }
        
        SKSpriteNode *ballColorSprite = [SKSpriteNode spriteNodeWithColor:ballColor size:ballSize];
        ballColorSprite.position = self.position;
        [self addChild:ballColorSprite];
        
        self.maskNode = [JBBallNode ballMaskNode];
        
        //The parent to add the label and its circle depends on whether this is a striped ball or not
        SKNode *labelParent;
        
        if (isStripe) {

            SKSpriteNode *stripe = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(ballSize.width, ballSize.height/2.0)];
            
            stripe.position = self.position;
            [self addChild:stripe];

            labelParent = stripe;
        } else {
            labelParent = self;
        }
        
        
//        SKSpriteNode *numCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle"];
//        
//        numCircle.scale = (kNumCircleRadius * 2) / numCircle.frame.size.width;
//        numCircle.blendMode = SKBlendModeReplace;
//        numCircle.colorBlendFactor = 2.0;
//        numCircle.color = [SKColor whiteColor];

        
        SKShapeNode *numCircle = [SKShapeNode node];
        numCircle.path = CGPathCreateWithRoundedRect(CGRectMake(-kNumCircleRadius, -kNumCircleRadius, kNumCircleRadius*2, kNumCircleRadius*2), kNumCircleRadius, kNumCircleRadius, NULL);
        numCircle.position = labelParent.position;
        numCircle.fillColor = [SKColor whiteColor];
        [labelParent addChild:numCircle];

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter"];

        label.fontSize = kFontSize;
        label.fontColor = [SKColor blackColor];
        label.position = labelParent.position;
        [label setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
        [label setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
        [numCircle addChild:label];
        self.label = label;
        
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:kBallRadius];
        self.physicsBody.restitution = 1.0;
        self.physicsBody.linearDamping = 0.6;
        self.physicsBody.angularDamping = 0.2;
        self.physicsBody.categoryBitMask = kBallCategoryMask;
    }
    
    return self;
}

+ (SKSpriteNode *)ballMaskNode {
    static SKSpriteNode *theMask;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        CGFloat ballWidth = kBallRadius * 2;
        theMask = [SKSpriteNode spriteNodeWithImageNamed:@"circle"];
        theMask.scale = ballWidth / theMask.frame.size.width;
    });
    
    return theMask;
}


+ (CGFloat) ballRadius {
    return kBallRadius;
}

+ (instancetype)cueBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor whiteColor] isStripe:NO];
    [ret.label removeFromParent];
    return ret;
    
}

+ (instancetype) oneBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor yellowColor] isStripe:NO];
    ret.label.text = @"1";
    return ret;
}

+ (instancetype) twoBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor redColor] isStripe:NO];
    ret.label.text = @"2";
    return ret;
}

+ (instancetype) threeBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor blueColor] isStripe:NO];
    ret.label.text = @"3";
    return ret;
}

+ (instancetype) fourBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor purpleColor] isStripe:NO];
    ret.label.text = @"4";
    return ret;
}

+ (instancetype) fiveBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor orangeColor] isStripe:NO];
    ret.label.text = @"5";
    return ret;
}

+ (instancetype) sixBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor greenColor] isStripe:NO];
    ret.label.text = @"6";
    return ret;
}

+ (instancetype) sevenBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor magentaColor] isStripe:NO];
    ret.label.text = @"7";
    return ret;
}

+ (instancetype) eightBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor blackColor] isStripe:NO];
    ret.label.text = @"8";
    return ret;
}

+ (instancetype) nineBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor yellowColor] isStripe:YES];
    ret.label.text = @"9";
    return ret;
}

+ (instancetype) tenBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor blueColor] isStripe:YES];
    ret.label.text = @"10";
    return ret;
}

+ (instancetype) elevenBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor redColor] isStripe:YES];
    ret.label.text = @"11";
    return ret;
}

+ (instancetype) twelveBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor purpleColor] isStripe:YES];
    ret.label.text = @"12";
    return ret;
}

+ (instancetype) thirteenBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor orangeColor] isStripe:YES];
    ret.label.text = @"13";
    return ret;
}

+ (instancetype) fourteenBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor greenColor] isStripe:YES];
    ret.label.text = @"14";
    return ret;
}

+ (instancetype) fifteenBall {
    JBBallNode *ret = [[JBBallNode alloc] initWithColor:[SKColor magentaColor] isStripe:YES];
    ret.label.text = @"15";
    return ret;
}

@end



@implementation JBBallNode (BallGenerator)

static NSMutableArray *ballsArray;
static NSUInteger currentIndex;

+ (void)onceOnlyInitialization {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        ballsArray = [NSMutableArray arrayWithCapacity:15];
        [ballsArray addObject:[JBBallNode oneBall]];
        [ballsArray addObject:[JBBallNode twoBall]];
        [ballsArray addObject:[JBBallNode threeBall]];
        [ballsArray addObject:[JBBallNode fourBall]];
        [ballsArray addObject:[JBBallNode fiveBall]];
        [ballsArray addObject:[JBBallNode sixBall]];
        [ballsArray addObject:[JBBallNode sevenBall]];
        [ballsArray addObject:[JBBallNode eightBall]];
        [ballsArray addObject:[JBBallNode nineBall]];
        [ballsArray addObject:[JBBallNode tenBall]];
        [ballsArray addObject:[JBBallNode elevenBall]];
        [ballsArray addObject:[JBBallNode twelveBall]];
        [ballsArray addObject:[JBBallNode thirteenBall]];
        [ballsArray addObject:[JBBallNode fourteenBall]];
        [ballsArray addObject:[JBBallNode fifteenBall]];

        [self resetBallGeneration];
    });
}

+ (void)resetBallGeneration {
    currentIndex = 0;
    
    NSUInteger count = [ballsArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((UInt32)remainingCount);
        [ballsArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

+ (instancetype)getNextBall {
    [self onceOnlyInitialization];
    
    if (currentIndex >= ballsArray.count) {
        return nil;
    }
    
    return ballsArray[currentIndex++];
}



@end


