//
//  SCNNestSmokeCOAlarm.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestSmokeCOAlarm.h"

@implementation SCNNestSmokeCOAlarm

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *dictionary = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    [dictionary addEntriesFromDictionary:@{@"locale" : @"locale",
                                           
                                           @"lastConnectionDate" : @"last_connection",
                                           
                                           @"batteryHealthNumber" : @"battery_health",
                                           @"coAlarmStateNumber" : @"co_alarm_state",
                                           @"smokeAlarmStateNumber" : @"smoke_alarm_state",
                                           
                                           @"isManualTestActiveNumber" : @"is_manual_test_active",
                                           @"lastManualTestTime" : @"last_manual_test_time",
                                           
                                           @"uiColorStateNumber" : @"ui_color_state"}];
    return dictionary;
}

+ (NSValueTransformer *)lastConnectionDateJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)batteryHealthNumberJSONTransformer {
    NSDictionary *dictionary = @{@"ok": @(SCNNestBatteryHealthOk),
                                 @"replace": @(SCNNestBatteryHealthReplace)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)coAlarmStateNumberJSONTransformer {
    NSDictionary *dictionary = @{@"ok": @(SCNNestCOAlarmStateOk),
                                 @"warning": @(SCNNestCOAlarmStateWarning),
                                 @"emergency": @(SCNNestCOAlarmStateEmergency)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)smokeAlarmStateNumberJSONTransformer {
    NSDictionary *dictionary = @{@"ok": @(SCNNestSmokeAlarmStateOk),
                                 @"warning": @(SCNNestSmokeAlarmStateWarning),
                                 @"emergency": @(SCNNestSmokeAlarmStateEmergency)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)lastManualTestTimeJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)uiColorStateNumberJSONTransformer {
    NSDictionary *dictionary = @{@"gray": @(SCNNestAlarmColorStateGray),
                                 @"green": @(SCNNestAlarmColorStateGreen),
                                 @"yellow": @(SCNNestAlarmColorStateYellow),
                                 @"red": @(SCNNestAlarmColorStateRed)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

@end
