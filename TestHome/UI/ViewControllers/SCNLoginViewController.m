//
//  SCNLoginViewController.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNLoginViewController.h"

#import "SCNNestAuthManager.h"

static NSString *const kCodeKey = @"code";

@interface SCNLoginViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SCNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (nil != [SCNNestAuthManager sharedInstance].validToken) {
        [self _switchToCamera];
    } else {
        [self _loadAuthUrl];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL shouldStartLoad = YES;
    NSURL *url = [request URL];
    SCNNestAuthManager *authManager = [SCNNestAuthManager sharedInstance];
    if ([authManager isRedirectUrl:url]) {
        self.webView.userInteractionEnabled = NO;
        shouldStartLoad = NO;
        NSString *query = url.query;
        NSArray *queryComponents = [query componentsSeparatedByString:@"&"];
        __block NSString *authCode = nil;
        [queryComponents enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *components = [obj componentsSeparatedByString:@"="];
            if (components.count == 2 &&
                [components[0] isEqualToString:kCodeKey]) {
                authCode = components[1];
                *stop = YES;
            }
        }];
        if (nil != authCode) {
            __weak typeof(self) weakSelf = self;
            [authManager getTokenByAuthCode:authCode completion:^(NSError *error) {
                if (nil != error) {
                    SCNLog(@"can't get auth token by code:%@", authCode);
                    [weakSelf _loadAuthUrl];
                } else {
                    [weakSelf _switchToCamera];
                }
            }];
        } else {
            SCNLog(@"oops, something went wrong. redirect url doesn't contain auth code");
            [self _loadAuthUrl];
        }
    }
    return shouldStartLoad;
}

#pragma mark - Private
- (void)_loadAuthUrl {
    NSString *authUrl = [SCNNestAuthManager sharedInstance].webAuthUrl;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:authUrl]];
    [self.webView loadRequest:request];
    self.webView.userInteractionEnabled = YES;
}

- (void)_switchToCamera {
    [self performSegueWithIdentifier:@"SCNLoginToMain" sender:self];
}

@end
