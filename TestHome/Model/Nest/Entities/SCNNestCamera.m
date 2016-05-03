//
//  SCNNestCamera.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestCamera.h"

@implementation SCNNestCamera

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"optionName": @"optionName",
             @"type": @"paymentType",
             @"amount": @"amount",
             @"productId": @"productId",
             @"debtSumLimit": @"debtSumLimit"};
}

@end
