//
//  SCNNestLocation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestLocation.h"

@implementation SCNNestLocation

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"whereId": @"where_id",
             @"name": @"name"};
}

@end
