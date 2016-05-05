//
//  SCNDevicesDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDevicesDataProvider.h"

#import "SCNNestFirebaseManager.h"
#import "NSError+Utils.h"
#import <UIKit/UIKit.h>
#import "SCNNestDevicePool.h"

@interface SCNDevicesDataProvider ()

@property (nonatomic, strong) NSString *uniqueKey;
@property (nonatomic, strong) NSString *structureId;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray *> *devicesByTypeNames;

@end

@implementation SCNDevicesDataProvider

- (void)dealloc {
    [[SCNNestFirebaseManager sharedInstance] removeObserverForUrl:[self _observerUrl]
                                                  withObserverKey:self.uniqueKey];
}

+ (instancetype)providerWithStructureId:(NSString *)structureId
                            updateBlock:(void(^)(NSError *error))updateBlock {
    SCNDevicesDataProvider *provider = [self new];
    provider.structureId = structureId;
    [provider _setUpdateBlock:updateBlock];
    return provider;
}

- (instancetype)init {
    self = [super init];
    if (nil != self) {
        _uniqueKey = [[NSUUID UUID] UUIDString];
    }
    return self;
}

- (NSInteger)numberOfDeviceTypes {
    return self.devicesByTypeNames.allKeys.count;
}

- (NSString *)deviceTypeNameAtIndex:(NSInteger)index {
    return self.devicesByTypeNames.allKeys[index];
}

- (NSInteger)numberOfDevicesForTypeIndex:(NSInteger)index {
    NSString *key = self.devicesByTypeNames.allKeys[index];
    return self.devicesByTypeNames[key].count;
}
- (SCNNestDevice *)deviceAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.devicesByTypeNames.allKeys[indexPath.section];
    return self.devicesByTypeNames[key][indexPath.row];
}

#pragma mark - Private
- (void)_setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [[SCNNestFirebaseManager sharedInstance] observeUrl:[self _observerUrl]
                                        withObserverKey:self.uniqueKey
                                            updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.value;
         NSError *error = nil;
         if ([value isKindOfClass:[NSDictionary class]]) {
             SCNNestDevicePool *devicePool = [MTLJSONAdapter modelOfClass:[SCNNestDevicePool class]
                                                       fromJSONDictionary:value
                                                                    error:&error];
             [devicePool filterWithStructureId:self.structureId];
             weakSelf.devicesByTypeNames = [weakSelf _devicesByTypeNamesWithDevicePool:devicePool];
         } else {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

- (NSString *)_observerUrl {
    return @"devices";
}

- (NSDictionary *)_devicesByTypeNamesWithDevicePool:(SCNNestDevicePool *)devicePool {
    NSMutableDictionary *devicesByTypeNames = [NSMutableDictionary new];
    NSArray *thermostats = devicePool.filteredThermostats;
    if (thermostats.count > 0) {
        devicesByTypeNames[@"Thermostats"] = thermostats;
    }
    NSArray *cameras = devicePool.filteredCameras;
    if (cameras.count > 0) {
        devicesByTypeNames[@"Cameras"] = cameras;
    }
    NSArray *smokeCOAlarms = devicePool.filteredSmokeCOAlarms;
    if (smokeCOAlarms.count > 0) {
        devicesByTypeNames[@"Smoke+CO Alarms"] = smokeCOAlarms;
    }
    return devicesByTypeNames;
}

@end
