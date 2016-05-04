//
//  MTLJSONAdapter+SCNNest.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MTLJSONAdapter (SCNNest)

+ (MTLValueTransformer *)scnNestIdEntityDictionaryTransformerWithModelsOfClass:(Class)modelClass;

@end
