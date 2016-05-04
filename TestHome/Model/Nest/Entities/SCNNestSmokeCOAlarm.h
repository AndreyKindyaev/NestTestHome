//
//  SCNNestSmokeCOAlarm.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestDevice.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCNNestBatteryHealth) {
    SCNNestBatteryHealthOk,
    SCNNestBatteryHealthReplace,
};

typedef NS_ENUM(NSInteger, SCNNestCOAlarmState) {
    SCNNestCOAlarmStateOk,
    SCNNestCOAlarmStateWarning,
    SCNNestCOAlarmStateEmergency,
};

typedef NS_ENUM(NSInteger, SCNNestSmokeAlarmState) {
    SCNNestSmokeAlarmStateOk,
    SCNNestSmokeAlarmStateWarning,
    SCNNestSmokeAlarmStateEmergency,
};

typedef NS_ENUM(NSInteger, SCNNestAlarmColorState) {
    SCNNestAlarmColorStateGray,
    SCNNestAlarmColorStateGreen,
    SCNNestAlarmColorStateYellow,
    SCNNestAlarmColorStateRed,
};

@interface SCNNestSmokeCOAlarm : SCNNestDevice

@property (nonatomic, strong) NSString *locale;

@property (nonatomic, strong) NSDate *lastConnection;

@property (nonatomic) SCNNestBatteryHealth batteryHealth;
@property (nonatomic) SCNNestCOAlarmState coAlarmState;
@property (nonatomic) SCNNestSmokeAlarmState smokeAlarmState;

@property (nonatomic) BOOL isManualTestActive;
@property (nonatomic, strong) NSDate *lastManualTestTime;

@property (nonatomic) SCNNestAlarmColorState uiColorState;

@end
