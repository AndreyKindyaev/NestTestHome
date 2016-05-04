//
//  UIView+SCNUtils.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "UIView+SCNUtils.h"

@implementation UIView (SCNUtils)

+ (id)scnViewFromXib {
    return [self _viewFromNib:NSStringFromClass([self class]) owner:self];
}

- (void)scnAddFullSizeView:(UIView *)view {
    return [self _scnAddFullSizeView:view withEdgeInsets:UIEdgeInsetsZero];
}

#pragma mark - Private
+ (id)_viewFromNib:(NSString *)nibName owner:(id)owner {
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    NSArray *views = [nib instantiateWithOwner:owner options:nil];
    id view = nil;
    for (id viewFromNib in views) {
        if ([viewFromNib isKindOfClass:[owner class]]) {
            view = viewFromNib;
            break;
        }
    }
    return view;
}

- (void)_scnAddFullSizeView:(UIView *)view withEdgeInsets:(UIEdgeInsets)insets {
    if (nil != view) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        NSInteger topCorrection = 0;
        [self addSubview:view];
        if ([self isKindOfClass:[UIScrollView class]]) {
            CGSize size = self.bounds.size;
            topCorrection = self.bounds.origin.y;
            [view _scnAddSizeConstraints:size];
        }
        NSString *verticalFormat = [NSString stringWithFormat:@"V:|-(%f)-[view]-(%f)-|", insets.top + topCorrection, insets.bottom];
        NSString *horizontalFormat = [NSString stringWithFormat:@"H:|-(%f)-[view]-(%f)-|", insets.left, insets.right];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalFormat
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"view" : view}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"view" : view}]];
    }
}

- (void)_scnAddSizeConstraints:(CGSize)size {
    [self _scnAddHeightConstraintWithConstant:size.height];
    [self _scnAddWidthConstraintWithConstant:size.width];
}

- (void)_scnAddSizeConstraintForAttribyte:(NSLayoutAttribute)attribute
                             withRelation:(NSLayoutRelation)relation
                                 constant:(CGFloat)constant {
    [self _scnAddSizeConstraintForAttribyte:attribute
                               withRelation:relation
                                   constant:constant
                                   priority:UILayoutPriorityRequired];
}

- (void)_scnAddSizeConstraintForAttribyte:(NSLayoutAttribute)attribute
                             withRelation:(NSLayoutRelation)relation
                                 constant:(CGFloat)constant
                                 priority:(UILayoutPriority)priority {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:attribute
                                                                  relatedBy:relation
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.f
                                                                   constant:constant];
    constraint.priority = priority;
    [self addConstraint:constraint];
}

- (void)_scnAddHeightConstraintWithConstant:(CGFloat)constant
                                   priority:(UILayoutPriority)priority {
    [self _scnAddSizeConstraintForAttribyte:NSLayoutAttributeHeight
                               withRelation:NSLayoutRelationEqual
                                   constant:constant
                                   priority:priority];
}

- (void)_scnAddHeightConstraintWithConstant:(CGFloat)constant {
    [self _scnAddHeightConstraintWithConstant:constant
                                     priority:UILayoutPriorityRequired];
}

- (void)_scnAddWidthConstraintWithConstant:(CGFloat)constant {
    [self _scnAddSizeConstraintForAttribyte:NSLayoutAttributeWidth
                               withRelation:NSLayoutRelationEqual
                                   constant:constant];
}

@end
