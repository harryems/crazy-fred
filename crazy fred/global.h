//
//  global.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

extern int gCurrentSong;
//extern NSArray *gSongs;
extern NSString* gSongs[];
extern NSString* gTitles[];
extern NSString *gCTitle;

@interface GlobalData : NSObject {
    NSString *message; // global variable
}

@property (nonatomic, retain) NSString *message;

//-(void) gAbreCortinas;
-(void) gCierraCortinas:(CCLayer *)layer;


@end