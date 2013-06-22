//
//  DragLayer.m
//  DragSprite
//
//  Created by Sacchy on 2013/06/23.
//  Copyright 2013年 Sacchy. All rights reserved.
//

#import "DragLayer.h"

@implementation DragLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DragLayer *layer = [DragLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        
        [self setTouchEnabled:YES];

        CGSize size = [[CCDirector sharedDirector] winSize];
        player = [CCSprite spriteWithFile:@"player_sanae_0.png"];
        player.position = ccp(size.width/2, size.height/2-50);

		[self addChild:player];
        [self scheduleUpdate];
	}
	return self;
}

-(void) registerWithTouchDispatcher
{
    CCDirector *director = [CCDirector sharedDirector];
    [[director touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void) update:(ccTime)delta
{
    if (Cnt % 15 == 0) {
        if (Cnt == 60) Cnt = 0;
        [player setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"player_sanae_%d.png",Cnt/15]]];
    }
    Cnt++;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
//    CCLOG(@"Begin:%lf %lf",touchLocation.x,touchLocation.y);
    return TRUE;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint newPos = ccpAdd(player.position, translation);
    player.position = newPos;
}
@end
