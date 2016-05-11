//
//  SCNNilObjectValueTransformer+Presentation.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/11/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNilObjectValueTransformer.h"

@interface SCNNilObjectValueTransformer (Presentation)

+ (NSString *)nilDashesStringForValue:(id)value forwardBlock:(MTLValueTransformerBlock)forwardBlock;
+ (NSString *)nilDashesUIStringForDate:(NSDate *)date;
+ (NSString *)nilDashesStringForBoolValue:(NSNumber *)boolNumber;
+ (NSString *)nilDashesStringForNumberValue:(NSNumber *)number;

@end
