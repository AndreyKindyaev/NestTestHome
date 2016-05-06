//
//  SCNNestDevice.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestDevice.h"

@implementation SCNNestDevice

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"deviceId": @"device_id",
             @"softwareVersion": @"software_version",
             @"structureId": @"structure_id",
             @"locationId": @"where_id",
             @"name": @"name",
             @"longName": @"name_long",
             @"isOnlineNumber": @"is_online"};
}

@end
