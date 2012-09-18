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
    CCLayer *inputsLayer, *backGroundLayer,*cortinasLayer, *backGroundCortina;
    CCSprite *background;
    CCSprite *cortina;
    CCSprite *backCortina;
    CGSize size;
    
    UIView *registroContenedor;
    UITextField     *textName;
    UITextField     *textMail;
    UITextField     *dia;
    UITextField     *mes;
    UITextField     *anio;
    UIButton        *sendButton;
    UIButton        *datosButton;
    
    UIPickerView *pickerDia;
    UIPickerView *pickerMes;
    UIPickerView *pickerAnio;

    
    NSMutableArray* diasArray;
    NSMutableArray* mesesArray;
    NSMutableArray* aniosArray;
    
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
- (BOOL)textFieldShouldBeginEditing;
-(void) BuildBackground;
-(void) BuildInputs;
-(void) abreCortinas;
-(void) enviarDatos;
-(void) cierraCortinas;


+(CCScene *) scene;
@end
