//
//  SCNNestDevice.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SCNNestDevice : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *softwareVersion;
@property (nonatomic, strong) NSString *structureId;
@property (nonatomic, strong) NSString *locationId;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *longName;

@property (nonatomic) BOOL isOnline;

@end
