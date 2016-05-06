//
//  SCNAwayDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDataProvider.h"
#import "SCNNestStructure.h"

@interface SCNAwayDataProvider : SCNDataProvider

+ (instancetype)providerWithStructureId:(NSString *)structureId;

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock;
- (SCNNestAwayState)away;
- (void)setAway:(SCNNestAwayState)away completion:(void(^)(NSError *error))completion;

@end
