//
//  UIViewController+SCNErrorAlerts.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

@interface UIViewController (SCNErrorAlerts)

- (void)scnShowAlertWithError:(NSError *)error
                  actionBlock:(void(^)())actionBlock;

@end
