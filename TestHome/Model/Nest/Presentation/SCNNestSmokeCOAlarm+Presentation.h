//
//  SCNNestSmokeCOAlarm+Presentation.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestSmokeCOAlarm.h"

@interface SCNNestSmokeCOAlarm (Presentation)

- (UIColor *)color;
- (NSString *)batteryHealthString;
- (NSString *)coAlarmStateString;
- (NSString *)smokeAlarmStateString;
- (NSString *)manualTestActiveString;
- (NSString *)lastConnectionDateString;
- (NSString *)lastManualTestTimeString;

@end
