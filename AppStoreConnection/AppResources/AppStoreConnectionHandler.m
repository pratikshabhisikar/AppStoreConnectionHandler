//
//  AppStoreConnectionHandler.m
//  AppStoreConnection
//
//  Created by Pratiksha Bhisikar on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppStoreConnectionHandler.h"

@implementation AppStoreConnectionHandler

#pragma mark - Private methods

- (void)openReferralURL:(NSURL *) referralURL {
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:referralURL] delegate:self];
    if (!connection) {
        NSError *connectionInitiationError = [NSError errorWithDomain:@"com.appstoreconnection.error" code:NSURLErrorUnknown userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Cannot initiate connection", NSLocalizedDescriptionKey, nil]];
        completionHandler(iTunesURL, NO, connectionInitiationError);
    }
}

#pragma mark - NSURLConnection delegates

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    completionHandler(iTunesURL, YES, nil);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	completionHandler(iTunesURL, NO, error);
}

#pragma mark - Public Methods

- (void) initiateConnectionForAppURL:(NSURL *) appURL withCompletionBlock:(appStoreConnectionCompletionHandler) completionBlock {
    completionHandler = [completionBlock copy];
    if (appURL) {
        iTunesURL = appURL;
        [self openReferralURL:iTunesURL];
    }else {
        NSError *invalidAppURLError = [NSError errorWithDomain:@"com.appstoreconnection.error" code:NSURLErrorBadURL userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Invalid URL", NSLocalizedDescriptionKey, nil]];
        completionHandler(appURL, NO, invalidAppURLError);
    }
}

@end
