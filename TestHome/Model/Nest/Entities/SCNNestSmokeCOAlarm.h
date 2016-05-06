//
//  SCNNestSmokeCOAlarm.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestDevice.h"

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

@property (nonatomic, strong) NSDate *lastConnectionDate;

@property (nonatomic, strong) NSNumber *batteryHealthNumber;
@property (nonatomic, strong) NSNumber *coAlarmStateNumber;
@property (nonatomic, strong) NSNumber *smokeAlarmStateNumber;

@property (nonatomic, strong) NSNumber *isManualTestActiveNumber;
@property (nonatomic, strong) NSDate *lastManualTestTime;

@property (nonatomic, strong) NSNumber *uiColorStateNumber;

@end
