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

    CCLayer *discLayer, * controlsLayer,*cortinasLayer, *backGroundLayer,*titleLayer,*pauseLayer,
    *discLayerOut;
    CCSprite *background;
    CCSprite *disc;
    CCLabelTTF *labelTitle;
    bool isplaying;
    bool wasPaused;
    CGSize size;
}

// returns a CCScene that contains the InitLayer as the only child
+(CCScene *) scene;

-(void) BuildBackground;
-(void) BuildControls;
-(void) BuildPause;
-(void) songTitle;
-(void) gAbreCortinas;
-(void) gCierraCortinas;
@end



