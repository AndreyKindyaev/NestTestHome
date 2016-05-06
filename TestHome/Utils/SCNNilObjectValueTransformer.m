//
//  SCNNilObjectValueTransformer.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/6/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNilObjectValueTransformer.h"

@interface SCNNilObjectValueTransformer ()

@property (nonatomic, strong) id forwardNilValue;
@property (nonatomic, strong) id reverseNilValue;

@end

@implementation SCNNilObjectValueTransformer

+ (instancetype)transformerUsingForwardNilValue:(id)forwardNilValue
                                   forwardBlock:(MTLValueTransformerBlock)forwardBlock {
    SCNNilObjectValueTransformer *transformer =[self transformerUsingForwardBlock:forwardBlock];
    transformer.forwardNilValue = forwardNilValue;
    return transformer;
}

+ (instancetype)transformerUsingReversibleNilValue:(id)reversibleNilValue
                                   reversibleBlock:(MTLValueTransformerBlock)reversibleBlock {
    return [self transformerUsingForwardNilValue:reversibleNilValue
                                    forwardBlock:reversibleBlock
                                 reverseNilValue:reversibleNilValue
                                    reverseBlock:reversibleBlock];
}

+ (instancetype)transformerUsingForwardNilValue:(id)forwardNilValue
                                   forwardBlock:(MTLValueTransformerBlock)forwardBlock
                                reverseNilValue:(id)reverseNilValue
                                   reverseBlock:(MTLValueTransformerBlock)reverseBlock {
    SCNNilObjectValueTransformer *transformer = [self transformerUsingForwardBlock:forwardBlock
                                                                      reverseBlock:reverseBlock];
    transformer.forwardNilValue = forwardNilValue;
    transformer.reverseNilValue = reverseNilValue;
    return transformer;
}

+ (id)transformedValue:(id)value
  usingForwardNilValue:(id)forwardNilValue
          forwardBlock:(MTLValueTransformerBlock)forwardBlock {
    return [[self transformerUsingForwardNilValue:forwardNilValue
                                     forwardBlock:forwardBlock] transformedValue:value];
}

- (id)transformedValue:(id)value {
    return (nil == value) ? self.forwardNilValue : [super transformedValue:value];
}

- (id)reverseTransformedValue:(id)value {
    return (nil == value) ? self.reverseNilValue : [super reverseTransformedValue:value];
}

@end
