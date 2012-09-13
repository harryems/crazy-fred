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
        imuestra=0;
        gScore=0;
        array =  [[NSMutableArray array] retain];

        medidorLayer= [CCLayer node];
        backGroundLayer= [CCLayer node];
        instrumentosLayer= [CCLayer node];
        gamecortinasLayer= [CCLayer node];
        gamecortinasFinal= [CCLayer node];
        agujaLayer= [CCLayer node];
        titleLayer= [CCLayer node];


        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:gSongs[gCurrentSong] ];

        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic ];

        
        [self addChild:backGroundLayer];
        [self addChild:instrumentosLayer];
        [self addChild:titleLayer];


        [self addChild:medidorLayer];
        [self addChild:agujaLayer];
        [self addChild:gamecortinasLayer];
        [self addChild:gamecortinasFinal];


        [self BuildBackground];
        [self BuildInstrumentos];
        [self generaSecuencia];
        [self gameAbreCortinas];
        


        
    }
	return self;
}

-(void) avanzaAguja:(int)time{

    id actionMove = [CCRotateBy  actionWithDuration:1 angle:10*time];
    [aguja runAction:[CCSequence actions:actionMove,nil]];
    
}


-(void) generaSecuencia
{
    for( int i = 0; i < 100; ++i )
    {
        int temp= (arc4random() % 9) + 1;
        [array addObject:[NSNumber numberWithInt:temp]];
    }
    
}

-(void) actualizaScore
{

    gScore=gScore+(paso*(2-gTimingLevel[gCurrentSong])*100 );
    labelCurrenScore.string=[NSString stringWithFormat:@"%6.0f",gScore];

    
}

  
-(void)muestrasecuencia
{
    imuestra++;
  //  if (imuestra<=paso) {
   if (imuestra<= gTopLevel[gCurrentSong])
       {
        [[CCTouchDispatcher sharedDispatcher] setDispatchEvents:NO];  //mientras se muestra la secuencia el usuario no puede tocar los botones
        
        CCMenuItemImage *Itemtmp=[self valueForKey:[NSString stringWithFormat:@"ba%d", [[array objectAtIndex:imuestra]integerValue]]];
        
        
        id delay=[CCDelayTime actionWithDuration:gTimingLevel[gCurrentSong]]; //segun el nivel el tiempo
        id select= [CCCallFuncND actionWithTarget:self
                                         selector:@selector(seleccionar:data:)
                                             data:Itemtmp
                    ];
        
        id unselect= [CCCallFuncND actionWithTarget:self
                                           selector:@selector(deseleccionar:data:)
                                               data:Itemtmp
                      ];
        id recursive =[CCCallFunc actionWithTarget:self selector:@selector(muestrasecuencia)];
        [instrumentosLayer runAction:[CCSequence actions: select,delay,unselect,delay,recursive,nil]];
        
        
    }
    else
    {
        [[CCTouchDispatcher sharedDispatcher] setDispatchEvents:YES];
        
        id cierra=[CCCallFunc actionWithTarget:self selector:@selector(cierreCortina)];
        id abre=[CCCallFunc actionWithTarget:self selector:@selector(abreCortinas)];
        id delay =[CCDelayTime actionWithDuration:3];
        
        [self runAction:[CCSequence actions: cierra,delay,abre,nil]];
        internalPaso=0;
    
    }



    
    
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
    cortina = [CCSprite spriteWithFile:@"1.png" ];
    cortina.position = ccp(size.width/2,size.height/2);
    [gamecortinasLayer addChild:cortina];
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,size.height+(size.height/2))
                     ];
    
    [[CCTouchDispatcher sharedDispatcher] setDispatchEvents:NO];
    id delay=[CCDelayTime actionWithDuration:1];
    id secuencia=[CCCallFunc actionWithTarget:self selector:@selector(muestrasecuencia)];
    [gamecortinasLayer runAction:[CCSequence actions:actionMove,delay,secuencia,nil]];
}

- (void) abreCortinas
{

    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,size.height+(size.height/2))
                     ];
    
    [gamecortinasLayer runAction:[CCSequence actions:actionMove,nil]];
}


- (void) cierreCortina
{
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,0)
                     ];
    
    [gamecortinasLayer runAction:[CCSequence actions:actionMove,nil]];
    
}

-(void) cierreFinalCandados
{

    switch (gResultado) {
        case 1:
            cortinaFinal = [CCSprite spriteWithFile:@"ganador.png" ];
            break;
        case 2:
            cortinaFinal = [CCSprite spriteWithFile:@"perdedor.png" ];
            break;
        case 3:
            cortinaFinal = [CCSprite spriteWithFile:@"ganador.png" ];
            break;
        default:
            break;
    }
    
    //CCSprite *cortinaFinal = [CCSprite spriteWithFile:@"r9.png" ];
    cortinaFinal.position = ccp(size.width/2,size.height*2);
    [gamecortinasFinal addChild:cortinaFinal];
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,-size.height-(size.height/2))
                     ];
    //id marcador=[CCCallFunc actionWithTarget:self selector:@selector(muestraMarcador)];
    
    //[gamecortinasFinal runAction:[CCSequence actions:actionMove,marcador,nil]];
    [gamecortinasFinal runAction:[CCSequence actions:actionMove,nil]];


}

- (void) cierreFinal
{
   
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,0)
                     ];

    id candados=[CCCallFunc actionWithTarget:self selector:@selector(cierreFinalCandados)];

    [gamecortinasLayer runAction:[CCSequence actions:actionMove,candados,nil]];

}




-(void) muestraMarcador
{

    labelScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%2.0f",gScore] fontName:@"OCRAEXT" fontSize:50 ];
    [gamecortinasFinal addChild:labelScore];
    labelScore.position =  ccp(size.width / 2 , 30);
    


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
    

    id pausa=[CCCallFunc actionWithTarget:self selector:@selector(pausebackground)];
    id resumen=[CCCallFunc actionWithTarget:self selector:@selector(resumenbackground)];
    id delayMusic=[CCDelayTime actionWithDuration:0.5];
    [self runAction:[CCSequence actions:resumen,delayMusic,pausa,nil]];
    
    


    int tmp=[[array objectAtIndex:internalPaso+1]integerValue];


    
        if( tmp != [sender tag ]  )
        {
             NSLog(@"Error!!!!");
            
            labelScore = [CCLabelTTF labelWithString:@"Perdiste, intentalo de nuevo" fontName:@"OCRAEXT" fontSize:50 ];
            gResultado=2;
            id cierre=[CCCallFunc actionWithTarget:self selector:@selector(cierreFinal)];

            [self runAction:[CCSequence actions:cierre,nil]];

            //[self performSelector:@selector(cierreFinal)];  // equivocacion
        }
        else{
    
                internalPaso++;
                //if (internalPaso==paso)
               if (internalPaso==gTopLevel[gCurrentSong])
                {
                    gResultado=1;
                    labelScore = [CCLabelTTF labelWithString:@"Ganaste, compartelo con tus amigos" fontName:@"OCRAEXT" fontSize:50 ];
                    id cierre=[CCCallFunc actionWithTarget:self selector:@selector(cierreFinal)];
                    [self runAction:[CCSequence actions:cierre,nil]];
                    
                 /*
                    imuestra=0;
                    paso++;
                    [self actualizaScore];
                    
                    id delay=[CCDelayTime actionWithDuration:1];
                    [self avanzaAguja:1];

                    id secuencia=[CCCallFunc actionWithTarget:self selector:@selector(muestrasecuencia)];
                    [self runAction:[CCSequence actions:delay,secuencia,nil]];
                  */
                }
            
        }
}

-(void) pausebackground
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];


}

-(void) resumenbackground
{

    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];

}



-(void) BuildBackground
{
    
    background = [CCSprite spriteWithFile:@"juego-bg.png"];
    background.position = ccp(size.width/2, size.height/2);
    [backGroundLayer addChild:background];
    
    medidor = [CCSprite spriteWithFile:@"medidor.png"];
    medidor.position = ccp(930, 80);
    [medidorLayer addChild:medidor];
    
    aguja=[CCSprite spriteWithFile:@"flecha1.png"];
    aguja.position = ccp(930, 80);
    [agujaLayer addChild:aguja];
    
    
    labelCurrenScore = [CCLabelTTF  labelWithString:[NSString stringWithFormat:@"%6.0f",gScore]
                                    fontName:@"OCRAEXT"
                                    fontSize:35
                        ];
    [medidorLayer addChild:labelCurrenScore];
    labelCurrenScore.position =  ccp(930, 20);
    
    labelScore = [CCLabelTTF  labelWithString:@""
                                     fontName:@"OCRAEXT"
                                     fontSize:35
                  ];
    [gamecortinasFinal addChild:labelScore];
    labelScore.position =  ccp(size.width / 2 , 30);

    
    labelTitle = [CCLabelTTF labelWithString:gTitles[gCurrentSong] fontName:@"OCRAEXT" fontSize:16];
    [titleLayer addChild:labelTitle];
    labelTitle.position =  ccp(size.width / 2 , 30);
    
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
