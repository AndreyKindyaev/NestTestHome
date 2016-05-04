//
//  SCNStructureNameDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNStructureNameDataProvider.h"

#import "SCNNestFirebaseManager.h"
#import "NSError+Utils.h"

@interface SCNStructureNameDataProvider ()

@property (nonatomic, strong) NSString *uniqueKey;
@property (nonatomic, strong) NSString *structureId;
@property (nonatomic, strong) NSString *name;

@end

@implementation SCNStructureNameDataProvider

- (void)dealloc {
    [[SCNNestFirebaseManager sharedInstance] removeObserverForUrl:[self _observerUrl]
                                                  withObserverKey:self.uniqueKey];
}

+ (instancetype)providerWithStructureId:(NSString *)structureId
                            updateBlock:(void(^)(NSError *error))updateBlock {
    SCNStructureNameDataProvider *provider = [self new];
    provider.structureId = structureId;
    [provider _setUpdateBlock:updateBlock];
    return provider;
}

- (instancetype)init {
    self = [super init];
    if (nil != self) {
        _uniqueKey = [[NSUUID UUID] UUIDString];
    }
    return self;
}

#pragma mark - Private
- (void)_setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [[SCNNestFirebaseManager sharedInstance] observeUrl:[self _observerUrl]
                                        withObserverKey:self.uniqueKey
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

- (NSString *)_observerUrl {
    return [NSString stringWithFormat:@"structures/%@/name", self.structureId];
}

@end
