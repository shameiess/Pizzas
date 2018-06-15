//
//  Persist.m
//  Interview
//
//  Created by Kevin Nguyen on 6/9/18.
//  Copyright © 2018 Zume Pizza, Inc. All rights reserved.
//

#import "Persist.h"

@implementation Persist

+ (NSString*)cachedPizzasPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray<NSURL *> *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *URL = URLs.firstObject;
    NSString *cachedEventsPath = [[URL URLByAppendingPathComponent:@"pizzas.data"] path];
    return cachedEventsPath;
}

+ (void)savePizzas:(NSArray<Pizza *> *)pizzas {
    NSString *cachedPizzasPath = [self cachedPizzasPath];
    BOOL isSucessfullySaved = [NSKeyedArchiver archiveRootObject:pizzas toFile:cachedPizzasPath];
    if (isSucessfullySaved) {
        NSLog(@"Saved pizzas");
    } else {
        NSLog(@"Failed to save pizzas");
    }
}

+ (NSArray<Pizza *> *)fetchPizzas {
    NSString *cachedPizzasPath = [self cachedPizzasPath];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:cachedPizzasPath];
}

@end
