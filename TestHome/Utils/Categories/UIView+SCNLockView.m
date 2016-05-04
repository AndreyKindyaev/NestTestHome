//
//  UIView+SCNLockView.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "UIView+SCNLockView.h"

#import "UIView+SCNUtils.h"

#import <objc/runtime.h>
#import "SCNLockView.h"

static void *kLockViewKey = @"SCNLockViewKey";

@implementation UIView (SCNLockView)

- (void)scnShowLockViewWithText:(NSString *)text {
    [self scnHideLockView];
    SCNLockView *lockView = [SCNLockView viewWithTitle:text];
    [self _scnSetLockView:lockView];
    if ([self isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self).scrollEnabled = NO;
        [((UIScrollView *)self) setContentOffset:((UIScrollView *)self).contentOffset
                                        animated:NO];
    }
    [self scnAddFullSizeView:lockView];
}

- (void)scnHideLockView {
    SCNLockView *lockView = [self _scnLockView];
    if ([self isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self).scrollEnabled = YES;
    }
    [lockView removeFromSuperview];
}

#pragma mark - Private
- (SCNLockView *)_scnLockView {
    return objc_getAssociatedObject(self, kLockViewKey);
}

- (void)_scnSetLockView:(SCNLockView *)lockView {
    objc_setAssociatedObject(self, kLockViewKey, lockView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
