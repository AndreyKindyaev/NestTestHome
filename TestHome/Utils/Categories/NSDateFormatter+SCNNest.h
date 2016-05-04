//
//  NSDateFormatter+SCNNest.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (SCNNest)

// @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
+ (NSDateFormatter *)scnNestDateFormatter;

@end
