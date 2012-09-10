//
//  InitLayer.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/4/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "InitLayer.h"
#import "accesoLayer.h"
#import "GameScene.h"
#import "MusicScene.h"
#import "global.h"


// InitLayer implementation
@implementation InitLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	InitLayer *layer = [InitLayer node];
	
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
        
        
        
        CCSprite *sprinteInicio = [CCSprite spriteWithFile:@"h3.png"];
        [sprinteInicio setPosition:CGPointMake(size.width / 2, size.height / 2)];
        [self addChild:sprinteInicio];
        
        CCAnimation *animationInicio = [CCAnimation animation];
        [animationInicio addFrameWithFilename:@"h2.png"];
        [animationInicio addFrameWithFilename:@"h1.png"];

        
        CCAnimate *animat = [CCAnimate actionWithDuration:1 animation:animationInicio restoreOriginalFrame:NO];
        [sprinteInicio runAction:animat];
        
        CCMenuItemImage *New = [CCMenuItemImage itemFromNormalImage:@"btnjugar-on.png"  selectedImage:@"btnjugar-over.png" target:self selector:@selector(acceso:)];
        
        CCMenu *Menu = [CCMenu menuWithItems:New, nil];
        
        Menu.position =CGPointMake(size.width / 2, 30);
        [self addChild:Menu];


        
	}
	return self;
}


- (void) acceso: (CCMenuItem  *) menuItem
 {

    //[[CCDirector sharedDirector] replaceScene:[accesoLayer scene]];
    [[CCDirector sharedDirector] replaceScene:[MusicScene scene]];
    // [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
     
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
