//
//  FDataSnapshot+SCNValidation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/6/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "FDataSnapshot+SCNValidation.h"

@implementation FDataSnapshot (SCNValidation)

- (id)scnValue {
    id scnValue = nil;
    if (![self.value isKindOfClass:[NSNull class]]) {
        scnValue = self.value;
    }
    return scnValue;
}

@end
