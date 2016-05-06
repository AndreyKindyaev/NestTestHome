//
//  UIViewController+SCNErrorAlerts.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "UIViewController+SCNErrorAlerts.h"

@implementation UIViewController (SCNErrorAlerts)

- (void)scnShowAlertWithError:(NSError *)error
                  actionBlock:(void(^)())actionBlock {
    [self scnShowAlertWithTitle:@"Error"
                        message:error.localizedDescription
                        okTitle:@"Ok"
                        okBlock:actionBlock];
}

@end
