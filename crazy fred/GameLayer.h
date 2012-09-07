//
//  GameLayer.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MusicLayer.h"

@interface GameLayer : CCLayer {
    CCLayer *medidorLayer, * instrumentosLayer, *backGroundLayer;
    CCSprite *background;
    int CountSong;
    
}
-(void) BuildBackground;
-(void) BuildInstrumentos;

// returns a CCScene that contains the InitLayer as the only child
+(CCScene *) scene;

@end
