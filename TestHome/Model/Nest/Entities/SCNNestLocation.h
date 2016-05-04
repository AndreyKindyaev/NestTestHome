//
//  SCNNestLocation.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SCNNestLocation : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *whereId;
@property (nonatomic, strong) NSString *name;

@end
