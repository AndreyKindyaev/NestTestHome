//
//  SCNNestCameraEvent.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestCameraEvent.h"

@implementation SCNNestCameraEvent

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"hasSoundNumber": @"has_sound",
             @"hasMotionNumber": @"has_motion",
             @"startTime": @"start_time",
             @"endTime": @"end_time",
             @"urlsExpireTime": @"urls_expire_time",
             @"webUrl": @"web_url",
             @"appUrl": @"app_url",
             @"imageUrl": @"image_url",
             @"animatedImageUrl": @"animated_image_url"};
}

+ (NSValueTransformer *)startTimeJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)endTimeJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)urlsExpireTimeJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

@end
