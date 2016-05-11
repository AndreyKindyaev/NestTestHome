//
//  SCNNestThermostat.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestThermostat.h"

@implementation SCNNestThermostat

- (NSArray<NSString *> *)propertiesArrayForTargetTemperature {
    NSMutableArray *propertiesArray = [NSMutableArray new];
    switch ((SCNNestTemperatureScale)self.temperatureScaleNumber.integerValue) {
        case SCNNestTemperatureScaleC:
            [propertiesArray addObject:@"targetTemperatureCNumber"];
            break;
        case SCNNestTemperatureScaleF:
            [propertiesArray addObject:@"targetTemperatureFNumber"];
            break;
        default:
            break;
    }
    return propertiesArray;
}

- (NSArray<NSString *> *)propertiesArrayForTargetTemperatureHighLow {
    NSMutableArray *propertiesArray = [NSMutableArray new];
    switch ((SCNNestTemperatureScale)self.temperatureScaleNumber.integerValue) {
        case SCNNestTemperatureScaleC:
            [propertiesArray addObjectsFromArray:@[@"targetTemperatureHighCNumber",
                                                   @"targetTemperatureLowCNumber"]];
            break;
        case SCNNestTemperatureScaleF:
            [propertiesArray addObjectsFromArray:@[@"targetTemperatureHighFNumber",
                                                   @"targetTemperatureLowFNumber"]];
            break;
        default:
            break;
    }
    return propertiesArray;
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *dictionary = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    [dictionary addEntriesFromDictionary:@{@"locale" : @"locale",
                                           
                                           @"lastConnectionDate" : @"last_connection",
                                           
                                           @"canCoolNumber" : @"can_cool",
                                           @"canHeatNumber" : @"can_heat",
                                           @"isUsingEmergencyHeatNumber" : @"is_using_emergency_heat",
                                           @"hasFanNumber" : @"has_fan",
                                           @"fanTimerActiveNumber" : @"fan_timer_active",
                                           @"fanTimerTimeout" : @"fan_timer_timeout",
                                           @"hasLeafNumber" : @"has_leaf",
                                           
                                           @"temperatureScaleNumber" : @"temperature_scale",
                                           
                                           @"targetTemperatureFNumber" : @"target_temperature_f",
                                           @"targetTemperatureHighFNumber" : @"target_temperature_high_f",
                                           @"targetTemperatureLowFNumber" : @"target_temperature_low_f",
                                           @"awayTemperatureHighFNumber" : @"away_temperature_high_f",
                                           @"awayTemperatureLowFNumber" : @"away_temperature_low_f",
                                           @"ambientTemperatureFNumber" : @"ambient_temperature_f",
                                           
                                           @"targetTemperatureCNumber" : @"target_temperature_c",
                                           @"targetTemperatureHighCNumber" : @"target_temperature_high_c",
                                           @"targetTemperatureLowCNumber" : @"target_temperature_low_c",
                                           @"awayTemperatureHighCNumber" : @"away_temperature_high_c",
                                           @"awayTemperatureLowCNumber" : @"away_temperature_low_c",
                                           @"ambientTemperatureCNumber" : @"ambient_temperature_c",
                                           
                                           @"hvacModeNumber" : @"hvac_mode",
                                           @"hvacStateNumber" : @"hvac_state",
                                           
                                           @"humidityNumber" : @"humidity"}];
    return dictionary;
}

+ (NSValueTransformer *)lastConnectionDateJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)fanTimerTimeoutJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)temperatureScaleNumberJSONTransformer {
    NSDictionary *dictionary = @{@"F": @(SCNNestTemperatureScaleF),
                                 @"C": @(SCNNestTemperatureScaleC)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)hvacModeNumberJSONTransformer {
    NSDictionary *dictionary = @{@"heat": @(SCNNestHVACModeHeat),
                                 @"cool": @(SCNNestHVACModeCool),
                                 @"heat-cool": @(SCNNestHVACModeHeatCool),
                                 @"off": @(SCNNestHVACModeOff)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)hvacStateNumberJSONTransformer {
    NSDictionary *dictionary = @{@"heating": @(SCNNestHVACStateHeating),
                                 @"cooling": @(SCNNestHVACStateCooling),
                                 @"off": @(SCNNestHVACStateOff)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

@end
