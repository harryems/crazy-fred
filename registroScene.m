//
//  registroScene.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "registroScene.h"
#import "MusicScene.h"


@implementation registroScene


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	registroScene *layer = [registroScene node];
    
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        
        size = [[CCDirector sharedDirector] winSize];
        
        cortinasLayer= [CCLayer node];
        backGroundLayer= [CCLayer node];
        inputsLayer= [CCLayer node];

        
        cortina = [CCSprite spriteWithFile:@"1.png" ];
        cortina.position = ccp(size.width/2,size.height/2);
        [cortinasLayer addChild:cortina];
        
        
        
        
        [self addChild:backGroundLayer];
        [self addChild:inputsLayer];
        [self addChild:cortinasLayer];


        
        [self BuildBackground];
        [self abreCortinas];
        [self BuildInputs];

    }
	return self;
}

-(void) BuildBackground
{
    
    background = [CCSprite spriteWithFile:@"registro-app.png"];
    background.position = ccp(size.width/2, size.height/2);
    //background.rotation=90;
    [backGroundLayer addChild:background];
    

    
}


- (void) abreCortinas
{
    

    
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,size.height+(size.height/2))
                     ];
    [cortinasLayer runAction:[CCSequence actions:actionMove,nil]];
}



-(void)BuildInputs
{

    textName=[[UITextField alloc]init];
    textName.backgroundColor=[UIColor whiteColor];
    [textName setFont:[UIFont fontWithName:@"OCRAEXT" size:14]];
    textName.adjustsFontSizeToFitWidth = YES;
    textName.returnKeyType = UIReturnKeyDone;
	WrapperName = [CCUIViewWrapper wrapperForUIView:textName];
    WrapperName.contentSize = CGSizeMake(250, 30);
    WrapperName.rotation=90;
   
    textMail=[[UITextField alloc]init];
    textMail.backgroundColor=[UIColor whiteColor];
    [textMail setFont:[UIFont fontWithName:@"OCRAEXT" size:14]];
    textMail.adjustsFontSizeToFitWidth = YES;
    textMail.returnKeyType = UIReturnKeyDone;

	WrapperMail = [CCUIViewWrapper wrapperForUIView:textMail];
    WrapperMail.contentSize = CGSizeMake(250, 30);
    WrapperMail.rotation=90;
    
    dia=[[UITextField alloc]init];
    dia.backgroundColor=[UIColor whiteColor];
    [dia setFont:[UIFont fontWithName:@"OCRAEXT" size:14]];
    dia.adjustsFontSizeToFitWidth = YES;
    dia.returnKeyType = UIReturnKeyDone;

	WrapperDia = [CCUIViewWrapper wrapperForUIView:dia];
    WrapperDia.contentSize = CGSizeMake(40, 30);
    WrapperDia.rotation=90;
    
    mes=[[UITextField alloc]init];
    mes.backgroundColor=[UIColor whiteColor];
    [mes setFont:[UIFont fontWithName:@"OCRAEXT" size:14]];
    mes.adjustsFontSizeToFitWidth = YES;
    mes.returnKeyType = UIReturnKeyDone;

	WrapperMes = [CCUIViewWrapper wrapperForUIView:mes];
    WrapperMes.contentSize = CGSizeMake(40, 30);
    WrapperMes.rotation=90;
    
    anio=[[UITextField alloc]init];
    anio.backgroundColor=[UIColor whiteColor];
    [anio setFont:[UIFont fontWithName:@"OCRAEXT" size:14]];
    anio.adjustsFontSizeToFitWidth = YES;
    anio.returnKeyType = UIReturnKeyDone;

	WrapperAnio = [CCUIViewWrapper wrapperForUIView:anio];
    WrapperAnio.contentSize = CGSizeMake(40, 30);
    WrapperAnio.rotation=90;
    
    
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendButton addTarget:self action:@selector(validarRegistro:) forControlEvents:UIControlEventTouchDown];
    //sendButton.backgroundColor=[UIColor whiteColor];
    sendButton.opaque=FALSE;
    
    WrapperSend = [CCUIViewWrapper wrapperForUIView:sendButton];
    WrapperSend.contentSize = CGSizeMake(80, 30);
    WrapperSend.rotation=90;

    
    
    
    WrapperName.position=ccp(208, size.height/2);
    WrapperMail.position=ccp(42, size.height/2);
    WrapperDia.position=ccp(228, 590);
    WrapperMes.position=ccp(228, 520);
    WrapperAnio.position=ccp(228, 440);
    WrapperSend.position=ccp(68, 487);
    
    
	[inputsLayer addChild:WrapperName];
	[inputsLayer addChild:WrapperDia];
	[inputsLayer addChild:WrapperMes];
	[inputsLayer addChild:WrapperAnio];
	[inputsLayer addChild:WrapperMail];
    [inputsLayer addChild:WrapperSend];
}

-(IBAction) validarRegistro:(id)sender{
    if( textName.text.length <= 0 ||
       textMail.text.length <= 0 ||
       dia.text.length <= 0 ||
       mes.text.length <= 0 ||
       anio.text.length <= 0 )
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Crazy Fred"
                                                        message:@"Todos los datos son obligatorios para jugar."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        usuario = [[NSMutableDictionary alloc]init];
        [usuario setObject:textName.text forKey:@"nombre"];
        [usuario setObject:dia.text forKey:@"dia"];
        [usuario setObject:mes.text forKey:@"mes"];
        [usuario setObject:anio.text forKey:@"anio"];
        [usuario setObject:textMail.text forKey:@"nombre"];
        
        //registroContenedor.hidden = YES;
        
        //mostrarFlechas = true;
        [self enviarDatos];
    }
}


-(void)enviarDatos{
    MFMailComposeViewController *emailpicker = [[MFMailComposeViewController alloc] init];
	
   // emailpicker.mailComposeDelegate = self;
	
    [emailpicker setSubject:@"BASE de datos"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:usuariosRegistrados];
    [emailpicker addAttachmentData:data mimeType:@"plist" fileName:@"BASEDEDATOS.plist"];
    
    
    // Fill out the email body text
    NSString *emailBody = @"Attached PLIST file";
    [emailpicker setMessageBody:emailBody isHTML:NO];
    
    
    [self cierraCortinas];
    //[self presentModalViewController:emailpicker animated:YES];
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    UIAlertView *alert;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            
            break;
        case MFMailComposeResultSaved:
            
            
            break;
        case MFMailComposeResultSent:
            alert = [[UIAlertView alloc] initWithTitle:@"TECATE"
                                               message:@"Base de datos Enviada Correctamente"
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            
            [alert show];
            break;
        case MFMailComposeResultFailed:
            
            break;
        default:
            
            
            break;
            
    }
    [controller dismissModalViewControllerAnimated:true];
}
- (void) cierraCortinas
{
    
    
    id actionMove = [CCMoveTo actionWithDuration:2
                                        position:ccp(0,0)
                     ];
    id done=[CCCallFunc actionWithTarget:self selector:@selector(Replace)];
    [cortinasLayer runAction:[CCSequence actions:actionMove,done ,nil]];
    
}


-(void) Replace
{
    
    [[CCDirector sharedDirector] replaceScene:[MusicScene scene]];
    //[[CCDirector sharedDirector] replaceScene:[registroScene scene]];
}
- (void) dealloc
{
    
	[super dealloc];
}
@end
