//
//  InitLayer.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/4/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "InitLayer.h"
#import "MusicScene.h"


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
        
        
        size = [[CCDirector sharedDirector] winSize];
        controlsLayer= [CCLayer node];
        cortinasLayer= [CCLayer node];
        backGroundLayer= [CCLayer node];
        luzLayer= [CCLayer node];

        [self addChild:backGroundLayer];
        [self addChild:controlsLayer];
        [self addChild:luzLayer];
        [self addChild:cortinasLayer];


        
        [self BuildBackground];
        [self BuilLuz];

        [self BuildControls];


        
	}
	return self;
}

-(void) BuilLuz
{
    
    

    CCAnimation *animationInicio = [CCAnimation animation];
    [animationInicio addFrameWithFilename:@"p3.png"];
    [animationInicio addFrameWithFilename:@"p2.png"];
    [animationInicio addFrameWithFilename:@"p1.png"];
    CCAnimate *animateLuz = [CCAnimate actionWithDuration:2 animation:animationInicio restoreOriginalFrame:NO];
    [spriteLuz runAction:animateLuz];
    
    
}

-(void) BuildBackground
{
    
    background = [CCSprite spriteWithFile:@"M1.png"];
    background.position = ccp(size.width/2, size.height/2);
    [backGroundLayer addChild:background]; // añadimos el sprite a la capa l1
    
    
    spriteLuz = [CCSprite spriteWithFile:@"p3.png"];
    [spriteLuz setPosition:CGPointMake(size.width / 2, size.height / 2)];
    [luzLayer addChild:spriteLuz];
    
    
    CCSprite *cortina = [CCSprite spriteWithFile:@"1.png" ];
    cortina.position = ccp(size.width/2,size.height*2);
    [cortinasLayer addChild:cortina];
}


-(void) BuildControls
{
    CCMenuItemImage *New = [CCMenuItemImage itemFromNormalImage:@"btnjugar-on.png"  selectedImage:@"btnjugar-over.png" target:self selector:@selector(acceso:)];
    
    CCMenu *Menu = [CCMenu menuWithItems:New, nil];
    
    Menu.position =CGPointMake(size.width / 2, 30);
    [controlsLayer addChild:Menu];
}



- (void) acceso: (CCMenuItem  *) menuItem
{
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,-size.height-(size.height/2))
                     ];
    id done=[CCCallFunc actionWithTarget:self selector:@selector(Replace)];
    [cortinasLayer runAction:[CCSequence actions:actionMove,done ,nil]];
}

-(void) Replace
{
    
    [[CCDirector sharedDirector] replaceScene:[MusicScene scene]];
    
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
