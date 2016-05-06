//
//  SCNAwayDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNAwayDataProvider.h"

#import "SCNNestFirebaseManager.h"
#import "SCNNestStructure.h"

@interface SCNAwayDataProvider ()

@property (nonatomic, strong) NSString *structureId;
@property (nonatomic) SCNNestAwayState away;

@end

@implementation SCNAwayDataProvider

+ (instancetype)providerWithStructureId:(NSString *)structureId {
    SCNAwayDataProvider *provider = [self new];
    provider.structureId = structureId;
    return provider;
}

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [self observeUrl:[NSString stringWithFormat:@"structures/%@/away", self.structureId]
         updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.value;
         NSError *error = nil;
         if ([value isKindOfClass:[NSString class]]) {
             weakSelf.away = [((NSNumber *)[[SCNNestStructure awayJSONTransformer] transformedValue:value]) integerValue];
         } else {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

- (void)setAway:(SCNNestAwayState)away completion:(void(^)(NSError *error))completion {
    NSString *awayString = [[SCNNestStructure awayJSONTransformer] reverseTransformedValue:@(away)];
    [self setValue:awayString withCompletion:completion];
}

@end
