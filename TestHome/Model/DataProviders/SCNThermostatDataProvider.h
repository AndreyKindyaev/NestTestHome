//
//  SCNThermostatDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/11/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDataProvider.h"
#import "SCNNestThermostat.h"

@interface SCNThermostatDataProvider : SCNDataProvider

+ (instancetype)providerWithDeviceId:(NSString *)deviceId;

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock;
- (SCNNestThermostat *)thermostat;

- (void)saveThermostatFanTimerActiveWithCompletion:(void(^)(NSError *error))completion;
- (void)saveThermostatHvacModeWithCompletion:(void(^)(NSError *error))completion;
- (void)saveThermostatTargetTemperatureWithCompletion:(void(^)(NSError *error))completion;
- (void)saveThermostatTargetTemperatureHighLowWithCompletion:(void(^)(NSError *error))completion;

@end
