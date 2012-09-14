//
//  RegistrationViewController.h
//  box3
//
//  Created by hb on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *RegistrationField;

-(IBAction)goNextScreen:(id)sender;
-(IBAction)socialTweet:(id)sender;
-(IBAction)socialFacebook:(id)sender;
@end
