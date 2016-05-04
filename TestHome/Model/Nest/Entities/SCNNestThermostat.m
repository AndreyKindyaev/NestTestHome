//
//  SCNNestThermostat.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestThermostat.h"

#import "MTLValueTransformer+SCNNest.h"

@implementation SCNNestThermostat

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *dictionary = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    [dictionary addEntriesFromDictionary:@{@"locale" : @"locale",
                                           
                                           @"lastConnection" : @"last_connection",
                                           
                                           @"canCool" : @"can_cool",
                                           @"canHeat" : @"can_heat",
                                           @"isUsingEmergencyHeat" : @"is_using_emergency_heat",
                                           @"hasFan" : @"has_fan",
                                           @"fanTimerActive" : @"fan_timer_active",
                                           @"fanTimerTimeout" : @"fan_timer_timeout",
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

+ (NSValueTransformer *)lastConnectionJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)fanTimerTimeoutJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)temperatureScaleJSONTransformer {
    NSDictionary *dictionary = @{@"F": @(SCNNestTemperatureScaleF),
                                 @"C": @(SCNNestTemperatureScaleC)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)hvacModeJSONTransformer {
    NSDictionary *dictionary = @{@"heat": @(SCNNestHVACModeHeat),
                                 @"cool": @(SCNNestHVACModeCool),
                                 @"heat-cool": @(SCNNestHVACModeHeatCool),
                                 @"off": @(SCNNestHVACModeOff)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)hvacStateJSONTransformer {
    NSDictionary *dictionary = @{@"heating": @(SCNNestHVACStateHeating),
                                 @"cooling": @(SCNNestHVACStateCooling),
                                 @"off": @(SCNNestHVACStateOff)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

@end
