//
//  SCNSettings.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

@class SCNNestStructure;
@interface SCNSettings : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSString *activeStructureId;

- (void)updateActiveStructureIdWithAvailableStructures:(NSArray<SCNNestStructure *> *)structures;

@end
