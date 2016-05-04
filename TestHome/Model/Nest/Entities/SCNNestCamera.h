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

@property (nonatomic) BOOL isStreaming;
@property (nonatomic) BOOL isAudioInputEnabled;
@property (nonatomic, strong) NSDate *lastIsOnlineChange;
@property (nonatomic, strong) SCNNestCameraEvent *lastEvent;

@end
