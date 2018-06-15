#import "API.h"

@implementation API

+ (API *)shared {
    static dispatch_once_t once;
    static API *instance;
    dispatch_once(&once, ^{
        if (!instance) {
            instance = [[API alloc] init];
            instance.imageCache = [[NSMutableDictionary alloc] init];
        }
    });
    return instance;
}

- (void)fetchMenuWithCompletion:(void (^)(NSArray<Pizza *> *, NSError *error))completion;
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.myjson.com/bins/d7wgd"]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (error || !data) {
                        completion(nil, error);
                        return;
                    }
                    
                    NSError *err;
                    NSArray *resArr = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:&err];
                    if (err) {
                        NSLog(@"Failed to serialize to JSON: %@", err);
                        completion(nil, error);
                        return;
                    }
                    
                    NSMutableArray<Pizza *> *parsedPizzas = [NSMutableArray arrayWithCapacity:resArr.count];
                    for (NSDictionary *item in resArr) {
                        Pizza *pizza = [[Pizza alloc] initWithDictionary:item];
                        NSLog(@"%@", [pizza description]);
                        [parsedPizzas addObject:pizza];
                    }
                    completion(parsedPizzas, nil);
                }] resume];
}

- (void)fetchMenuJSONWithCompletion:(void (^)(NSDictionary<NSString *, NSArray<Pizza *> *> *))completion {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
	
    NSDictionary *categories = array[0];

    NSDictionary<NSString *, NSArray<Pizza *> *> *pizzaMap  = [[NSMutableDictionary alloc] initWithCapacity:categories.count];
    
    for (NSString *key in categories.allKeys) {
        NSMutableArray *pizzas = categories[key];
        
        NSMutableArray<Pizza *> *parsedPizzas = [NSMutableArray arrayWithCapacity:pizzas.count];
        for (NSDictionary *item in pizzas) {
            Pizza *pizza = [[Pizza alloc] initWithDictionary:item];
            NSLog(@"%@", [pizza description]);
            [parsedPizzas addObject:pizza];
        }
        [pizzaMap setValue:parsedPizzas forKey:key];
    }
    // completion
    completion(pizzaMap);
}
@end
