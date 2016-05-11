//
//  SCNNestSmokeCOAlarm+Presentation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestSmokeCOAlarm+Presentation.h"

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
    return [SCNNilObjectValueTransformer nilDashesStringForValue:self.batteryHealthNumber
                                                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return [self _batteryHealtsStringByState:value.integerValue];
            }];
}

- (NSString *)coAlarmStateString {
    return [SCNNilObjectValueTransformer nilDashesStringForValue:self.coAlarmStateNumber
                                                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return [self _coAlarmStringByState:value.integerValue];
            }];
}

- (NSString *)smokeAlarmStateString {
    return [SCNNilObjectValueTransformer nilDashesStringForValue:self.smokeAlarmStateNumber
                                                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return [self _smokeAlarmStringByState:value.integerValue];
            }];
}

- (NSString *)manualTestActiveString {
    return [SCNNilObjectValueTransformer nilDashesStringForValue:self.isManualTestActiveNumber
                                                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return value.boolValue ? @"Active" : @"Inactive";
            }];
}

- (NSString *)lastConnectionDateString {
    return [SCNNilObjectValueTransformer nilDashesUIStringForDate:self.lastConnectionDate];
}

- (NSString *)lastManualTestTimeString {
    return [SCNNilObjectValueTransformer nilDashesUIStringForDate:self.lastManualTestTime];
}

#pragma mark - Private
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
