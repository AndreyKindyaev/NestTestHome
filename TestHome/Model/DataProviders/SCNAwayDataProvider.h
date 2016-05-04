//
//  SCNAwayDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCNNestStructure.h"

@interface SCNAwayDataProvider : NSObject

+ (instancetype)providerWithStructureId:(NSString *)structureId
                            updateBlock:(void(^)(NSError *error))updateBlock;

- (SCNNestAwayState)away;
- (void)setAway:(SCNNestAwayState)away completion:(void(^)(NSError *error))completion;

@end
