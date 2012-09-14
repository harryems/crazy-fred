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
#import "CCMenuItemLabelAndImage.h"

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
        menuListLayer=[CCLayer node];


        

        [self addChild:backGroundLayer];
        [self addChild:discLayer];
        [self addChild:menuListLayer];

        [self addChild:controlsLayer];
        [self addChild:pauseLayer];
        [self addChild:titleLayer];
        [self addChild:cortinasLayer];

        
        pauseLayer.visible=FALSE;
        isUp=FALSE;
        [self BuildBackground];
        [self BuildControls];
        [self BuildPause];
        [self BuilMenu];
       
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
    
    
    CCMenu *MenuJugar = [CCMenu menuWithItems:btnJugar, nil];
    
    MenuJugar.position =CGPointMake(200, 30);
    labelTitle = [CCLabelTTF labelWithString:gTitles[gCurrentSong] fontName:@"OCRAEXT" fontSize:20];
    labelTitle.position =  ccp(size.width / 2 , 30);

    
    [titleLayer addChild:labelTitle];
   
    [controlsLayer addChild:MenuReproduccion];
    
    [controlsLayer addChild:MenuJugar];
    
}

-(void) BuilMenu
{
    
    labelSong1 = [CCLabelTTF labelWithString:gTitles[0] fontName:@"OCRAEXT" fontSize:30];
    labelSong2 = [CCLabelTTF labelWithString:gTitles[1] fontName:@"OCRAEXT" fontSize:30];
    labelSong3 = [CCLabelTTF labelWithString:gTitles[2] fontName:@"OCRAEXT" fontSize:30];
    labelSong4 = [CCLabelTTF labelWithString:gTitles[3] fontName:@"OCRAEXT" fontSize:30];

    [labelSong1 setColor:ccBLACK];
    [labelSong2 setColor:ccBLACK];
    [labelSong3 setColor:ccBLACK];
    [labelSong4 setColor:ccBLACK];
    
   CCMenuItemImage *topList= [CCMenuItemImage itemFromNormalImage:@"btn_track.png" selectedImage:@"btn_track.png" target:self selector:@selector(desplazaMenu:)];
    
    itemSong1 = [CCMenuItemLabelAndImage itemFromLabel:labelSong1 normalImage:@"btn_List.png" selectedImage:@"btn_List.png" disabledImage:@"btn_List.png" target:self selector:@selector(touchList:)];
   itemSong2 = [CCMenuItemLabelAndImage itemFromLabel:labelSong2 normalImage:@"btn_List.png" selectedImage:@"btn_List.png" disabledImage:@"btn_List.png" target:self selector:@selector(touchList:)];
    itemSong3 = [CCMenuItemLabelAndImage itemFromLabel:labelSong3 normalImage:@"btn_List.png" selectedImage:@"btn_List.png" disabledImage:@"btn_List.png" target:self selector:@selector(touchList:)];
    itemSong4 = [CCMenuItemLabelAndImage itemFromLabel:labelSong4 normalImage:@"btn_List.png" selectedImage:@"btn_List.png" disabledImage:@"btn_List.png" target:self selector:@selector(touchList:)];
    
    menulist = [CCMenu menuWithItems:topList,itemSong1,itemSong2,itemSong3,itemSong4, nil];
    
    [menulist alignItemsVerticallyWithPadding:0.0f];
    menulist.position = ccp(770, -37);
    [menuListLayer addChild:menulist];


}
- (void) desplazaMenu: (CCMenuItem  *) menuItem

{

    if (isUp) {
        id actionMove = [CCMoveTo actionWithDuration:0.5
                                            position:ccp(0,0)
                         ];
         isUp=FALSE;
        [menuListLayer runAction:[CCSequence actions:actionMove,nil]];

    }
    else
    {
       id actionMove = [CCMoveTo actionWithDuration:0.5
                                            position:ccp(0,280)
                         ];
        isUp=TRUE;
        
        [menuListLayer runAction:[CCSequence actions:actionMove,nil]];

    }
    

    
    
}

- (void) touchList:  (id) sender
{

    itemSong1.tag=0;
    itemSong2.tag=1;
    itemSong3.tag=2;
    itemSong4.tag=3;
    gCurrentSong=[sender tag];
    [self songTitle];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:gSongs[gCurrentSong] ];


    

}

- (void) Jugar: (CCMenuItem  *) menuItem

{
    [self gCierraCortinas];
}

-(void) BuildBackground
{
    
    background = [CCSprite spriteWithFile:@"M1.png"];
    background.position = ccp(size.width/2, size.height/2);
    [backGroundLayer addChild:background];
    
    disc = [CCSprite spriteWithFile:@"d7.png" ];
    disc.position = ccp(size.width/2,size.height/2);
    [discLayer addChild:disc];
    
    
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

-(void) discInIz
{
    disc2 = [CCSprite spriteWithFile:@"d7.png" ];
    disc2.position = ccp(size.width+size.width/2,size.height/2);
    [discLayer addChild:disc2];
    
    
    id add=[CCCallFunc actionWithTarget:self selector:@selector(addSprite)];
    id remove=[CCCallFunc actionWithTarget:self selector:@selector(removeSprite)];
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(-size.width,0)
                     ];
    id delay=[CCDelayTime actionWithDuration:0.01];
    
    [discLayer runAction:[CCSequence actions:actionMove,remove,delay,add ,nil]];
    
    
}

-(void) removeSprite
{
    //[discLayer removeChild:disc cleanup:NO];
    [discLayer removeAllChildrenWithCleanup:YES];

}

-(void) addSprite
{

    disc = [CCSprite spriteWithFile:@"d7.png" ];
    disc.position = ccp(size.width+size.width/2,size.height/2);
    [discLayer addChild:disc];
}




- (void) Prev: (CCMenuItem  *) menuItem
{
    gCurrentSong--;
    if (gCurrentSong<0)gCurrentSong=3;
    if (isplaying){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:gSongs[gCurrentSong] ];
        wasPaused=FALSE;
    }
    [self discInIz];
    
    //CCSprite *disc2 = [CCSprite spriteWithFile:@"d7.png" ];
    //disc2.position = ccp(size.width+size.width/2,size.height/2);
    //[discLayer addChild:disc2];
    
    //CCSprite *disc = [CCSprite spriteWithFile:@"d7.png" ];
    //disc.position = ccp(size.width+size.width/2,size.height/2);
    //[discLayer addChild:disc];

   /*
    
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(-size.width,0)
                     ];
    id addDisc2= [CCCallFuncND actionWithTarget:self
                                       selector:@selector(addtolayer:data:)
                                           data:disc2
                  ];
    id addDisc= [CCCallFuncND actionWithTarget:self
                                       selector:@selector(addtolayer:)
                                           data:disc
                  ];
    id removeDisc2= [CCCallFuncND actionWithTarget:self
                                      selector:@selector(removetolayer:)
                                          data:disc
                 ];
    
    */
    //id moveaction=[discLayer runAction:[CCSequence actions:actionMove,nil]];
    
   // [discLayer runAction:[CCSequence actions:addDisc2,actionMove,nil]];

    [self songTitle];
    //[self discIn];
    
}

-(void) addtolayer:(id)sender data:(CCSprite *)sprite
{
    [discLayer addChild:sprite];

}
-(void) removetolayer:(id)sender data:(CCSprite *)sprite
{
    [discLayer removeChild:sprite cleanup:YES];
    
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
