//
//  SCNReplaceSegue.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/3/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNReplaceSegue.h"

@implementation SCNReplaceSegue

- (void)perform {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = self.destinationViewController;
}

@end
