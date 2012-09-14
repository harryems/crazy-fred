//
//  RegistrationViewController.m
//  box3
//
//  Created by hb on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegistrationViewController.h"
#import "MainMenuViewController.h"
#import "SquareCamAppDelegate.h"
#import "Twitter/Twitter.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize RegistrationField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [RegistrationField setDelegate:self];
    
    UIImageView* rotateDeviceView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [rotateDeviceView setImage:[UIImage imageNamed:@"marco-contenidos1"]];
    rotateDeviceView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UILabel* message = [[UILabel alloc]initWithFrame:self.view.bounds];
    
    message.textAlignment = UITextAlignmentCenter ;
    message.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [message setBackgroundColor:[UIColor clearColor]];
    [message setText:@"Rotate Device to begin"];
    
    [message setFont:[UIFont fontWithName:@"VTCSuperMarketSaleSC" size:20]];
    
    [rotateDeviceView addSubview:message];
    
    [self.view addSubview:rotateDeviceView];
    [message release];
    rotateDeviceView.tag = 99;
    
    [rotateDeviceView release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    SquareCamAppDelegate *appDelegate = (SquareCamAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.userName = [RegistrationField text];
    
    [RegistrationField resignFirstResponder];
    return NO;
}

- (void)viewDidUnload
{
    [self setRegistrationField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    if( UIInterfaceOrientationIsPortrait(fromInterfaceOrientation))
    {
        [[self.view viewWithTag:99] removeFromSuperview];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (UIInterfaceOrientationIsLandscape(interfaceOrientation) );
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if( buttonIndex == 1){
        FBRequestConnection *algo = [[FBRequestConnection alloc] init];
        [algo addRequest:[FBRequest requestForPostStatusUpdate:@"I´m Boxing Right now!!!"] completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if( error ){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"I'm Boxing"
                                                                message:@"An error ocurred when posting. Try again later."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"I'm Boxing"
                                                                message:@"Status updated correctly"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                [alert release];
            }
        } ];
        [algo start];
        [algo release];
        
    }
    
}

-(IBAction)socialFacebook:(id)sender{
    
    [FBSession sessionOpenWithPermissions:[NSArray arrayWithObjects:@"publish_actions", nil]
                        completionHandler:^(FBSession *session, 
                                            FBSessionState status, 
                                            NSError *error) {
                            if (session.isOpen) {
                                
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"I'm Boxing"
                                                                                message:@"post status in facebook?"
                                                                               delegate:self
                                                                      cancelButtonTitle:@"CANCEL"
                                                                      otherButtonTitles:@"YES",nil];
                                [alert show];
                                [alert release];
                                
                                
                                
                                
                                
                            }
                        }];
}

-(IBAction)socialTweet:(id)sender{
    //  Create an instance of the Tweet Sheet
    TWTweetComposeViewController *tweetSheet = 
    [[TWTweetComposeViewController alloc] init];
    
    // Sets the completion handler.  Note that we don't know which thread the
    // block will be called on, so we need to ensure that any UI updates occur
    // on the main queue
    tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        switch(result) {
            case TWTweetComposeViewControllerResultCancelled:
                //  This means the user cancelled without sending the Tweet
                break;
            case TWTweetComposeViewControllerResultDone:
                //  This means the user hit 'Send'
                break;
        }
        
        
        //  dismiss the Tweet Sheet 
        dispatch_async(dispatch_get_main_queue(), ^{            
            [self dismissViewControllerAnimated:NO completion:^{
                NSLog(@"Tweet Sheet has been dismissed."); 
            }];
        });
    };
    
    //  Set the initial body of the Tweet
    [tweetSheet setInitialText:@"I´m Boxing Right now!!!"]; 
    
    //  Adds an image to the Tweet
    //  For demo purposes, assume we have an image named 'larry.png'
    //  that we wish to attach
    if (![tweetSheet addImage:[UIImage imageNamed:@"Default.png"]]) {
        NSLog(@"Unable to add the image!");
    }
    
    //  Add an URL to the Tweet.  You can add multiple URLs.
    if (![tweetSheet addURL:[NSURL URLWithString:@"http://www.kreativeco.com/"]]){
        NSLog(@"Unable to add the URL!");
    }
    
    //  Presents the Tweet Sheet to the user
    [self presentViewController:tweetSheet animated:NO completion:^{
        NSLog(@"Tweet sheet has been presented.");
    }];
    
    [tweetSheet release];
}

-(IBAction)goNextScreen:(id)sender{
    [self dismissViewControllerAnimated:true completion:NULL];
}

- (void)dealloc {
    [RegistrationField release];
    [super dealloc];
}
@end
