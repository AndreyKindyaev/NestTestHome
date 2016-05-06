//
//  NSDate+SCNAppDates.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "NSDate+SCNAppDates.h"

#import "NSDateFormatter+SCNNest.h"

@implementation NSDate (SCNAppDates)

- (NSString *)scnUIString {
    return [[NSDateFormatter scnUIDateFormatter] stringFromDate:self];
}

@end
