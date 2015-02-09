//
//  TwitterClient.m
//  TwitterApp
//
//  Created by Prasannakumar Jobigenahally on 2/7/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"jY8wiVYgMaK5X6e0OD3PzCGyD";
NSString * const kTwitterConsumerSecret = @"UyYHEihHgqSrdms9S53DiMldar6V3QJC3irJipZIs6ys5xUOdm";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com/";


@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
            
        }
        
    });
    
    
    return instance;
}

@end
