//
//  SCNCameraDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/6/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNCameraDataProvider.h"

@interface SCNCameraDataProvider ()

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) SCNNestCamera *camera;

@end

@implementation SCNCameraDataProvider

+ (instancetype)providerWithDeviceId:(NSString *)deviceId {
    SCNCameraDataProvider *provider = [self new];
    provider.deviceId = deviceId;
    return provider;
}

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [self observeUrl:[NSString stringWithFormat:@"devices/cameras/%@", self.deviceId]
         updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.scnValue;
         NSError *error = nil;
         if ([value isKindOfClass:[NSDictionary class]]) {
             weakSelf.camera = [MTLJSONAdapter modelOfClass:[SCNNestCamera class]
                                         fromJSONDictionary:value
                                                      error:&error];
         } else if (nil != value) {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

- (void)saveCameraIsStreamingWithCompletion:(void(^)(NSError *error))completion {
    [self saveChangesForModel:self.camera
              propertiesArray:@[@"isStreamingNumber"]
                   completion:completion];
}

@end
