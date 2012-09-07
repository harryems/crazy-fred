//
//  GameLayer.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "SimpleAudioEngine.h"
#import "GameLayer.h"
#import "MusicLayer.h"


@implementation GameLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];

	
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
        
        medidorLayer= [CCLayer node];
        backGroundLayer= [CCLayer node];
        instrumentosLayer= [CCLayer node];
        

        [self addChild:medidorLayer];
        [self addChild:backGroundLayer];
        [self addChild:instrumentosLayer];
        
        [self BuildBackground];
        [self BuildInstrumentos];

        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
	return self;
}

-(void) BuildBackground
{

    CGSize winSize = [[CCDirector sharedDirector] winSize];
    background = [CCSprite spriteWithFile:@"juego-bg.png"];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [backGroundLayer addChild:background]; // añadimos el sprite a la capa l1

}

-(void) BuildInstrumentos
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenuItemImage *ba1 = [CCMenuItemImage itemFromNormalImage:@"ba1.png" selectedImage:@"be1.png" target:self selector:@selector(touchButton:)];
    CCMenuItemImage *ba2 = [CCMenuItemImage itemFromNormalImage:@"ba2.png"  selectedImage:@"be2.png" target:self selector:@selector(touchButton:)];
    CCMenuItemImage *ba3 = [CCMenuItemImage itemFromNormalImage:@"ba3.png"  selectedImage:@"be3.png" target:self selector:@selector(touchButton:)];
    CCMenuItemImage *ba4 = [CCMenuItemImage itemFromNormalImage:@"ba4.png" selectedImage:@"be4.png" target:self selector:@selector(touchButton:)];
    CCMenuItemImage *ba5 = [CCMenuItemImage itemFromNormalImage:@"ba5.png"  selectedImage:@"be5.png" target:self selector:@selector(touchButton:)];
    CCMenuItemImage *ba6 = [CCMenuItemImage itemFromNormalImage:@"ba6.png"  selectedImage:@"be6.png" target:self selector:@selector(touchButton:)];
    CCMenuItemImage *ba7 = [CCMenuItemImage itemFromNormalImage:@"ba7.png" selectedImage:@"be7.png" target:self selector:@selector(touchButton:)];
    CCMenuItemImage *ba8 = [CCMenuItemImage itemFromNormalImage:@"ba8.png"  selectedImage:@"be8.png" target:self selector:@selector(touchButton:)];
    CCMenuItemImage *ba9 = [CCMenuItemImage itemFromNormalImage:@"ba9.png"  selectedImage:@"be9.png" target:self selector:@selector(touchButton:)];
    
    CCMenu *Instrumentos = [CCMenu menuWithItems:ba1,ba2,ba3,ba4,ba5,ba6,ba7,ba8,ba9, nil];
    
    [Instrumentos  alignItemsInColumns:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3],[NSNumber numberWithInt:3], nil];
    Instrumentos.position =CGPointMake(size.width / 2, size.height / 2);
    
    Instrumentos.scale=0.95;
    //CCMenu *row1 = [CCMenu menuWithItems:ba1,nil];
    
    //[row1 alignItemsHorizontallyWithPadding:1];
    [instrumentosLayer addChild:Instrumentos];

}

- (void) touchButton: (CCMenuItem  *) menuItem
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
