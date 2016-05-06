//
//  SCNNestDevicePool.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestDevicePool.h"

#import "SCNNestCamera.h"
#import "SCNNestThermostat.h"
#import "SCNNestSmokeCOAlarm.h"

@interface SCNNestDevicePool ()

@property (nonatomic, strong) NSArray<SCNNestCamera *> *filteredCameras;
@property (nonatomic, strong) NSArray<SCNNestSmokeCOAlarm *> *filteredSmokeCOAlarms;
@property (nonatomic, strong) NSArray<SCNNestThermostat *> *filteredThermostats;

@end

@implementation SCNNestDevicePool

- (void)filterWithStructureId:(NSString *)structureId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"structureId = %@", structureId];
    self.filteredCameras = [self.cameras filteredArrayUsingPredicate:predicate];
    self.filteredSmokeCOAlarms = [self.smokeCOAlarms filteredArrayUsingPredicate:predicate];
    self.filteredThermostats = [self.thermostats filteredArrayUsingPredicate:predicate];
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"cameras": @"cameras",
             @"smokeCOAlarms": @"smoke_co_alarms",
             @"thermostats": @"thermostats"};
}

+ (NSValueTransformer *)camerasJSONTransformer {
    return [MTLJSONAdapter scnNestIdEntityDictionaryTransformerWithModelsOfClass:[SCNNestCamera class]];
}

+ (NSValueTransformer *)smokeCOAlarmsJSONTransformer {
    return [MTLJSONAdapter scnNestIdEntityDictionaryTransformerWithModelsOfClass:[SCNNestSmokeCOAlarm class]];
}

+ (NSValueTransformer *)thermostatsJSONTransformer {
    return [MTLJSONAdapter scnNestIdEntityDictionaryTransformerWithModelsOfClass:[SCNNestThermostat class]];
}

@end
