//
//  SCNSmokeCOAlarmDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNSmokeCOAlarmDataProvider.h"

@interface SCNSmokeCOAlarmDataProvider ()

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) SCNNestSmokeCOAlarm *smokeCOAlarm;

@end

@implementation SCNSmokeCOAlarmDataProvider

+ (instancetype)providerWithDeviceId:(NSString *)deviceId {
    SCNSmokeCOAlarmDataProvider *provider = [self new];
    provider.deviceId = deviceId;
    return provider;
}

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [self observeUrl:[NSString stringWithFormat:@"devices/smoke_co_alarms/%@", self.deviceId]
         updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.value;
         NSError *error = nil;
         if ([value isKindOfClass:[NSDictionary class]]) {
             weakSelf.smokeCOAlarm = [MTLJSONAdapter modelOfClass:[SCNNestSmokeCOAlarm class]
                                               fromJSONDictionary:value
                                                            error:&error];
         } else {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

@end
