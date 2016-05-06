//
//  SCNDevicesDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDataProvider.h"
#import "SCNNestDevice.h"

@interface SCNDevicesDataProvider : SCNDataProvider

+ (instancetype)providerWithStructureId:(NSString *)structureId;

- (void)setUpdateBlock:(void(^)(NSError *error))updateBlock;

- (NSInteger)numberOfDeviceTypes;
- (NSString *)deviceTypeNameAtIndex:(NSInteger)index;
- (NSInteger)numberOfDevicesForTypeIndex:(NSInteger)index;
- (SCNNestDevice *)deviceAtIndexPath:(NSIndexPath *)indexPath;

@end
