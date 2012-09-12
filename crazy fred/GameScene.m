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
        paso=6;
        array = [NSMutableArray array];

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
        
        [self muestrasecuencia];

        
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


-(void) generaSecuencia
{
    for( int i = 0; i < 100; ++i )
    {
        int temp= (arc4random() % 9) + 1;
        [array addObject:[NSNumber numberWithInt:temp]];
        //NSLog(@"array %d",[[array objectAtIndex:i ]integerValue]);

    }
    
}
  
-(void)muestrasecuencia
{
    internalPaso=1;      //cada que se muestra la secuencia el usuario debe ir desde el principio
    [[CCTouchDispatcher sharedDispatcher] setDispatchEvents:NO];  //mientras se muestra la secuencia el usuario no puede tocar los botones

    for(int imuestra=1; imuestra <= paso ;imuestra++)
    {
        
        //NSLog(@"muestra %d\n",imuestra);
        //NSLog(@"paso %d\n",paso);
        //NSLog(@"array %d",[[array objectAtIndex:imuestra ]integerValue]);
        
    int tm=[[array objectAtIndex:paso]integerValue];
    NSString *stringtmp=[NSString stringWithFormat:@"ba%d", tm];
    CCMenuItemImage *Itemtmp=[self valueForKey:stringtmp];
    
    
    //id delay=[CCDelayTime actionWithDuration:gTimingLevel[gCurrentSong]]; //segun el nivel el tiempo entre se selecciona y deselecciona sera menor
    id delay=[CCDelayTime actionWithDuration:2];

    id select= [CCCallFuncND actionWithTarget:self
                                     selector:@selector(seleccionar:data:)
                                         data:Itemtmp
                ];
    
    id unselect= [CCCallFuncND actionWithTarget:self
                                       selector:@selector(deseleccionar:data:)
                                           data:Itemtmp
                  ];
    
    [self runAction:[CCSequence actions: select,delay,unselect,nil]];
    
    }
    
        [[CCTouchDispatcher sharedDispatcher] setDispatchEvents:YES];//al terminar de mostrar la secuencia se habilita nuevamente el tocar la pantalla

    
    
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


- (void) touchButton: (id) sender
{
 
    ba1.tag=1;
    ba2.tag=2;
    ba3.tag=3;
    ba4.tag=4;
    ba5.tag=5;
    ba6.tag=6;
    ba7.tag=7;
    ba8.tag=8;
    ba9.tag=9;

    NSLog(@"array %d",[[array objectAtIndex:internalPaso ]integerValue]);
    
    //int tmp=[[array objectAtIndex:internalPaso]integerValue];
    
    
    
    
    //NSLog(@"tag %d\n",[sender tag ]);
    //NSLog(@"array %d",[[array objectAtIndex:1]integerValue]);
    //NSLog(@"%d",tmp);
    
    //if(internalPaso>=paso)
        //muestra secuencia + 1 paso
    
  //if( tmp !=  [sender tag ]  )
   //   [self cierreFinal];  // equivocacion
    internalPaso++;          // continua con una secuencia mas
      
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

- (void) dealloc
{
    
	[super dealloc];
}

@end
