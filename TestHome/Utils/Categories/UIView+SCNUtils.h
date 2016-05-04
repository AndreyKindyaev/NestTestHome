//
//  UIView+SCNUtils.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCNUtils)

+ (id)scnViewFromXib;

- (void)scnAddFullSizeView:(UIView *)view;

@end
