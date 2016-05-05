//
//  SCNAwayDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNAwayDataProvider.h"

#import "SCNNestFirebaseManager.h"
#import "NSError+Utils.h"
#import "SCNNestStructure.h"

@interface SCNAwayDataProvider ()

@property (nonatomic, strong) NSString *uniqueKey;
@property (nonatomic, strong) NSString *structureId;
@property (nonatomic) SCNNestAwayState away;

@end

@implementation SCNAwayDataProvider

- (void)dealloc {
    [[SCNNestFirebaseManager sharedInstance] removeObserverForUrl:[self _observerUrl]
                                                  withObserverKey:self.uniqueKey];
}

+ (instancetype)providerWithStructureId:(NSString *)structureId
                            updateBlock:(void(^)(NSError *error))updateBlock {
    SCNAwayDataProvider *provider = [self new];
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

- (void)setAway:(SCNNestAwayState)away completion:(void(^)(NSError *error))completion {
    NSString *awayString = [[SCNNestStructure awayJSONTransformer] reverseTransformedValue:@(away)];
    [[SCNNestFirebaseManager sharedInstance] setValue:awayString
                                               forUrl:[self _observerUrl]
                                          observerKey:self.uniqueKey
                                       withCompletion:
     ^(NSError *error) {
         if (nil != completion) {
             completion(error);
         }
     }];
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
             weakSelf.away = [((NSNumber *)[[SCNNestStructure awayJSONTransformer] transformedValue:value]) integerValue];
         } else {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

- (NSString *)_observerUrl {
    return [NSString stringWithFormat:@"structures/%@/away", self.structureId];
}

@end
