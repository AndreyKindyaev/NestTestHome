//
//  MTLJSONAdapter+SCNNest.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "MTLJSONAdapter+SCNNest.h"

@implementation MTLJSONAdapter (SCNNest)

+ (MTLValueTransformer *)scnNestIdEntityDictionaryTransformerWithModelsOfClass:(Class)modelClass {
    return [MTLValueTransformer transformerUsingForwardBlock:
            ^id(NSDictionary *idEntityDictionary, BOOL *success, NSError *__autoreleasing *error) {
                return [self modelsOfClass:modelClass
                             fromJSONArray:[idEntityDictionary allValues]
                                     error:error];
            }];
}

@end
