//
//  Topping.h
//  Interview
//
//  Created by Kevin Nguyen on 6/9/18.
//  Copyright © 2018 Zume Pizza, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topping : NSObject

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
