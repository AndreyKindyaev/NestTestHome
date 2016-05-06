//
//  SCNNestSmokeCOAlarm+Presentation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestSmokeCOAlarm+Presentation.h"

#import "SCNNilObjectValueTransformer.h"

@implementation SCNNestSmokeCOAlarm (Presentation)

- (UIColor *)color {
    return [SCNNilObjectValueTransformer transformedValue:self.uiColorStateNumber
                                     usingForwardNilValue:[UIColor whiteColor]
                                             forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return [self _colorByState:value.integerValue];
            }];
}

- (NSString *)batteryHealthString {
    return [self _stringForValue:self.batteryHealthNumber
                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return [self _batteryHealtsStringByState:value.integerValue];
            }];
}

- (NSString *)coAlarmStateString {
    return [self _stringForValue:self.coAlarmStateNumber
                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return [self _coAlarmStringByState:value.integerValue];
            }];
}

- (NSString *)smokeAlarmStateString {
    return [self _stringForValue:self.smokeAlarmStateNumber
                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return [self _smokeAlarmStringByState:value.integerValue];
            }];
}

- (NSString *)manualTestActiveString {
    return [self _stringForValue:self.isManualTestActiveNumber
                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return value.boolValue ? @"Active" : @"Inactive";
            }];
}

- (NSString *)lastConnectionDateString {
    return [self _stringForDate:self.lastConnectionDate];
}

- (NSString *)lastManualTestTimeString {
    return [self _stringForDate:self.lastManualTestTime];
}

#pragma mark - Private
- (NSString *)_stringForValue:(id)value forwardBlock:(MTLValueTransformerBlock)forwardBlock {
    return [SCNNilObjectValueTransformer transformedValue:value
                                     usingForwardNilValue:@"Unknown"
                                             forwardBlock:forwardBlock];
}

- (NSString *)_stringForDate:(NSDate *)date {
    return [self _stringForValue:date
                    forwardBlock:
            ^id(NSDate *value, BOOL *success, NSError *__autoreleasing *error) {
                return value.scnUIString;
            }];
}

- (UIColor *)_colorByState:(SCNNestAlarmColorState)state {
    UIColor *color = nil;
    switch (state) {
        case SCNNestAlarmColorStateGray:
            color = [UIColor grayColor];
            break;
        case SCNNestAlarmColorStateGreen:
            color = [UIColor greenColor];
            break;
        case SCNNestAlarmColorStateRed:
            color = [UIColor redColor];
            break;
        case SCNNestAlarmColorStateYellow:
            color = [UIColor yellowColor];
            break;
        default:
            break;
    }
    return color;
}

- (NSString *)_batteryHealtsStringByState:(SCNNestBatteryHealth)state {
    NSString *string = nil;
    switch (state) {
        case SCNNestBatteryHealthOk:
            string = @"Ok";
            break;
        case SCNNestBatteryHealthReplace:
            string = @"Replace";
            break;
        default:
            break;
    }
    return string;
}

- (NSString *)_coAlarmStringByState:(SCNNestCOAlarmState)state {
    NSString *string = nil;
    switch (state) {
        case SCNNestCOAlarmStateOk:
            string = @"Ok";
            break;
        case SCNNestCOAlarmStateWarning:
            string = @"Warning";
            break;
        case SCNNestCOAlarmStateEmergency:
            string = @"Emergency";
            break;
        default:
            break;
    }
    return string;
}

- (NSString *)_smokeAlarmStringByState:(SCNNestSmokeAlarmState)state {
    NSString *string = nil;
    switch (state) {
        case SCNNestSmokeAlarmStateOk:
            string = @"Ok";
            break;
        case SCNNestSmokeAlarmStateWarning:
            string = @"Warning";
            break;
        case SCNNestCOAlarmStateEmergency:
            string = @"Emergency";
            break;
        default:
            break;
    }
    return string;
}

@end
