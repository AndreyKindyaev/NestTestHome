//
//  SCNStructuresDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCNNestStructure.h"

@interface SCNStructuresDataProvider : NSObject

+ (instancetype)providerWithUpdateBlock:(void(^)(NSError *error))updateBlock;

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock;

- (NSInteger)numberOfStructures;
- (SCNNestStructure *)structureAtIndex:(NSInteger)index;

@end
