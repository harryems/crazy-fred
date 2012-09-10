//
//  global.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "global.h"


int gCurrentSong;

NSString *gCTitle;

 NSString* gSongs[] =
{   @"Guns.mp3",
    @"Hey girl.mp3",
    @"red hot chilli pepper.mp3",
    @"ac:dc.mp3"
};
NSString* gTitles[] =
{   @"Guns & Rouses",
    @"Infected mushrums",
    @"red hot chilli pepper",
    @"ac:dc"
};


@implementation GlobalData
@synthesize message;
static GlobalData *sharedGlobalData = nil;

+ (GlobalData*)sharedGlobalData {
    if (sharedGlobalData == nil) {
        sharedGlobalData = [[super allocWithZone:NULL] init];
        
        // initialize your variables here
        sharedGlobalData.message = @"Default Global Message";
    }
    return sharedGlobalData;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self)
	{
		if (sharedGlobalData == nil)
		{
			sharedGlobalData = [super allocWithZone:zone];
			return sharedGlobalData;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}


- (id)autorelease {
    return self;
}

/*
- (void) gAbreCortinas
//- (void) gAbreCortinas
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *spriteCortinasCierran = [CCSprite spriteWithFile:@"9.png"];
    [spriteCortinasCierran setPosition:CGPointMake(size.width / 2, size.height / 2)];
    [self addChild:spriteCortinasCierran];
    
    CCAnimation *animationCortinasCierran = [CCAnimation animation];
    [ addFrameWithFilename:@"8.png"];
    [animationCortinasCierran addFrameWithFilename:@"7.png"];
    [animationCortinasCierran addFrameWithFilename:@"6.png"];
    [animationCortinasCierran addFrameWithFilename:@"5.png"];
    [animationCortinasCierran addFrameWithFilename:@"4.png"];
    [animationCortinasCierran addFrameWithFilename:@"3.png"];
    [animationCortinasCierran addFrameWithFilename:@"2.png"];
    [animationCortinasCierran addFrameWithFilename:@"1.png"];
    //[animationCortinasCierran addFrameWithTexture:<#(CCTexture2D *)#> rect:<#(CGRect)#>];
    
    
    CCAnimate *animateCortinasCierran = [CCAnimate actionWithDuration:5 animation:animationCortinasCierran restoreOriginalFrame:NO];
    [spriteCortinasCierran runAction:animateCortinasCierran];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2], nil]];
}
*/
- (void) gCierraCortinas:(CCLayer  *) layer
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *spriteCortinasCierran = [CCSprite spriteWithFile:@"1.png"];
    [spriteCortinasCierran setPosition:CGPointMake(size.width / 2, size.height / 2)];
    [layer addChild:spriteCortinasCierran];
    
    CCAnimation *animationCortinasCierran = [CCAnimation animation];
    [animationCortinasCierran addFrameWithFilename:@"2.png"];
    [animationCortinasCierran addFrameWithFilename:@"3.png"];
    [animationCortinasCierran addFrameWithFilename:@"4.png"];
    [animationCortinasCierran addFrameWithFilename:@"5.png"];
    [animationCortinasCierran addFrameWithFilename:@"6.png"];
    [animationCortinasCierran addFrameWithFilename:@"7.png"];
    [animationCortinasCierran addFrameWithFilename:@"8.png"];
    [animationCortinasCierran addFrameWithFilename:@"9.png"];
    //[animationCortinasCierran addFrameWithTexture:<#(CCTexture2D *)#> rect:<#(CGRect)#>];
    
    
    CCAnimate *animateCortinasCierran = [CCAnimate actionWithDuration:5 animation:animationCortinasCierran restoreOriginalFrame:NO];
    [spriteCortinasCierran runAction:animateCortinasCierran];
    [layer runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2], nil]];
}

@end




