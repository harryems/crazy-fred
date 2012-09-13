//
//  Rotate.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/** Rotates the node around a point
 */
@interface CCFerris : CCActionInterval <NSCopying>
{
	CGPoint center;
	float radius;
	float currentAngle;
	float startAngle;
	float delta;
	float angle;
	ccTime rotation;
	int direction;
    
}
/** creates the action */
+(id) actionWithDuration: (ccTime)duration position:(CGPoint)position radius:(float)radius direction:(int)dir rotation: (ccTime)rot angle: (float)angle;
/** initializes the action */
-(id) initWithDuration: (ccTime)duration position:(CGPoint)position radius:(float)radius direction:(int)dir rotation: (ccTime)rot angle: (float)angle;
@end
