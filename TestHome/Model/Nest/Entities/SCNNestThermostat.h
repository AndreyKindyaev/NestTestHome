//
//  SCNNestThermostat.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestDevice.h"

typedef NS_ENUM(NSInteger, SCNNestTemperatureScale) {
    SCNNestTemperatureScaleF,
    SCNNestTemperatureScaleC,
};

typedef NS_ENUM(NSInteger, SCNNestHVACMode) {
    SCNNestHVACModeHeat,
    SCNNestHVACModeCool,
    SCNNestHVACModeHeatCool,
    SCNNestHVACModeOff,
};

typedef NS_ENUM(NSInteger, SCNNestHVACState) {
    SCNNestHVACStateHeating,
    SCNNestHVACStateCooling,
    SCNNestHVACStateOff,
};

@interface SCNNestThermostat : SCNNestDevice

@property (nonatomic, strong) NSString *locale;

@property (nonatomic, strong) NSDate *lastConnectionDate;

@property (nonatomic, strong) NSNumber *canCoolNumber;
@property (nonatomic, strong) NSNumber *canHeatNumber;
@property (nonatomic, strong) NSNumber *isUsingEmergencyHeatNumber;
@property (nonatomic, strong) NSNumber *hasFanNumber;
@property (nonatomic, strong) NSNumber *fanTimerActiveNumber;
@property (nonatomic, strong) NSDate *fanTimerTimeout;
@property (nonatomic, strong) NSNumber *hasLeafNumber;

// temperature
@property (nonatomic) NSNumber *temperatureScaleNumber;
// F
@property (nonatomic) NSNumber *targetTemperatureFNumber;
@property (nonatomic) NSNumber *targetTemperatureHighFNumber;
@property (nonatomic) NSNumber *targetTemperatureLowFNumber;
@property (nonatomic) NSNumber *awayTemperatureHighFNumber;
@property (nonatomic) NSNumber *awayTemperatureLowFNumber;
@property (nonatomic) NSNumber *ambientTemperatureFNumber;
// C
@property (nonatomic) NSNumber *targetTemperatureCNumber;
@property (nonatomic) NSNumber *targetTemperatureHighCNumber;
@property (nonatomic) NSNumber *targetTemperatureLowCNumber;
@property (nonatomic) NSNumber *awayTemperatureHighCNumber;
@property (nonatomic) NSNumber *awayTemperatureLowCNumber;
@property (nonatomic) NSNumber *ambientTemperatureCNumber;

@property (nonatomic) NSNumber *hvacModeNumber;
@property (nonatomic) NSNumber *hvacStateNumber;

@property (nonatomic) NSNumber *humidityNumber;

- (NSArray<NSString *> *)propertiesArrayForTargetTemperature;
- (NSArray<NSString *> *)propertiesArrayForTargetTemperatureHighLow;

@end
