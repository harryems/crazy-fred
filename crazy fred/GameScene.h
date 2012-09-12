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
    CCLabelTTF *labelScore;
    int count;
    int paso;
    CGSize size;
    NSMutableArray *secuencia;
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
-(void) BuildBackground;
-(void) BuildInstrumentos;
-(void) gameAbreCortinas;
-(void) btnAccion;


// returns a CCScene that contains the InitLayer as the only child
+(CCScene *) scene;

@end
