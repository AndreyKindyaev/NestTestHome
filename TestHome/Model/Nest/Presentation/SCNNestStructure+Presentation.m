//
//  SCNNestStructure+Presentation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/12/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestStructure+Presentation.h"

@implementation SCNNestStructure (Presentation)

- (NSString *)awayString {
    NSString *awayString = nil;
    switch (self.away) {
        case SCNNestAwayStateAutoAway:
            awayString = @"Auto away";
            break;
        case SCNNestAwayStateAway:
            awayString = @"Away";
            break;
        case SCNNestAwayStateHome:
            awayString = @"Home";
            break;
        case SCNNestAwayStateUnknown:
            awayString = @"Unknown";
            break;
        default:
            break;
    }
    return awayString;
}

- (UIColor *)awayColor {
    return [self.class colorForAwayState:self.away];
}

+ (UIColor *)colorForAwayState:(SCNNestAwayState)state {
    UIColor *color = [UIColor whiteColor];
    switch (state) {
        case SCNNestAwayStateAway:
            color = [UIColor grayColor];
            break;
        case SCNNestAwayStateHome:
            color = [UIColor greenColor];
            break;
        default:
            break;
    }
    return color;
}

@end
