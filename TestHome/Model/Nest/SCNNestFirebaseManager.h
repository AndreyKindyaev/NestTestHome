//
//  SCNNestFirebaseManager.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/3/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@interface SCNNestFirebaseManager : NSObject

+ (instancetype)sharedInstance;

- (void)observeUrl:(NSString *)url
   withObserverKey:(NSString *)key
       updateBlock:(void (^)(FDataSnapshot *snapshot))block;

- (void)removeObserverForUrl:(NSString *)url
             withObserverKey:(NSString *)key;

- (void)setValue:(id)value
          forUrl:(NSString *)url
     observerKey:(NSString *)observerKey
  withCompletion:(void(^)(NSError *error))completion;

@end
