//
//  Pizza.h
//  Interview
//
//  Created by Kevin Nguyen on 6/9/18.
//  Copyright © 2018 Zume Pizza, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topping.h"

@interface Pizza : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *menuDescription;
@property (nonatomic, strong) NSString *menuAssetURL;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSArray<Topping *> *toppings;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)toppingsDescription;

@end
