//
//  SCNNestCamera.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestCamera.h"

#import "MTLValueTransformer+SCNNest.h"
#import "SCNNestCameraEvent.h"

@implementation SCNNestCamera

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *dictionary = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    [dictionary addEntriesFromDictionary:@{@"isStreaming" : @"is_streaming",
                                           @"isAudioInputEnabled" : @"is_audio_input_enabled",
                                           @"lastIsOnlineChange" : @"last_is_online_change",
                                           @"isVideoHistoryEnabled" : @"is_video_history_enabled",
                                           @"webUrl" : @"web_url",
                                           @"appUrl" : @"app_url",
                                           @"lastEvent" : @"last_event"}];
    return dictionary;
}

+ (NSValueTransformer *)lastIsOnlineChangeJSONTransformer {
    return [MTLValueTransformer scnNestJSONDateTransformer];
}

+ (NSValueTransformer *)lastEventJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCNNestCameraEvent class]];
}

@end
