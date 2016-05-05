//
//  UIViewController+SCNAlerts.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "UIViewController+SCNAlerts.h"

@implementation UIViewController (SCNAlerts)

- (void)scnShowAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                      okTitle:(NSString *)okTitle
                      okBlock:(void (^)())okBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:
                               ^(UIAlertAction * _Nonnull action) {
                                   if (nil != okBlock) {
                                       okBlock();
                                   }
                               }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
