#import "ViewController.h"
#import "API.h"
#import "PizzaCell.h"
#import "Persist.h"
#import "UIImageView+Persist.h"

static NSString *const PizzaCellIdentifier = @"PizzaCell";


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray<Pizza *> *pizzas;
@property (nonatomic, strong) NSDictionary<NSString *,NSArray<Pizza *> *> *categorizedPizzas;

@end

@implementation ViewController 

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PizzaCell" bundle:nil] forCellReuseIdentifier:PizzaCellIdentifier];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Pull to Refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMenuFeed) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = [UIColor redColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Fetching Pizzas ..."];
    self.tableView.refreshControl = self.refreshControl;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchMenuFeed];
    [self fetchJSON];
}

#pragma mark - Private Methods

- (void)fetchMenuFeed {
    [[API shared] fetchMenuWithCompletion:^(NSArray<Pizza *> *pizzas, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            self.pizzas = [[Persist fetchPizzas] mutableCopy];
        } else {
            self.pizzas = [pizzas mutableCopy];
            [Persist savePizzas:pizzas];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        });
    }];
}

- (void)fetchJSON {
    [[API shared] fetchMenuJSONWithCompletion:^(NSDictionary<NSString *,NSArray<Pizza *> *> *pizzaMap) {
        self.categorizedPizzas = pizzaMap;
    }];
}

- (Pizza *)pizzaAtIndexPath:(NSIndexPath *)indexPath {
    return self.pizzas[indexPath.item];
}

- (void)configurePizzaCell:(PizzaCell *)cell withUser:(Pizza *)pizza {
    cell.name.text = pizza.name;
    cell.pizzaDescription.text = [pizza toppingsDescription];
    cell.pizzaImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pizza.menuAssetURL]]];
    [cell.pizzaImageView kd_setImageWithURL:pizza.menuAssetURL];
    cell.price.text = [@"$" stringByAppendingString:pizza.price];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categorizedPizzas.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categorizedPizzas.allKeys[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *pizzasInCategory = [self.categorizedPizzas valueForKey:self.categorizedPizzas.allKeys[section]];
    return pizzasInCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *pizzasInCategory = self.categorizedPizzas.allValues[indexPath.section];
    Pizza *pizza = pizzasInCategory[indexPath.row];

    PizzaCell *cell = [tableView dequeueReusableCellWithIdentifier:PizzaCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[PizzaCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PizzaCellIdentifier];
    }
    [self configurePizzaCell:cell withUser:pizza];
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    Pizza *pizza = [self pizzaAtIndexPath:indexPath];
//    PizzaCell *cell = [tableView dequeueReusableCellWithIdentifier:PizzaCellIdentifier forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[PizzaCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PizzaCellIdentifier];
//    }
//    [self configurePizzaCell:cell withUser:pizza];
//    return cell;
//}

@end
