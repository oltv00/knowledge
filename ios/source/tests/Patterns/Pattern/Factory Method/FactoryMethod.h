//
//  Product.h
//  Pattern
//
//  Created by Oleg Tverdokhleb on 17/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject
- (void)saveExpenses:(NSInteger)price;
@end

@interface Product : NSObject

@property (assign, nonatomic) NSInteger price;
@property (strong, nonatomic) NSString *name;

- (NSInteger)getTotalPrice:(NSInteger)sum;
- (void)saveObject;

@end

@interface Toy : Product
@end

@interface Dress : Product
@end

@interface ProductGenerator : NSObject
- (Product *)getProduct:(NSInteger)price;
@end

@implementation Product
- (NSInteger)getTotalPrice:(NSInteger)sum {
  return self.price + sum;
}

- (void)saveObject {
  NSLog(@"Save object to Product database");
}
@end

@implementation Toy
- (void)saveObject {
  NSLog(@"Save object into Toy database");
}
@end

@implementation Dress
- (void)saveObject {
  NSLog(@"Save object into Dress database");
}
@end

@implementation ProductGenerator
- (Product *)getProduct:(NSInteger)price {
  if (price > 0 && price < 100) {
    return [Toy new];
  } else if (price >= 100) {
    return [Dress new];
  }
  return nil;
}
@end

@implementation Factory
- (void)saveExpenses:(NSInteger)price {
  ProductGenerator *pd = [ProductGenerator new];
  Product *expense = [pd getProduct:price];
  [expense saveObject];
}

@end
