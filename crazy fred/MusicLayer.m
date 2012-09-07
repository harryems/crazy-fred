//
//  MusicLayer.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "MusicLayer.h"
#import "GameLayer.h"


@implementation MusicLayer
@synthesize CountSong;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MusicLayer *layer = [MusicLayer node];
	
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
        
        CountSong=1;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        CCSprite *background = [CCSprite spriteWithFile:@"M1.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background];
        
        CCSprite *sprinteList = [CCSprite spriteWithFile:@"t1.png"];
        [sprinteList setPosition:CGPointMake(size.width / 2,size.height/2 )];
        [self addChild:sprinteList];
        
        CCAnimation *animationList = [CCAnimation animation];
        [animationList addFrameWithFilename:@"t2.png"];
        [animationList addFrameWithFilename:@"t3.png"];
        [animationList addFrameWithFilename:@"t4.png"];
        [animationList addFrameWithFilename:@"t5.png"];

        
        
        //CCAnimate *animateList = [CCAnimate actionWithDuration:0.3 animation:animationList restoreOriginalFrame:NO];
        //[sprinteList runAction:animateList];
        
        
      /*  [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"megaman.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"megaman.png"];
        [self addChild:spriteSheet];
        */
        
        
        CCMenuItemImage *Next = [CCMenuItemImage itemFromNormalImage:@"btnadelante-on.png" selectedImage:@"btnadelante-over.png" target:self selector:@selector(Next:)];
        
        CCMenuItemImage *Prev = [CCMenuItemImage itemFromNormalImage:@"btnatras-on.png" selectedImage:@"btnatras-over.png" target:self selector:@selector(Prev:)];
        
       // CCMenuItemImage *Pause = [CCMenuItemImage itemFromNormalImage:@"btnpausa-on.png" selectedImage:@"btnpausa-over.png" target:self selector:@selector(Pause:)];
        
        CCMenuItemImage *Play = [CCMenuItemImage itemFromNormalImage:@"btnplay-on.png" selectedImage:@"btnplay-over.png" target:self selector:@selector(Play:)];
        
        
        CCMenu *Reproduccion = [CCMenu menuWithItems:Play,Prev,Next,nil];
        
        [Reproduccion alignItemsHorizontally];
        Reproduccion.position =CGPointMake(size.width - 150, 30);
        
        [self addChild:Reproduccion];
        
        CCMenuItemImage *Jugar = [CCMenuItemImage itemFromNormalImage:@"btnjugar-on.png"  selectedImage:@"btnjugar-over.png" target:self selector:@selector(Jugar:)];
        
        CCMenu *JugarMenu = [CCMenu menuWithItems:Jugar, nil];
        
        JugarMenu.position =CGPointMake(200, 30);
        [self addChild:JugarMenu];
        
        

        
        
	}
	return self;
}
- (void) Next: (CCMenuItem  *) menuItem
{
    CountSong++;
    if (CountSong>4)
    {
        CountSong=1;
    }
} 
- (void) Prev: (CCMenuItem  *) menuItem
{
    CountSong--;
    if (CountSong<1)
    {
        CountSong=4;
    }
}
- (void) Play: (CCMenuItem  *) menuItem
{
    switch (CountSong) {
        case 1:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Guns.mp3"];
            break;
        case 2:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Hey girl.mp3"];
            break;
        case 3:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"red hot chilli pepper.mp3"];
            break;
        case 4:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"ac:dc.mp3"];
            break;
            
        default:
            break;
    }
    
    
}
- (void) Pause: (CCMenuItem  *) menuItem
{

}

- (void) Jugar: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
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
