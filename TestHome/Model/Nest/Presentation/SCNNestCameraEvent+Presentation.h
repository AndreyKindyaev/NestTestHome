//
//  SCNNestCameraEvent+Presentation.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/11/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestCameraEvent.h"

@interface SCNNestCameraEvent (Presentation)

- (NSString *)hasSoundString;
- (NSString *)hasMotionString;
- (NSString *)startTimeString;
- (NSString *)endTimeString;
- (NSString *)urlsExpireTimeString;

- (BOOL)isUrlsExpired;

@end
