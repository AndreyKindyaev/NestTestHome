//
//  SCNNestCameraEvent.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

@interface SCNNestCameraEvent : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *hasSoundNumber;
@property (nonatomic, strong) NSNumber *hasMotionNumber;

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

@property (nonatomic, strong) NSDate *urlsExpireTime;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *appUrl;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *animatedImageUrl;

@end
