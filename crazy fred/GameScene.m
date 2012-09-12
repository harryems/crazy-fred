//
//  GameScene.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "SimpleAudioEngine.h"
#import "GameScene.h"
#import "global.h"

int gCurrentSong;


@implementation GameScene


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];

	
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
        count=1;
        paso=1;
        //secuencia = [NSMutableArray array];


        medidorLayer= [CCLayer node];
        backGroundLayer= [CCLayer node];
        instrumentosLayer= [CCLayer node];
        gamecortinasLayer= [CCLayer node];
        gamecortinasFinal= [CCLayer node];
        agujaLayer= [CCLayer node];
        titleLayer= [CCLayer node];


        

        [self addChild:backGroundLayer];
        [self addChild:instrumentosLayer];
        [self addChild:titleLayer];


        [self addChild:medidorLayer];
        [self addChild:agujaLayer];
        [self addChild:gamecortinasLayer];
        [self addChild:gamecortinasFinal];


        [self BuildBackground];
        [self BuildInstrumentos];
        [self gameAbreCortinas];
        
        [self generaSecuencia];

        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
	return self;
}

-(void) avanzaAguja:(int)time{
    CCSprite *aguja=[CCSprite spriteWithFile:@"flecha1.png"];
    aguja.scale=0.9;
    aguja.position = ccp(930, 80);
    [agujaLayer addChild:aguja];

id actionMove = [CCRotateBy  actionWithDuration:1 angle:time];
[agujaLayer runAction:[CCSequence actions:actionMove,nil]];

}
-(void) BuildBackground
{

    background = [CCSprite spriteWithFile:@"juego-bg.png"];
    background.position = ccp(size.width/2, size.height/2);
    [backGroundLayer addChild:background];
    
    medidor = [CCSprite spriteWithFile:@"medidor.png"];
    medidor.scale=0.9;
    medidor.position = ccp(930, 80);
    [medidorLayer addChild:medidor];
    
    CCSprite *aguja=[CCSprite spriteWithFile:@"flecha1.png"];
    aguja.scale=0.9;
    aguja.position = ccp(930, 80);
    [agujaLayer addChild:aguja];
    
    
    
    labelScore = [CCLabelTTF labelWithString:gTitles[gCurrentSong] fontName:@"OCRAEXT" fontSize:16];
    [titleLayer addChild:labelScore];
    labelScore.position =  ccp(size.width / 2 , 30);

}

-(void) BuildInstrumentos
{
    ba1 = [CCMenuItemImage itemFromNormalImage:@"ba1.png" selectedImage:@"be1.png" target:self selector:@selector(touchButton:)];
    ba2 = [CCMenuItemImage itemFromNormalImage:@"ba2.png"  selectedImage:@"be2.png" target:self selector:@selector(touchButton:)];
    ba3 = [CCMenuItemImage itemFromNormalImage:@"ba3.png"  selectedImage:@"be3.png" target:self selector:@selector(touchButton:)];
    ba4 = [CCMenuItemImage itemFromNormalImage:@"ba4.png" selectedImage:@"be4.png" target:self selector:@selector(touchButton:)];
    ba5 = [CCMenuItemImage itemFromNormalImage:@"ba5.png"  selectedImage:@"be5.png" target:self selector:@selector(touchButton:)];
    ba6 = [CCMenuItemImage itemFromNormalImage:@"ba6.png"  selectedImage:@"be6.png" target:self selector:@selector(touchButton:)];
    ba7 = [CCMenuItemImage itemFromNormalImage:@"ba7.png" selectedImage:@"be7.png" target:self selector:@selector(touchButton:)];
    ba8 = [CCMenuItemImage itemFromNormalImage:@"ba8.png"  selectedImage:@"be8.png" target:self selector:@selector(touchButton:)];
    ba9 = [CCMenuItemImage itemFromNormalImage:@"ba9.png"  selectedImage:@"be9.png" target:self selector:@selector(touchButton:)];
    
    CCMenu *Instrumentos = [CCMenu menuWithItems:ba1,ba2,ba3,ba4,ba5,ba6,ba7,ba8,ba9, nil];
    
    [Instrumentos  alignItemsInColumns:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3],[NSNumber numberWithInt:3], nil];
    Instrumentos.position =CGPointMake(size.width / 2, size.height / 2);
    
    Instrumentos.scale=0.95;
    //CCMenu *row1 = [CCMenu menuWithItems:ba1,nil];
    
    //[row1 alignItemsHorizontallyWithPadding:1];
    [instrumentosLayer addChild:Instrumentos];

}

-(void) generaSecuencia
{

    for (int i; i<20;i++)
    {
        int temp= (arc4random() % 9) + 1;
        [secuencia addObject:[NSNumber numberWithInt:temp] ];

    }
    int tm=[[secuencia objectAtIndex:1]integerValue];
    NSLog(@"array %d\n", tm );


}
    

-(void) muestrasecuencia
{
    for(int imuestra=1; imuestra <= paso ;imuestra++)
    {
        
       /*  [CCCallFuncND actionWithTarget:self
                          selector:@selector(btnAccion:data:)
                              data:(void*)[NSNumber numberWithInt:imuestra]
          ];
        */
        [self btnAccion];
    }
    


}


//-(void) btnAccion:(id)sender data:(int)num

-(void) btnAccion
{
    /*
    NSString *stringtmp=[NSString stringWithFormat:@"ba%@", [secuencia objectAtIndex:paso]];
    NSLog(stringtmp);
    CCMenuItemImage *Itemtmp=[self valueForKey:stringtmp];

   // NSString *numbtn= [NSString stringWithFormat:@"ba%d",num];//@"ba"+num;
    //[ba1 selected];
    id delay=[CCDelayTime actionWithDuration:gTimingLevel[gCurrentSong]];

    id select= [CCCallFuncND actionWithTarget:self
                                     selector:@selector(seleccionar:data:)
                                     data:Itemtmp
                ];
    id unselect= [CCCallFuncND actionWithTarget:self
                                     selector:@selector(deseleccionar:data:)
                                         data:Itemtmp
                ];
  
    [self runAction:[CCSequence actions: select,delay,unselect,nil]];
*/
}

-(void) seleccionar:(id)sender data:(CCMenuItemImage *) boton
{

    [boton selected];

}

-(void) deseleccionar:(id)sender data:(CCMenuItemImage *) boton
{
    
    [boton unselected];
    
}



- (void) gameAbreCortinas
{
    CCSprite *cortina = [CCSprite spriteWithFile:@"1.png" ];
    cortina.position = ccp(size.width/2,size.height/2);
    [gamecortinasLayer addChild:cortina];
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,size.height+(size.height/2))
                     ];
    [gamecortinasLayer runAction:[CCSequence actions:actionMove,nil]];
}


- (void) cierreFinal
{
   // [gamecortinasLayer removeAllChildrenWithCleanup:YES];
    CCSprite *cortinaFinal = [CCSprite spriteWithFile:@"r8.png" ];
    cortinaFinal.position = ccp(size.width/2,size.height*2);
    [gamecortinasLayer addChild:cortinaFinal];
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,0)
                     ];
    id marcador=[CCCallFunc actionWithTarget:self selector:@selector(muestraMarcador)];

    
    [gamecortinasLayer runAction:[CCSequence actions:actionMove,marcador,nil]];
}


-(void) muestraMarcador
{

    labelScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%2.0f",gScore] fontName:@"OCRAEXT" fontSize:40 ];
    [gamecortinasLayer addChild:labelScore];
    labelScore.position =  ccp(size.width / 2 , size.height / 2);
    


}


- (void) touchButton: (CCMenuItem  *) menuItem
{
   
    /*count++;
    
    if (count==5){
        [self cierreFinal];
        [self muestraMarcador];
    }
    else{
    [self avanzaAguja:count];
    }*/
    
    [self muestrasecuencia];
    paso++;
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
