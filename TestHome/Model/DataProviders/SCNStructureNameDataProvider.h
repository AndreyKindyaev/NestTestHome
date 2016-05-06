//
//  SCNStructureNameDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDataProvider.h"

@interface SCNStructureNameDataProvider : SCNDataProvider

+ (instancetype)providerWithStructureId:(NSString *)structureId;

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock;
- (NSString *)name;

@end
