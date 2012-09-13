//
//  MusicScene.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "MusicScene.h"
#import "GameScene.h"
#import "global.h"

bool isplaying;
bool wasPaused;

@implementation MusicScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MusicScene *layer = [MusicScene node];
	
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
        isplaying=FALSE;
        gCurrentSong=0;
        discLayer= [CCLayer node];
        backGroundLayer= [CCLayer node];
        controlsLayer= [CCLayer node];
        cortinasLayer= [CCLayer node];
        titleLayer= [CCLayer node];
        pauseLayer=[CCLayer node];

        

        [self addChild:backGroundLayer];
        [self addChild:discLayer];
        [self addChild:controlsLayer];
        [self addChild:pauseLayer];
        [self addChild:titleLayer];
        [self addChild:cortinasLayer];

        
        pauseLayer.visible=FALSE;
        [self BuildBackground];
        [self BuildControls];
        [self BuildPause];
        
        [self gAbreCortinas];
      
      

        
        
	}
	return self;
}


-(void) Replace
{
    
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
    
}

-(void) discIn

{
     
    //[discSprite prepareAnimationNamed:@"DiscoIn" fromSHScene:@"DiscIn"];
    


}

-(void) BuildPause
{
    CCMenuItemImage *Pas = [CCMenuItemImage itemFromNormalImage:@"btnpausa-on.png" selectedImage:@"btnpausa-over.png" target:self selector:@selector(Pause:)];
    
    
    
    CCMenu *menuPausa = [CCMenu menuWithItems:Pas,nil];

    menuPausa.position =CGPointMake(810, 30);
    
    [pauseLayer addChild:menuPausa];
    

}


-(void) BuildControls
{
    CCMenuItemImage *btnNext = [CCMenuItemImage itemFromNormalImage:@"btnadelante-on.png" selectedImage:@"btnadelante-over.png" target:self selector:@selector(Next:)];
    
    CCMenuItemImage *btnPrev = [CCMenuItemImage itemFromNormalImage:@"btnatras-on.png" selectedImage:@"btnatras-over.png" target:self selector:@selector(Prev:)];
    
    CCMenuItemImage *btnPlay = [CCMenuItemImage itemFromNormalImage:@"btnplay-on.png" selectedImage:@"btnplay-over.png" target:self selector:@selector(Play:)];
    
    
    CCMenu *MenuReproduccion = [CCMenu menuWithItems:btnPlay,btnPrev,btnNext,nil];
    
    [MenuReproduccion alignItemsHorizontally];
     MenuReproduccion.position =CGPointMake(size.width - 150, 30);
    

    
    CCMenuItemImage *btnJugar = [CCMenuItemImage itemFromNormalImage:@"btnjugar-on.png" selectedImage:@"btnjugar-over.png" target:self selector:@selector(Jugar:)];
    
    
    //CCMenuItemImage *btnJugar = [CCMenuItemImage itemFromNormalImage:@"btnjugar-on.png"  selectedImage:@"btnjugar-over.png" target:self selector:@selector(gCierraCortinas:)];
    
    CCMenu *MenuJugar = [CCMenu menuWithItems:btnJugar, nil];
    
    MenuJugar.position =CGPointMake(200, 30);
    labelTitle = [CCLabelTTF labelWithString:gTitles[gCurrentSong] fontName:@"OCRAEXT" fontSize:20];
    labelTitle.position =  ccp(size.width / 2 , 30);

    
    [titleLayer addChild:labelTitle];
   
    [controlsLayer addChild:MenuReproduccion];
    
    [controlsLayer addChild:MenuJugar];
    
}

- (void) Jugar: (CCMenuItem  *) menuItem

{
    [self gCierraCortinas];
}

-(void) BuildBackground
{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    background = [CCSprite spriteWithFile:@"M1.png"];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [backGroundLayer addChild:background]; // añadimos el sprite a la capa l1
    
}

- (void) Next: (CCMenuItem  *) menuItem
{
    gCurrentSong++;
    if (gCurrentSong>3)gCurrentSong=0;
    if (isplaying){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:gSongs[gCurrentSong] ];
        wasPaused=FALSE;
    }
    [self songTitle];
    
    
} 
- (void) Prev: (CCMenuItem  *) menuItem
{
    gCurrentSong--;
    if (gCurrentSong<0)gCurrentSong=3;
    if (isplaying){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:gSongs[gCurrentSong] ];
        wasPaused=FALSE;
    }
    [self songTitle];
    [self discIn];
    
}
- (void) Play: (CCMenuItem  *) menuItem
{
    
    
    if (wasPaused)
    {
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:gSongs[gCurrentSong] ];
    }
    pauseLayer.visible=TRUE;
    isplaying=true;
}
- (void) Pause: (CCMenuItem  *) menuItem
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];

    pauseLayer.visible=FALSE;
    wasPaused=TRUE;
}



-(void) songTitle
{

    
    NSString *stringCurrentTitle=gTitles[gCurrentSong];

    //[labelScore setColor:ccBLACK];

    [labelTitle setString:stringCurrentTitle];

}


- (void) gAbreCortinas
{
    CCSprite *cortina = [CCSprite spriteWithFile:@"1.png" ];
    cortina.position = ccp(size.width/2,size.height/2);
    [cortinasLayer addChild:cortina];
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,size.height+(size.height/2))
                     ];
    [cortinasLayer runAction:[CCSequence actions:actionMove,nil]];
    
    
}
- (void) gCierraCortinas
{
    
    CCSprite *cortina = [CCSprite spriteWithFile:@"1.png" ];
    cortina.position = ccp(size.width/2,size.height*2);
    [cortinasLayer addChild:cortina];
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,0)
                     ];
    id done=[CCCallFunc actionWithTarget:self selector:@selector(Replace)];
    [cortinasLayer runAction:[CCSequence actions:actionMove,done ,nil]];
    
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
