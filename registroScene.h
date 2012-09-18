//
//  registroScene.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUIViewWrapper.h"
#import <MessageUI/MFMailComposeViewController.h>

#import "cocos2d.h"

@interface registroScene : CCLayer {
    CCLayer *inputsLayer, *backGroundLayer,*cortinasLayer;
    CCSprite *background;
    CCSprite *cortina;
    CGSize size;
    
    
    UITextField     *textName;
    UITextField     *textMail;
    UITextField     *dia;
    UITextField     *mes;
    UITextField     *anio;
    UIButton        *sendButton;
    UIButton        *datosButton;
    
    CCUIViewWrapper *WrapperSend;
     CCUIViewWrapper *WrapperDatos;
    CCUIViewWrapper *WrapperName;
    CCUIViewWrapper *WrapperMail;
    CCUIViewWrapper *WrapperDia;
    CCUIViewWrapper *WrapperMes;
    CCUIViewWrapper *WrapperAnio;
 
    NSMutableArray* usuariosRegistrados;
    NSMutableDictionary* usuario;
    


}

-(void) BuildBackground;
-(void) BuildInputs;
-(void) abreCortinas;
-(void) enviarDatos;
-(void) cierraCortinas;


+(CCScene *) scene;
@end
