//
//  GameScene.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MusicScene.h"

@interface GameScene : CCLayer {
    CCLayer *medidorLayer, * instrumentosLayer, *backGroundLayer,*gamecortinasLayer,*agujaLayer,*titleLayer,*gamecortinasFinal;
    CCSprite *background;
    CCSprite *medidor;
    CCSprite *aguja;
    CCSprite *cortina;
    CCLabelTTF *labelScore;
    CCLabelTTF *labelTitle;
    CCLabelTTF *labelCurrenScore;
    int count;
    int paso;
    int internalPaso;
    int imuestra;
    CGSize size;
    //NSMutableArray *secuencia;
    NSMutableArray *array;
    CCMenuItemImage *ba1 ;
    CCMenuItemImage *ba2 ;
    CCMenuItemImage *ba3 ;
    CCMenuItemImage *ba4 ;
    CCMenuItemImage *ba5 ;
    CCMenuItemImage *ba6 ;
    CCMenuItemImage *ba7 ;
    CCMenuItemImage *ba8 ;
    CCMenuItemImage *ba9 ;
    
    
}
-(void) generaSecuencia;

-(void) gameAbreCortinas;
-(void) muestrasecuencia;


//-(void) cierreFinal;
-(void) muestraMarcador;
-(void) BuildBackground;
-(void) BuildInstrumentos;

// returns a CCScene that contains the InitLayer as the only child
+(CCScene *) scene;

@end
