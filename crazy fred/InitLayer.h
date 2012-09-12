//
//  InitLayer.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/4/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// InitLayer
@interface InitLayer : CCLayer
{
    CCLayer *controlsLayer,*cortinasLayer, *backGroundLayer,*luzLayer;
    CCSprite *background;
    CGSize size;

}


// returns a CCScene that contains the InitLayer as the only child
+(CCScene *) scene;

-(void) BuildBackground;
-(void) BuilLuz;
-(void) BuildControls;
-(void) Replace;

@end
