//
//  SCNLocationDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNLocationDataProvider.h"

@interface SCNLocationDataProvider ()

@property (nonatomic, strong) NSString *structureId;
@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) SCNNestLocation *location;

@end

@implementation SCNLocationDataProvider

+ (instancetype)providerWithLocationId:(NSString *)locationId
                           structureId:(NSString *)structureId {
    SCNLocationDataProvider *provider = [self new];
    provider.structureId = structureId;
    provider.locationId = locationId;
    return provider;
}

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [self observeUrl:[NSString stringWithFormat:@"structures/%@/wheres/%@", self.structureId, self.locationId]
         updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.scnValue;
         NSError *error = nil;
         if ([value isKindOfClass:[NSDictionary class]]) {
             weakSelf.location = [MTLJSONAdapter modelOfClass:[SCNNestLocation class]
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

@end
