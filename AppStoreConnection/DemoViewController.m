//
//  DemoViewController.m
//  AppStoreConnection
//
//  Created by Pratiksha Bhisikar on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DemoViewController.h"
#import "AppStoreConnectionHandler.h"

NSString *const blackjackURL = @"http://itunes.apple.com/us/app/hello-kitty-blackjack/id482503667";
NSString *const invalidURL = @"Put some invalid URL here.";

@implementation DemoViewController

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView *rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    UIButton *sampleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sampleButton.frame = CGRectMake(rootView.bounds.size.width/2 - 75.0f, rootView.bounds.size.height/2 - 15.0f, 150.0f, 30.0f);
    [sampleButton setTitle:@"Blackjack URL" forState:UIControlStateSelected];
    [sampleButton setTitle:@"Invalid URL" forState:UIControlStateNormal];
    [sampleButton addTarget:self action:@selector(sampleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:sampleButton];
    
    self.view = rootView;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Action Methods

-(void) sampleButtonPressed:(id) sender {
    UIButton *button = (UIButton *) sender;
    
    NSString *appURL = nil;
    if (button.selected == NO) {
        appURL = invalidURL;
    }else {
        appURL = blackjackURL;
    }
    
    button.selected = !button.selected;
    
    AppStoreConnectionHandler *appStoreConnection = [[AppStoreConnectionHandler alloc] init];
    [appStoreConnection initiateConnectionForAppURL:[NSURL URLWithString:appURL] withCompletionBlock:^(NSURL *appURL, BOOL finished, NSError *error){
        if (finished) {
            BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:appURL];
            if (canOpenURL) {
                [[UIApplication sharedApplication] openURL:appURL];
            }else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Application cannot open the URL" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }else {
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
    }];
}

@end
