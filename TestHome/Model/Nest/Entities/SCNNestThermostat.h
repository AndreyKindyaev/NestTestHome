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

@property (nonatomic, strong) NSDate *lastConnection;

@property (nonatomic) BOOL canCool;
@property (nonatomic) BOOL canHeat;
@property (nonatomic) BOOL isUsingEmergencyHeat;
@property (nonatomic) BOOL hasFan;
@property (nonatomic) BOOL fanTimerActive;
@property (nonatomic, strong) NSDate *fanTimerTimeout;
@property (nonatomic) BOOL hasLeaf;

// temperature
@property (nonatomic) SCNNestTemperatureScale temperatureScale;
// F
@property (nonatomic) double targetTemparatureF;
@property (nonatomic) double targetTemperatureHighF;
@property (nonatomic) double targetTemperatureLowF;
@property (nonatomic) double awayTemperatureHighF;
@property (nonatomic) double awayTemperatureLowF;
@property (nonatomic) double ambientTemperatureF;
// C
@property (nonatomic) double targetTemparatureC;
@property (nonatomic) double targetTemperatureHighC;
@property (nonatomic) double targetTemperatureLowC;
@property (nonatomic) double awayTemperatureHighC;
@property (nonatomic) double awayTemperatureLowC;
@property (nonatomic) double ambientTemperatureC;

@property (nonatomic) SCNNestHVACMode hvacMode;
@property (nonatomic) SCNNestHVACState hvacState;

@property (nonatomic) double humidity;

@end
