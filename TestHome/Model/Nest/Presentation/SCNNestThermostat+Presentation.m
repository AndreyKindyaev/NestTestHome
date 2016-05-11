//
//  SCNNestThermostat+Presentation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/11/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestThermostat+Presentation.h"

static const double kTemperatureDeltaC = 1.5f;
static const double kTemperatureDeltaF = 3.f;

@implementation SCNNestThermostat (Presentation)

- (NSString *)lastConnectionDateString {
    return [SCNNilObjectValueTransformer nilDashesUIStringForDate:self.lastConnectionDate];
}

- (NSString *)canCoolString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.canCoolNumber];
}

- (NSString *)canHeatString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.canHeatNumber];
}

- (NSString *)isUsingEmergencyHeatString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.isUsingEmergencyHeatNumber];
}

- (NSString *)hasFanString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.hasFanNumber];
}

- (NSString *)fanTimerTimeoutString {
    return [SCNNilObjectValueTransformer nilDashesUIStringForDate:self.fanTimerTimeout];
}

- (NSString *)hasLeafString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.hasLeafNumber];
}

- (BOOL)isTemperatureScaleValid {
    return (nil != self.temperatureScaleNumber);
}

- (SCNNestTemperatureScale)temperatureScale {
    return self.temperatureScaleNumber.integerValue;
}

- (void)setTemperatureScale:(SCNNestTemperatureScale)temperatureScale {
    self.temperatureScaleNumber = @(temperatureScale);
}

- (NSString *)targetTemperatureString {
    return [SCNNilObjectValueTransformer nilDashesStringForNumberValue:[self targetTemperatureNumber]];
}

- (NSNumber *)targetTemperatureNumber {
    NSNumber *targetTemperatureNumber = nil;
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            targetTemperatureNumber = self.targetTemperatureCNumber;
            break;
        case SCNNestTemperatureScaleF:
            targetTemperatureNumber = self.targetTemperatureFNumber;
            break;
        default:
            break;
    }
    return targetTemperatureNumber;
}

- (void)setTargetTemperatureNumber:(NSNumber *)temperature {
    NSNumber *roundedTemperature = @(round(temperature.doubleValue));
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            self.targetTemperatureCNumber = roundedTemperature;
            break;
        case SCNNestTemperatureScaleF:
            self.targetTemperatureFNumber = roundedTemperature;
            break;
        default:
            break;
    }
}

- (NSString *)targetTemperatureHighString {
    return [SCNNilObjectValueTransformer nilDashesStringForNumberValue:[self targetTemperatureHighNumber]];
}

- (NSNumber *)targetTemperatureHighNumber {
    NSNumber *targetTemperatureHighNumber = nil;
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            targetTemperatureHighNumber = self.targetTemperatureHighCNumber;
            break;
        case SCNNestTemperatureScaleF:
            targetTemperatureHighNumber = self.targetTemperatureHighFNumber;
            break;
        default:
            break;
    }
    return targetTemperatureHighNumber;
}

- (void)setTargetTemperatureHighNumber:(NSNumber *)temperature {
    double highValue = round(temperature.doubleValue);
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
        {
            double lowValue = self.targetTemperatureLowNumber.doubleValue + kTemperatureDeltaC;
            // prevent set High value lower than Low
            NSNumber *roundedTemperature = @((highValue < lowValue) ? lowValue : highValue);
            self.targetTemperatureHighCNumber = roundedTemperature;
        }
            break;
        case SCNNestTemperatureScaleF:
        {
            double lowValue = self.targetTemperatureLowNumber.doubleValue + kTemperatureDeltaF;
            // prevent set High value lower than Low
            NSNumber *roundedTemperature = @((highValue < lowValue) ? lowValue : highValue);
            self.targetTemperatureHighFNumber = roundedTemperature;
        }
            break;
        default:
            break;
    }
}

- (NSString *)targetTemperatureLowString {
    return [SCNNilObjectValueTransformer nilDashesStringForNumberValue:[self targetTemperatureLowNumber]];
}

- (NSNumber *)targetTemperatureLowNumber {
    NSNumber *targetTemperatureLowNumber = nil;
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            targetTemperatureLowNumber = self.targetTemperatureLowCNumber;
            break;
        case SCNNestTemperatureScaleF:
            targetTemperatureLowNumber = self.targetTemperatureLowFNumber;
            break;
        default:
            break;
    }
    return targetTemperatureLowNumber;
}
- (void)setTargetTemperatureLowNumber:(NSNumber *)temperature {
    double lowValue = round(temperature.doubleValue);
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
        {
            double highValue = self.targetTemperatureHighNumber.doubleValue - kTemperatureDeltaC;
            // prevent set Low value higher than High
            NSNumber *roundedTemperature = @((lowValue > highValue) ? highValue : lowValue);
            self.targetTemperatureLowCNumber = roundedTemperature;
        }
            break;
        case SCNNestTemperatureScaleF:
        {
            double highValue = self.targetTemperatureHighNumber.doubleValue - kTemperatureDeltaF;
            // prevent set Low value higher than High
            NSNumber *roundedTemperature = @((lowValue > highValue) ? highValue : lowValue);
            self.targetTemperatureLowFNumber = roundedTemperature;
        }
            break;
        default:
            break;
    }
}

- (NSNumber *)targetTemperatureMinNumber {
    NSNumber *targetTemperatureMinNumber = nil;
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            targetTemperatureMinNumber = @9;
            break;
        case SCNNestTemperatureScaleF:
            targetTemperatureMinNumber = @50;
            break;
        default:
            break;
    }
    return targetTemperatureMinNumber;
}

- (NSNumber *)targetTemperatureMaxNumber {
    NSNumber *targetTemperatureMaxNumber = nil;
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            targetTemperatureMaxNumber = @32;
            break;
        case SCNNestTemperatureScaleF:
            targetTemperatureMaxNumber = @90;
            break;
        default:
            break;
    }
    return targetTemperatureMaxNumber;
}

- (NSString *)awayTemperatureHighString {
    NSString *awayTemperatureHighString = nil;
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            awayTemperatureHighString = self.awayTemperatureHighCNumber.stringValue;
            break;
        case SCNNestTemperatureScaleF:
            awayTemperatureHighString = self.awayTemperatureHighFNumber.stringValue;
        default:
            break;
    }
    return awayTemperatureHighString;
}

- (NSString *)awayTemperatureLowString {
    NSString *awayTemperatureLowString = nil;
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            awayTemperatureLowString = self.awayTemperatureLowCNumber.stringValue;
            break;
        case SCNNestTemperatureScaleF:
            awayTemperatureLowString = self.awayTemperatureLowFNumber.stringValue;
        default:
            break;
    }
    return awayTemperatureLowString;
}

- (NSString *)ambientTemperatureString {
    NSString *ambientTemperatureString = nil;
    switch (self.temperatureScale) {
        case SCNNestTemperatureScaleC:
            ambientTemperatureString = self.ambientTemperatureCNumber.stringValue;
            break;
        case SCNNestTemperatureScaleF:
            ambientTemperatureString = self.ambientTemperatureFNumber.stringValue;
        default:
            break;
    }
    return ambientTemperatureString;
}

- (BOOL)isHvacModeValid {
    return (nil != self.hvacModeNumber);
}

- (SCNNestHVACMode)hvacMode {
    return self.hvacModeNumber.integerValue;
}

- (void)setHvacMode:(SCNNestHVACMode)hvacMode {
    self.hvacModeNumber = @(hvacMode);
}

- (NSString *)hvacStateString {
    return [SCNNilObjectValueTransformer nilDashesStringForValue:self.hvacStateNumber
                                                    forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                NSString *string = nil;
                switch ((SCNNestHVACState)value.integerValue) {
                    case SCNNestHVACStateCooling:
                        string = @"Cooling";
                        break;
                    case SCNNestHVACStateHeating:
                        string = @"Heating";
                        break;
                    case SCNNestHVACStateOff:
                        string = @"Off";
                        break;
                    default:
                        break;
                }
                return string;
            }];
}

- (NSString *)humidityString {
    return [SCNNilObjectValueTransformer nilDashesStringForNumberValue:self.humidityNumber];
}

@end
