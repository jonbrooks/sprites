//
//  JBAppDelegate.m
//  Sprites
//
//  Created by jbrooks on 7/12/14.
//  Copyright (c) 2014 Jon Brooks. All rights reserved.
//

#import "JBAppDelegate.h"
#import "JBMyScene.h"

@implementation JBAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    SKScene *scene = [JBMyScene sceneWithSize:CGSizeMake(1024, 768)];

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];

    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
