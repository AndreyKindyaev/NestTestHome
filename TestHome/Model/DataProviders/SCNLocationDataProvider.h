//
//  SCNLocationDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDataProvider.h"
#import "SCNNestLocation.h"

@interface SCNLocationDataProvider : SCNDataProvider

+ (instancetype)providerWithLocationId:(NSString *)locationId
                           structureId:(NSString *)structureId;

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock;
- (SCNNestLocation *)location;

@end
