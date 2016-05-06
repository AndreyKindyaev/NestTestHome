//
//  SCNNilObjectValueTransformer.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/6/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SCNNilObjectValueTransformer : MTLValueTransformer

+ (instancetype)transformerUsingForwardNilValue:(id)forwardNilValue
                                forwardBlock:(MTLValueTransformerBlock)forwardBlock;

+ (instancetype)transformerUsingReversibleNilValue:(id)reversibleNilValue
                                   reversibleBlock:(MTLValueTransformerBlock)reversibleBlock;

+ (instancetype)transformerUsingForwardNilValue:(id)forwardNilValue
                                   forwardBlock:(MTLValueTransformerBlock)forwardBlock
                                reverseNilValue:(id)reverseNilValue
                                   reverseBlock:(MTLValueTransformerBlock)reverseBlock;

+ (id)transformedValue:(id)value
  usingForwardNilValue:(id)forwardNilValue
          forwardBlock:(MTLValueTransformerBlock)forwardBlock;

@end
