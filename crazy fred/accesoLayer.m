//
//  accesoLayer.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "accesoLayer.h"


@implementation accesoLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	accesoLayer *layer = [accesoLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
            
        CCSprite *background = [CCSprite spriteWithFile:@"registro.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background];
        
        
        CCSprite *spriteCortinasAbren = [CCSprite spriteWithFile:@"1.png"];
        [spriteCortinasAbren setPosition:CGPointMake(size.width / 2, size.height / 2)];
        [self addChild:spriteCortinasAbren];
        
        CCAnimation *animationCortinasAbren = [CCAnimation animation];
        [animationCortinasAbren addFrameWithFilename:@"2.png"];
        [animationCortinasAbren addFrameWithFilename:@"3.png"];
        [animationCortinasAbren addFrameWithFilename:@"4.png"];
        [animationCortinasAbren addFrameWithFilename:@"5.png"];
        [animationCortinasAbren addFrameWithFilename:@"6.png"];
        [animationCortinasAbren addFrameWithFilename:@"7.png"];
        [animationCortinasAbren addFrameWithFilename:@"8.png"];
        [animationCortinasAbren addFrameWithFilename:@"9.png"];
        
        CCAnimate *animateCortinasAbren = [CCAnimate actionWithDuration:0.5 animation:animationCortinasAbren restoreOriginalFrame:NO];
        [spriteCortinasAbren runAction:animateCortinasAbren];
        
        
        
	}
	return self;
}




// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
