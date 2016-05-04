//
//  UITableView+SCNUtils.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "UITableView+SCNUtils.h"

@implementation UITableView (SCNUtils)

- (void)scnHideEmptySeparators {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

@end
