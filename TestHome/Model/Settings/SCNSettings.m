//
//  SCNSettings.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNSettings.h"

#import "SCNNestStructure.h"

@implementation SCNSettings

+ (instancetype)sharedInstance {
    static SCNSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (void)updateActiveStructureIdWithAvailableStructures:(NSArray<SCNNestStructure *> *)structures {
    BOOL shoulReset = YES;
    if (nil != self.activeStructureId) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"structureId = %@", self.activeStructureId];
        if ([structures filteredArrayUsingPredicate:predicate].count > 0) {
            shoulReset = NO;
        }
    }
    if (shoulReset && structures.count > 0) {
        self.activeStructureId = structures[0].structureId;
    }
}

@end
