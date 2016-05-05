//
//  UIViewController+SCNAlerts.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SCNAlerts)

- (void)scnShowAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                      okTitle:(NSString *)okTitle
                      okBlock:(void (^)())okBlock;

@end
