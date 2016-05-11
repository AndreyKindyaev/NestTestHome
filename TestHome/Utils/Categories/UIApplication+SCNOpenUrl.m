//
//  UIApplication+SCNOpenUrl.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/6/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "UIApplication+SCNOpenUrl.h"

@implementation UIApplication (SCNOpenUrl)

- (void)scnOpenNestAppUrl:(NSString *)url {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    NSString *urlString = [NSString stringWithFormat:@"%@&appname=%@&backlink=%@", url, appName, @"testhome://"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
