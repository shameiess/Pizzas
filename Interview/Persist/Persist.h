//
//  Persist.h
//  Interview
//
//  Created by Kevin Nguyen on 6/9/18.
//  Copyright © 2018 Zume Pizza, Inc. All rights reserved.
//

#import "Pizza.h"

@interface Persist : NSObject

+ (void)savePizzas:(NSArray<Pizza *> *)pizzas;
+ (NSArray<Pizza *> *)fetchPizzas;

@end
