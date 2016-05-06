//
//  SCNSmokeCOAlarmDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDataProvider.h"
#import "SCNNestSmokeCOAlarm.h"

@interface SCNSmokeCOAlarmDataProvider : SCNDataProvider

+ (instancetype)providerWithDeviceId:(NSString *)deviceId;

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock;
- (SCNNestSmokeCOAlarm *)smokeCOAlarm;

@end
