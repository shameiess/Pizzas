//
//  Pizza.m
//  Interview
//
//  Created by Kevin Nguyen on 6/9/18.
//  Copyright © 2018 Zume Pizza, Inc. All rights reserved.
//

#import "Pizza.h"

@implementation Pizza

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _menuDescription = dictionary[@"menu_description"];
        _menuAssetURL = dictionary[@"menuAsset"][@"url"];
        _price = dictionary[@"price"];
        
        NSArray *toppingsArray = dictionary[@"toppings"];
        NSMutableArray<Topping *> *toppings = [NSMutableArray arrayWithCapacity:toppingsArray.count];
        for (NSDictionary *item in toppingsArray) {
            Topping *topping = [[Topping alloc] initWithDictionary:item];
            NSLog(@"%@", [topping description]);
            [toppings addObject:topping];
        }
        _toppings = toppings;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: name: %@, menuDescription: %@, menuAssetURL: %@, price: %@, toppings: %@>",
            [self class],
            _name,
            _menuDescription,
            _menuAssetURL,
            _price,
            [self toppingsDescription]
            ];
}

- (NSString *)toppingsDescription {
    NSMutableArray *result = [NSMutableArray array];
    for (Topping *topping in _toppings) {
        [result addObject:topping.name];
    }
    NSString *description = [result componentsJoinedByString:@", "];
    return description;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.menuDescription = [coder decodeObjectForKey:@"menuDescription"];
        self.menuAssetURL = [coder decodeObjectForKey:@"menuAssetURL"];
        self.price = [coder decodeObjectForKey:@"price"];
        self.toppings = [coder decodeObjectForKey:@"toppings"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.menuDescription forKey:@"menuDescription"];
    [coder encodeObject:self.menuAssetURL forKey:@"menuAssetURL"];
    [coder encodeObject:self.price forKey:@"price"];
    [coder encodeObject:self.toppings forKey:@"toppings"];
}

@end
