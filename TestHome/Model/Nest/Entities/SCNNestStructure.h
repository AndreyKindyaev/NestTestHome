//
//  SCNNestStructure.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

typedef NS_ENUM(NSInteger, SCNNestAwayState) {
    SCNNestAwayStateUnknown,
    SCNNestAwayStateHome,
    SCNNestAwayStateAway,
    SCNNestAwayStateAutoAway,
};

@class SCNNestLocation;
@interface SCNNestStructure : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *structureId;
@property (nonatomic, strong) NSString *name;

@property (nonatomic) SCNNestAwayState away;

@property (nonatomic, strong) NSArray *thermostatIds;
@property (nonatomic, strong) NSArray *camerasIds;
@property (nonatomic, strong) NSArray *smokeCoAlarmIds;

@property (nonatomic, strong) NSArray<SCNNestLocation *> *locations;

+ (NSValueTransformer *)awayJSONTransformer;

@end
