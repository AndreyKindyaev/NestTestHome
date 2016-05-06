//
//  SCNStructuresDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNStructuresDataProvider.h"

#import "SCNNestFirebaseManager.h"
#import "SCNSettings.h"

@interface SCNStructuresDataProvider ()

@property (nonatomic, strong) NSArray<SCNNestStructure *> *structures;

@end

@implementation SCNStructuresDataProvider

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock {
    __weak typeof(self) weakSelf = self;
    [self observeUrl:@"structures"
         updateBlock:
     ^(FDataSnapshot *snapshot) {
         id value = snapshot.value;
         NSError *error = nil;
         if ([value isKindOfClass:[NSDictionary class]]) {
             NSArray *jsonStructures = [value allValues];
             weakSelf.structures = [MTLJSONAdapter modelsOfClass:[SCNNestStructure class]
                                                   fromJSONArray:jsonStructures
                                                           error:&error];
             [[SCNSettings sharedInstance] updateActiveStructureIdWithAvailableStructures:weakSelf.structures];
         } else {
             error = [NSError scnErrorWithCode:SCNErrorCodeWrongDataFormat];
         }
         if (nil != updateBlock) {
             updateBlock(error);
         }
     }];
}

- (NSInteger)numberOfStructures {
    return self.structures.count;
}

- (SCNNestStructure *)structureAtIndex:(NSInteger)index {
    return self.structures[index];
}

@end
