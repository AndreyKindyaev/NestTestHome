//
//  NSString+SCNNest.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "NSString+SCNNest.h"

#import "NSDateFormatter+SCNNest.h"

@implementation NSString (SCNNest)

- (NSDate *)scnNestDate {
    return [[NSDateFormatter scnNestDateFormatter] dateFromString:self];
}

@end
