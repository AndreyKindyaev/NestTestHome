//
//  UIView+SCNLockView.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCNLockView)

- (void)scnShowLockViewWithText:(NSString *)text;
- (void)scnHideLockView;

@end