//
//  SCNNestCameraEvent.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SCNNestCameraEvent : MTLModel <MTLJSONSerializing>

@property (nonatomic) BOOL hasSound;
@property (nonatomic) BOOL hasMotion;

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

@property (nonatomic, strong) NSDate *urlsExpireTime;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *appUrl;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *animatedImageUrl;

@end
