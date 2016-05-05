//
//  SCNStructuresDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNStructuresDataProvider.h"

#import "SCNNestFirebaseManager.h"
#import <Mantle/Mantle.h>
#import "NSError+Utils.h"
#import "SCNSettings.h"

@interface SCNStructuresDataProvider ()

@property (nonatomic, strong) NSString *uniqueKey;
@property (nonatomic, strong) NSArray<SCNNestStructure *> *structures;

@end

@implementation SCNStructuresDataProvider

- (void)dealloc {
    [[SCNNestFirebaseManager sharedInstance] removeObserverForUrl:[self _observerUrl]
                                                  withObserverKey:self.uniqueKey];
}

+ (instancetype)providerWithUpdateBlock:(void(^)(NSError *error))updateBlock {
    SCNStructuresDataProvider *provider = [self new];
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

- (NSInteger)numberOfStructures {
    return self.structures.count;
}

- (SCNNestStructure *)structureAtIndex:(NSInteger)index {
    return self.structures[index];
}

#pragma mark - Private
- (void)_setUpdateBlock:(void(^)(NSError *error))updateBlock {
    [[SCNNestFirebaseManager sharedInstance] observeUrl:[self _observerUrl]
                                        withObserverKey:self.uniqueKey
                                            updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.value;
         NSError *error = nil;
         if ([value isKindOfClass:[NSDictionary class]]) {
             NSArray *jsonStructures = [value allValues];
             self.structures = [MTLJSONAdapter modelsOfClass:[SCNNestStructure class]
                                               fromJSONArray:jsonStructures
                                                       error:&error];
             [[SCNSettings sharedInstance] updateActiveStructureIdWithAvailableStructures:self.structures];
         } else {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

- (NSString *)_observerUrl {
    return @"structures";
}

@end
