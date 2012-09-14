//
//  Singleton.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"


@implementation Singleton
static Singleton* _sharedSingleton = nil;

+(Singleton*)sharedSingleton
{
	@synchronized([Singleton class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([Singleton class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
    
	return self;
}

-(void) gAbreCortinas{
    [CCMoveTo actionWithDuration:2
                        position:ccp(0,[[CCDirector sharedDirector] winSize].height+([[CCDirector sharedDirector] winSize].height/2))
     ];
    
    
}

-(void)sayHello {
	NSLog(@"Hello World!");
}
@end
