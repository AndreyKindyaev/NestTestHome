//
//  SCNNestSmokeCOAlarm.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestSmokeCOAlarm.h"

#import "MTLValueTransformer+SCNNest.h"

@implementation SCNNestSmokeCOAlarm

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *dictionary = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    [dictionary addEntriesFromDictionary:@{@"locale" : @"locale",
                                           
                                           @"lastConnection" : @"last_connection",
                                           
                                           @"batteryHealth" : @"battery_health",
                                           @"coAlarmState" : @"co_alarm_state",
                                           @"smokeAlarmState" : @"smoke_alarm_state",
                                           
                                           @"isManualTestActive" : @"is_manual_test_active",
                                           @"lastManualTestTime" : @"last_manual_test_time",
                                           
                                           @"uiColorState" : @"ui_color_state",
                                           
                                           @"hasLeaf" : @"has_leaf",
                                           
                                           @"temperatureScale" : @"temperature_scale",
                                           
                                           @"targetTemparatureF" : @"target_temperature_f",
                                           @"targetTemperatureHighF" : @"target_temperature_high_f",
                                           @"targetTemperatureLowF" : @"target_temperature_low_f",
                                           @"awayTemperatureHighF" : @"away_temperature_high_f",
                                           @"awayTemperatureLowF" : @"away_temperature_low_f",
                                           @"ambientTemperatureF" : @"ambient_temperature_f",
                                           
                                           @"targetTemparatureC" : @"target_temperature_c",
                                           @"targetTemperatureHighC" : @"target_temperature_high_c",
                                           @"targetTemperatureLowC" : @"target_temperature_low_c",
                                           @"awayTemperatureHighC" : @"away_temperature_high_c",
                                           @"awayTemperatureLowC" : @"away_temperature_low_c",
                                           @"ambientTemperatureC" : @"ambient_temperature_c",
                                           
                                           @"hvacMode" : @"hvac_mode",
                                           @"hvacState" : @"hvac_state",
                                           
                                           @"humidity" : @"humidity"}];
    return dictionary;
}

+ (NSValueTransformer *)batteryHealthJSONTransformer {
    NSDictionary *dictionary = @{@"ok": @(SCNNestBatteryHealthOk),
                                 @"replace": @(SCNNestBatteryHealthReplace)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)coAlarmStateJSONTransformer {
    NSDictionary *dictionary = @{@"ok": @(SCNNestCOAlarmStateOk),
                                 @"warning": @(SCNNestCOAlarmStateWarning),
                                 @"emergency": @(SCNNestCOAlarmStateEmergency)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)smokeAlarmStateJSONTransformer {
    NSDictionary *dictionary = @{@"ok": @(SCNNestSmokeAlarmStateOk),
                                 @"warning": @(SCNNestSmokeAlarmStateWarning),
                                 @"emergency": @(SCNNestSmokeAlarmStateEmergency)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)lastManualTestTimeJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)uiColorStateJSONTransformer {
    NSDictionary *dictionary = @{@"gray": @(SCNNestAlarmColorStateGray),
                                 @"green": @(SCNNestAlarmColorStateGreen),
                                 @"yellow": @(SCNNestAlarmColorStateYellow),
                                 @"red": @(SCNNestAlarmColorStateRed)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

@end
