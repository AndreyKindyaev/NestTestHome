//
//  SCNNestDevicePool.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

@class SCNNestSmokeCOAlarm, SCNNestThermostat, SCNNestCamera;
@interface SCNNestDevicePool : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray<SCNNestCamera *> *cameras;
@property (nonatomic, strong) NSArray<SCNNestSmokeCOAlarm *> *smokeCOAlarms;
@property (nonatomic, strong) NSArray<SCNNestThermostat *> *thermostats;

- (void)filterWithStructureId:(NSString *)structureId;
- (NSArray<SCNNestCamera *> *)filteredCameras;
- (NSArray<SCNNestSmokeCOAlarm *> *)filteredSmokeCOAlarms;
- (NSArray<SCNNestThermostat *> *)filteredThermostats;

@end
