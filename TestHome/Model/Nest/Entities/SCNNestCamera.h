//
//  SCNNestCamera.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestDevice.h"

@class SCNNestCameraEvent;
@interface SCNNestCamera : SCNNestDevice

@property (nonatomic, strong) NSNumber *isStreamingNumber;
@property (nonatomic, strong) NSNumber *isAudioInputEnabledNumber;
@property (nonatomic, strong) NSDate *lastIsOnlineChange;
@property (nonatomic, strong) NSNumber *isVideoHistoryEnabledNumber;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *appUrl;
@property (nonatomic, strong) SCNNestCameraEvent *lastEvent;

@end
