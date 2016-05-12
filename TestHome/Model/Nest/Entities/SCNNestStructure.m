//
//  SCNNestStructure.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestStructure.h"

#import "SCNNestLocation.h"

@implementation SCNNestStructure

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"structureId": @"structure_id",
             @"name": @"name",
             @"away": @"away",
             @"thermostatIds": @"thermostats",
             @"camerasIds": @"cameras",
             @"smokeCoAlarmIds": @"smoke_co_alarms",
             @"locations": @"wheres"};
}

+ (NSValueTransformer *)locationsJSONTransformer {
    return [MTLJSONAdapter scnNestIdEntityDictionaryTransformerWithModelsOfClass:[SCNNestLocation class]];
}

+ (NSValueTransformer *)awayJSONTransformer {
    NSDictionary *dictionary = @{@"unknown": @(SCNNestAwayStateUnknown),
                                 @"home": @(SCNNestAwayStateHome),
                                 @"away": @(SCNNestAwayStateAway),
                                 @"auto-away": @(SCNNestAwayStateAutoAway)};
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}

@end
