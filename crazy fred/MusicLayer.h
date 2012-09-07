//
//  MusicLayer.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MusicLayer : CCLayer {

}

@property int CountSong;
// returns a CCScene that contains the InitLayer as the only child
+(CCScene *) scene;

@end
