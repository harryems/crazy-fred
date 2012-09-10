//
//  MusicScene.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MusicScene : CCLayer {
    CCLayer *discLayer, * controlsLayer,*cortinasLayer, *backGroundLayer,*titleLayer,*pauseLayer;
    CCSprite *background;
    CCLabelTTF *labelScore;
}

// returns a CCScene that contains the InitLayer as the only child
+(CCScene *) scene;

-(void) BuildBackground;
-(void) BuildControls;
-(void) BuildPause;
-(void) songTitle;
-(void) gAbreCortinasLocal;

-(void) gCierraCortinasLocal;
@end



