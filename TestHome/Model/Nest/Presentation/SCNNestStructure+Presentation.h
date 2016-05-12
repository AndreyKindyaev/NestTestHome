//
//  SCNNestStructure+Presentation.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/12/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestStructure.h"

@interface SCNNestStructure (Presentation)

- (NSString *)awayString;
- (UIColor *)awayColor;

+ (UIColor *)colorForAwayState:(SCNNestAwayState)state;

@end
