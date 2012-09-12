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
    
    CGSize size;

    
}
-(void) BuildBackground;
-(void) BuildInstrumentos;
-(void) gameAbreCortinas;


// returns a CCScene that contains the InitLayer as the only child
+(CCScene *) scene;

@end
