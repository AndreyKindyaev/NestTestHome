//
//  SCNCameraDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/6/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDataProvider.h"
#import "SCNNestCamera.h"

@interface SCNCameraDataProvider : SCNDataProvider

+ (instancetype)providerWithDeviceId:(NSString *)deviceId;

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock;
- (SCNNestCamera *)camera;

- (void)saveCameraChangesWithCompletion:(void(^)(NSError *error))completion;

@end
