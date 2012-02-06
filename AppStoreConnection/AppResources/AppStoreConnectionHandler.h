//
//  AppStoreConnectionHandler.h
//  AppStoreConnection
//
//  Created by Pratiksha Bhisikar on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef void (^appStoreConnectionCompletionHandler)(NSURL *appURL, BOOL finished, NSError *error);

@interface AppStoreConnectionHandler : NSObject {
    NSURL *iTunesURL;
    appStoreConnectionCompletionHandler completionHandler;
}

- (void) initiateConnectionForAppURL:(NSURL *) appURL withCompletionBlock:(appStoreConnectionCompletionHandler) completionBlock;

@end
