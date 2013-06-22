//
//  DragLayer.h
//  DragSprite
//
//  Created by Sacchy on 2013/06/23.
//  Copyright 2013年 Sacchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DragLayer : CCLayer {
    
    int Cnt;
    CCSprite *player;
}
+(CCScene *) scene;

@end
