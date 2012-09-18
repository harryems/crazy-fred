//
//  MusicScene.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCMenuItemLabelAndImage.h"

@interface MusicScene : CCLayer {

    CCLayer *discLayer, * controlsLayer,*cortinasLayer, *backGroundLayer,*titleLayer,*pauseLayer,
    *discLayerOut,*menuListLayer, *franjaLayer;
    CCSprite *background;
    CCSprite *disc;
    CCSprite *disc2;
    CCSprite *cortina;
    CCLabelTTF *labelTitle;
    
    CCLabelTTF *labelSong1;
    CCLabelTTF *labelSong2;
    CCLabelTTF *labelSong3;
    CCLabelTTF *labelSong4;
    
    CCMenuItemLabelAndImage *itemSong1;
    CCMenuItemLabelAndImage *itemSong2;
    CCMenuItemLabelAndImage *itemSong3;
    CCMenuItemLabelAndImage *itemSong4;
    
    
    
    CCMenu *menulist;
    bool isUp;
    
    
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
-(void) BuilMenu;
@end



