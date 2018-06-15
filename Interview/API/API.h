#import <Foundation/Foundation.h>
#import "Pizza.h"

@interface API : NSObject

+ (API *)shared;

- (void)fetchMenuWithCompletion:(void (^)(NSArray<Pizza *> *, NSError *error))completion;

- (void)fetchMenuJSONWithCompletion:(void (^)(NSDictionary<NSString *, NSArray<Pizza *> *> *))completion;

@property (nonatomic, strong) NSMutableDictionary *imageCache;

@end
