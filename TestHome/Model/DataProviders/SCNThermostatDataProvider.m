//
//  SCNThermostatDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/11/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNThermostatDataProvider.h"

@interface SCNThermostatDataProvider ()

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) SCNNestThermostat *thermostat;

@end

@implementation SCNThermostatDataProvider

+ (instancetype)providerWithDeviceId:(NSString *)deviceId {
    SCNThermostatDataProvider *provider = [self new];
    provider.deviceId = deviceId;
    return provider;
}

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [self observeUrl:[NSString stringWithFormat:@"devices/thermostats/%@", self.deviceId]
         updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.scnValue;
         NSError *error = nil;
         if ([value isKindOfClass:[NSDictionary class]]) {
             weakSelf.thermostat = [MTLJSONAdapter modelOfClass:[SCNNestThermostat class]
                                             fromJSONDictionary:value
                                                          error:&error];
         } else if (nil != value) {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

- (void)saveThermostatFanTimerActiveWithCompletion:(void(^)(NSError *error))completion {
    [self saveChangesForModel:self.thermostat
              propertiesArray:@[@"fanTimerActiveNumber"]
                   completion:completion];
    
}

- (void)saveThermostatHvacModeWithCompletion:(void(^)(NSError *error))completion {
    [self saveChangesForModel:self.thermostat
              propertiesArray:@[@"hvacModeNumber"]
                   completion:completion];
    
}

- (void)saveThermostatTargetTemperatureWithCompletion:(void(^)(NSError *error))completion {
    [self saveChangesForModel:self.thermostat
              propertiesArray:[self.thermostat propertiesArrayForTargetTemperature]
                   completion:completion];
}

- (void)saveThermostatTargetTemperatureHighLowWithCompletion:(void(^)(NSError *error))completion {
    [self saveChangesForModel:self.thermostat
              propertiesArray:[self.thermostat propertiesArrayForTargetTemperatureHighLow]
                   completion:completion];
}

@end
