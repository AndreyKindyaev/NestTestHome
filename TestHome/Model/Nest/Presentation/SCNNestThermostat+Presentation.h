//
//  SCNNestThermostat+Presentation.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/11/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestThermostat.h"

@interface SCNNestThermostat (Presentation)

- (NSString *)lastConnectionDateString;
- (NSString *)canCoolString;
- (NSString *)canHeatString;
- (NSString *)isUsingEmergencyHeatString;
- (NSString *)hasFanString;
- (NSString *)fanTimerTimeoutString;
- (NSString *)hasLeafString;

- (BOOL)isTemperatureScaleValid;
- (SCNNestTemperatureScale)temperatureScale;
- (void)setTemperatureScale:(SCNNestTemperatureScale)temperatureScale;

- (NSString *)targetTemperatureString;
- (NSNumber *)targetTemperatureNumber;
- (void)setTargetTemperatureNumber:(NSNumber *)temperature;

- (NSString *)targetTemperatureHighString;
- (NSNumber *)targetTemperatureHighNumber;
- (void)setTargetTemperatureHighNumber:(NSNumber *)temperature;

- (NSString *)targetTemperatureLowString;
- (NSNumber *)targetTemperatureLowNumber;
- (void)setTargetTemperatureLowNumber:(NSNumber *)temperature;

- (NSNumber *)targetTemperatureMinNumber;
- (NSNumber *)targetTemperatureMaxNumber;

- (NSString *)awayTemperatureHighString;
- (NSString *)awayTemperatureLowString;
- (NSString *)ambientTemperatureString;

- (BOOL)isHvacModeValid;
- (SCNNestHVACMode)hvacMode;
- (void)setHvacMode:(SCNNestHVACMode)hvacMode;

- (NSString *)hvacStateString;

- (NSString *)humidityString;

@end
