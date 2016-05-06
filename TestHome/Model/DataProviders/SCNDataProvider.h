//
//  SCNDataProvider.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestFirebaseManager.h"

@interface SCNDataProvider : NSObject

- (void)observeUrl:(NSString *)url updateBlock:(void(^)(FDataSnapshot *snapshot))updateBlock;
- (void)setValue:(id)value withCompletion:(void(^)(NSError *error))completion;

@end
