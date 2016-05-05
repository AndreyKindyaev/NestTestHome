//
//  SCNDevicesDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCNNestDevice.h"

@interface SCNDevicesDataProvider : NSObject

+ (instancetype)providerWithStructureId:(NSString *)structureId
                            updateBlock:(void(^)(NSError *error))updateBlock;

- (NSInteger)numberOfDeviceTypes;
- (NSString *)deviceTypeNameAtIndex:(NSInteger)index;
- (NSInteger)numberOfDevicesForTypeIndex:(NSInteger)index;
- (SCNNestDevice *)deviceAtIndexPath:(NSIndexPath *)indexPath;

@end
