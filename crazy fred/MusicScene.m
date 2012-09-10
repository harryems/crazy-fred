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
        
        isplaying=FALSE;
        gCurrentSong=0;
        discLayer= [CCLayer node];
        backGroundLayer= [CCLayer node];
        controlsLayer= [CCLayer node];
        cortinasLayer= [CCLayer node];
        titleLayer= [CCLayer node];
        pauseLayer=[CCLayer node];

        

        
        [self addChild:discLayer];
        [self addChild:backGroundLayer];
        [self addChild:controlsLayer];
        [self addChild:cortinasLayer];
        [self addChild:pauseLayer];
        [self addChild:titleLayer];
        
        pauseLayer.visible=FALSE;
        [self BuildBackground];
        [self BuildControls];
        [self BuildPause];
        
        //[[GlobalData sharedGlobalData] myFunc];
        [self gAbreCortinasLocal];
      
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        labelScore = [CCLabelTTF labelWithString:gTitles[gCurrentSong] fontName:@"OCRAEXT" fontSize:16];
        [titleLayer addChild:labelScore];
        labelScore.position =  ccp(winSize.width / 2 , 30);
        
        
	}
	return self;
}
- (void) gAbreCortinasLocal
//- (void) gAbreCortinas
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *spriteCortinasCierran = [CCSprite spriteWithFile:@"1.png"];
    [spriteCortinasCierran setPosition:CGPointMake(size.width / 2, size.height / 2)];
    [cortinasLayer addChild:spriteCortinasCierran];
    
    CCAnimation *animationCortinasCierran = [CCAnimation animation];
    [animationCortinasCierran addFrameWithFilename:@"2.png"];
    [animationCortinasCierran addFrameWithFilename:@"3.png"];
    [animationCortinasCierran addFrameWithFilename:@"4.png"];
    [animationCortinasCierran addFrameWithFilename:@"5.png"];
    [animationCortinasCierran addFrameWithFilename:@"6.png"];
    [animationCortinasCierran addFrameWithFilename:@"7.png"];
    [animationCortinasCierran addFrameWithFilename:@"8.png"];
    [animationCortinasCierran addFrameWithFilename:@"9.png"];
    //[animationCortinasCierran addFrameWithTexture:<#(CCTexture2D *)#> rect:<#(CGRect)#>];
    
    
    CCAnimate *animateCortinasCierran = [CCAnimate actionWithDuration:0.5 animation:animationCortinasCierran restoreOriginalFrame:NO];
    [spriteCortinasCierran runAction:animateCortinasCierran];
    //[cortinasLayer removeChild:spriteCortinasCierran cleanup:YES];
    
    
}
- (void) gCierraCortinasLocal
//- (void) gAbreCortinas
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *spriteCortinasCierran = [CCSprite spriteWithFile:@"9.png"];
    [spriteCortinasCierran setPosition:CGPointMake(size.width / 2, size.height / 2)];
    [cortinasLayer addChild:spriteCortinasCierran];
    
    CCAnimation *animationCortinasCierran = [CCAnimation animation];
    [animationCortinasCierran addFrameWithFilename:@"8.png"];
    [animationCortinasCierran addFrameWithFilename:@"7.png"];
    [animationCortinasCierran addFrameWithFilename:@"6.png"];
    [animationCortinasCierran addFrameWithFilename:@"5.png"];
    [animationCortinasCierran addFrameWithFilename:@"4.png"];
    [animationCortinasCierran addFrameWithFilename:@"3.png"];
    [animationCortinasCierran addFrameWithFilename:@"2.png"];
    [animationCortinasCierran addFrameWithFilename:@"1.png"];
    //[animationCortinasCierran addFrameWithTexture:<#(CCTexture2D *)#> rect:<#(CGRect)#>];
    
    
    CCAnimate *animateCortinasCierran = [CCAnimate actionWithDuration:0.5 animation:animationCortinasCierran restoreOriginalFrame:NO];
    [spriteCortinasCierran runAction:animateCortinasCierran];
    //cortinasLayer.visible=FALSE;
    //[cortinasLayer runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2], nil]];
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
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenuItemImage *Next = [CCMenuItemImage itemFromNormalImage:@"btnadelante-on.png" selectedImage:@"btnadelante-over.png" target:self selector:@selector(Next:)];
    
    CCMenuItemImage *Prev = [CCMenuItemImage itemFromNormalImage:@"btnatras-on.png" selectedImage:@"btnatras-over.png" target:self selector:@selector(Prev:)];
    
    // CCMenuItemImage *Pause = [CCMenuItemImage itemFromNormalImage:@"btnpausa-on.png" selectedImage:@"btnpausa-over.png" target:self selector:@selector(Pause:)];
    
    CCMenuItemImage *Play = [CCMenuItemImage itemFromNormalImage:@"btnplay-on.png" selectedImage:@"btnplay-over.png" target:self selector:@selector(Play:)];
    
    
    CCMenu *Reproduccion = [CCMenu menuWithItems:Play,Prev,Next,nil];
    
    [Reproduccion alignItemsHorizontally];
    Reproduccion.position =CGPointMake(size.width - 150, 30);
    
    [controlsLayer addChild:Reproduccion];
    
    CCMenuItemImage *Jugar = [CCMenuItemImage itemFromNormalImage:@"btnjugar-on.png"  selectedImage:@"btnjugar-over.png" target:self selector:@selector(Jugar:)];
    
    CCMenu *JugarMenu = [CCMenu menuWithItems:Jugar, nil];
    
    JugarMenu.position =CGPointMake(200, 30);
    [controlsLayer addChild:JugarMenu];
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
       // [[SimpleAudioEngine sharedEngine] playBackgroundMusic ];
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

- (void) Jugar: (CCMenuItem  *) menuItem

{
    [self gCierraCortinasLocal];
    //[[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}

-(void) songTitle
{

    
    NSString *stringCurrentTitle=gTitles[gCurrentSong];

    //[labelScore setColor:ccBLACK];

    [labelScore setString:stringCurrentTitle];

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
