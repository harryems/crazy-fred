//
//  Rotate.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "Rotate.h"

@implementation CCFerris
+(id) actionWithDuration: (ccTime) t position: (CGPoint) pos radius: (ccTime) h direction: (int) dir rotation: (ccTime) rot angle: (float) ang
{
	return [[[self alloc] initWithDuration: t position: pos radius: h direction: dir rotation: rot angle: ang] autorelease];
}

-(id) initWithDuration: (ccTime) t position: (CGPoint) pos radius: (ccTime) h direction: (int) dir rotation: (ccTime) rot angle: (float) ang
{
	if( (self=[super initWithDuration:t]) ) {
		center = pos;
		radius = h;
		direction = dir;
		rotation = rot;
		angle = ang;
	}
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration: [self duration] position: center radius: radius direction: direction rotation: rotation angle: angle];
	return copy;
}

-(void) startWithTarget:(id)aTarget
{
	[super startWithTarget:aTarget];
}

-(void) update: (ccTime) t
{
	currentAngle = 2 * M_PI * t * direction + angle; //2pi rad for 360 degrees
	[target_ setPosition: ccpAdd(ccpMult(ccpForAngle(-currentAngle), radius), center)];
	[target_ setRotation: rotation];
    
}

-(CCActionInterval*) reverse
{
	return [[self class] actionWithDuration:duration_ position:center radius:radius direction:-direction rotation:rotation angle: angle];
}

@end