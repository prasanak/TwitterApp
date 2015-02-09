//
//  TwitterClient.m
//  TwitterApp
//
//  Created by Prasannakumar Jobigenahally on 2/7/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"jY8wiVYgMaK5X6e0OD3PzCGyD";
NSString * const kTwitterConsumerSecret = @"UyYHEihHgqSrdms9S53DiMldar6V3QJC3irJipZIs6ys5xUOdm";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com/";

@interface TwitterClient ()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

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

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];

    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"prasannatwitterapp://oath"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got the request token");
        
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError *error) {
        NSLog(@"failed to get the request token: %@", error);
        self.loginCompletion(nil, error);

    }];
    
}

- (void)openURL:(NSURL*)url {
    
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Got the access token");
        
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"Current user: %@", responseObject);
            
            User *user = [[User alloc] initWithDictionary:responseObject];
            
            [User setCurrentUser:user];
            
            NSLog(@"Current user: %@", user.name);
            self.loginCompletion(user, nil);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to get current user");
            self.loginCompletion(nil, error);
        }];
        
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the access token");
        self.loginCompletion(nil, error);
    }];
}

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}


@end
