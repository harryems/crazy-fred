//
//  Singleton.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Singleton : NSObject {
    
}
+(Singleton*)sharedMySingleton;
-(void)sayHello;
-(void)gAbreCortinas;
@end
