//
//  SCNStructureNameDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNStructureNameDataProvider.h"

#import "SCNNestFirebaseManager.h"

@interface SCNStructureNameDataProvider ()

@property (nonatomic, strong) NSString *structureId;
@property (nonatomic, strong) NSString *name;

@end

@implementation SCNStructureNameDataProvider

+ (instancetype)providerWithStructureId:(NSString *)structureId {
    SCNStructureNameDataProvider *provider = [self new];
    provider.structureId = structureId;
    return provider;
}

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [self observeUrl:[NSString stringWithFormat:@"structures/%@/name", self.structureId]
         updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.value;
         NSError *error = nil;
         if ([value isKindOfClass:[NSString class]]) {
             weakSelf.name = value;
         } else {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

@end
