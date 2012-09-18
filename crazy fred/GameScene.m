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
#import "InitLayer.h"
#import "FacebookScorer/FacebookScorer.h"
 
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

        cortina = [CCSprite spriteWithFile:@"1.png" ];
        cortina.position = ccp(size.width/2,size.height/2);
        [gamecortinasLayer addChild:cortina];
        
        
        
        
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


-(void)CpArray:(int *)origen :(int *)destino
{
    for (int i=0;i<=(sizeof(origen)/sizeof(int));i++)
         {
             destino[i]=origen[i];
         }
}


-(void) avanzaAguja{

    [aguja runAction:[CCRotateBy  actionWithDuration:1 angle:170/gTopLevel[gCurrentSong]]];
    
}


-(void) generaSecuencia
{
    switch (gCurrentSong) {
        case 0:
            for( int i = 0; i < gTopLevel[gCurrentSong]; ++i )
            {
                [array addObject:[NSNumber numberWithInt:secuencia1[i]]];
            }
            break;
        case 1:
            for( int i = 0; i < gTopLevel[gCurrentSong]; ++i )
            {
                [array addObject:[NSNumber numberWithInt:secuencia2[i]]];
            }
            break;
        case 2:
            for( int i = 0; i < gTopLevel[gCurrentSong]; ++i )
            {
                [array addObject:[NSNumber numberWithInt:secuencia3[i]]];
            }
            break;
            
        case 3:
            for( int i = 0; i < gTopLevel[gCurrentSong]; ++i )
            {
                [array addObject:[NSNumber numberWithInt:secuencia4[i]]];
            }
            break;
        default:
            break;
    }
    

    
   /* for( int i = 0; i < 100; ++i )
    {
        int temp= (arc4random() % 9) + 1;
        [array addObject:[NSNumber numberWithInt:temp]];
    }
    */
}

-(void) actualizaScore
{

    gScore=gScore+(internalPaso*(2-gTimingLevel[gCurrentSong])*100 );
    labelCurrenScore.string=[NSString stringWithFormat:@"%6.0f",gScore];

    
}

  
-(void)muestrasecuencia
{

  //  if (imuestra<=paso) {
   if (imuestra< gTopLevel[gCurrentSong])
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
        id music=[CCCallFunc actionWithTarget:self selector:@selector(resumenbackground)];
        
        [self runAction:[CCSequence actions: cierra,delay,abre,music,nil]];
        internalPaso=0;
    
    }

    imuestra++;

    
    
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
    
    [gamecortinasLayer runAction:[CCMoveTo actionWithDuration:2
                                           position:ccp(0,size.height+(size.height/2))
                                  ]];
}


- (void) cierreCortina
{
    
    [gamecortinasLayer runAction:[CCMoveTo actionWithDuration:2
                                           position:ccp(0,0)
                                  ]];
    
}
-(void) Replace:(CCMenuItem  *) menuItem
{
    
    [[CCDirector sharedDirector] replaceScene:[MusicScene scene]];
    
}


-(void) ReplaceInicio:(CCMenuItem  *) menuItem
{
    
    [[CCDirector sharedDirector] replaceScene:[InitLayer scene]];
    
}

-(void) Share:(CCMenuItem  *) menuItem
{
    [[FacebookScorer sharedInstance] postToWallWithDialogNewHighscore:gScore];

    
    
}

-(void) BuildRetrai
{
    count=1;
    paso=1;
    imuestra=0;
    gScore=0;
    CCMenuItemImage *btnRetrai = [CCMenuItemImage itemFromNormalImage:@"btnjugar-on.png" selectedImage:@"btnjugar-over.png" target:self selector:@selector(Replace:)];
    MenuRetrai = [CCMenu menuWithItems:btnRetrai, nil];
    MenuRetrai.position =CGPointMake(size.width/2, 50);
    [gamecortinasLayer addChild:MenuRetrai];

}
-(void) BuildFail
{
    CCMenuItemImage *btnFail = [CCMenuItemImage itemFromNormalImage:@"btnjugar-on.png" selectedImage:@"btnjugar-over.png" target:self selector:@selector(ReplaceInicio:)];
    CCMenu *MenuFail = [CCMenu menuWithItems:btnFail, nil];
    MenuFail.position =CGPointMake(size.width/2, 50);
    [gamecortinasLayer addChild:MenuFail];
    
}

-(void) BuilFaceShare
{
    CCMenuItemImage *btnShare = [CCMenuItemImage itemFromNormalImage:@"facebook_button.png" selectedImage:@"facebook_button.png" target:self selector:@selector(Share:)];
    CCMenu *MenuShare = [CCMenu menuWithItems:btnShare, nil];
    MenuShare.position =CGPointMake(size.width/2, 50);
    [gamecortinasLayer addChild:MenuShare];
    
}


-(void) cierreFinalCandados
{

    switch (gResultado) {
        case 1:
            cortinaFinal = [CCSprite spriteWithFile:@"ganador.png" ];
            [self BuilFaceShare];
            break;
        case 2:
            cortinaFinal = [CCSprite spriteWithFile:@"premio-intermedio.png" ];
            [self BuildRetrai];
            break;
        case 3:
            cortinaFinal = [CCSprite spriteWithFile:@"perdedor.png" ];
            [self BuildFail];

            
            break;
        default:
            break;
    }
    
    
    CCSprite *poste1=[CCSprite spriteWithFile:@"poste.png" ];
    CCSprite *poste2=[CCSprite spriteWithFile:@"poste.png" ];
    poste1.position = ccp(size.width/2-(size.width/4),size.height*2);
    poste2.position = ccp(size.width/2+(size.width/4),size.height*2);
    
    [gamecortinasFinal addChild:poste1];
    [gamecortinasFinal addChild:poste2];
    
    

    
    cortinaFinal.position = ccp(size.width/2,size.height*2);
    [gamecortinasFinal addChild:cortinaFinal];
    [gamecortinasFinal runAction:[CCMoveTo actionWithDuration:2
                                           position:ccp(0,-size.height-(size.height/2))
                                  ]];


}

- (void) cierreFinal
{
   
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    id cortinas=[CCCallFunc actionWithTarget:self selector:@selector(cierreCortina)];

    id delayMusic=[CCDelayTime actionWithDuration:2];

    id candados=[CCCallFunc actionWithTarget:self selector:@selector(cierreFinalCandados)];

    [gamecortinasLayer runAction:[CCSequence actions:cortinas,delayMusic,candados,nil]];

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
    

   // id pausa=[CCCallFunc actionWithTarget:self selector:@selector(pausebackground)];
   // id resumen=[CCCallFunc actionWithTarget:self selector:@selector(resumenbackground)];
   // id delayMusic=[CCDelayTime actionWithDuration:0.5];
    //[self runAction:[CCSequence actions:resumen,delayMusic,pausa,nil]];
    
    


    int tmp=[[array objectAtIndex:internalPaso]integerValue];


    
        if( tmp != [sender tag ]  )
        {
            if ((100*internalPaso)/gTopLevel[gCurrentSong] <55){
                gResultado=3;
            }
            else
                gResultado=2;
            //[CCCallFunc actionWithTarget:self selector:@selector(cierreFinal)];
            [self cierreFinal];
        }
        else{
    
                internalPaso++;
            [self avanzaAguja];
            [self actualizaScore];
                //if (internalPaso==paso)
               if (internalPaso==gTopLevel[gCurrentSong])
                {
                    gResultado=1;
                    [self cierreFinal];

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

    
    labelTitle = [CCLabelTTF labelWithString:gDisplaySongs[gCurrentSong] fontName:@"OCRAEXT" fontSize:16];
    labelTitle.color=ccc3(25, 169, 19);
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
    [instrumentosLayer addChild:Instrumentos];
    
}




- (void) dealloc
{
    
	[super dealloc];
}

@end
