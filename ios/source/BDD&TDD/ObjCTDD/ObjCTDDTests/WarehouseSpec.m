//
//  WarehouseSpec.m
//  ObjCTDD
//
//  Created by Oleg Tverdokhleb on 20/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "Warehouse.h"
#import "Candy.h"

SPEC_BEGIN(WarehouseSpec)

describe(@"Warehouse", ^{
  
  __block Warehouse *sut;
  beforeEach(^{
    sut = [Warehouse new];
  });
  
  context(@"when initialized", ^{
    it(@"should not be nil", ^{
      [[sut shouldNot] beNil];
    });
    
    it(@"should not contain any candies", ^{
      [[theValue([sut canPick:4]) should] beFalse];
      [[theValue([sut canPick:0]) should] beTrue];
    });
  });
  
  describe(@"when asked to put candies", ^{
    
    __block NSArray *candies;
    beforeEach(^{
      candies = @[[Candy new], [Candy new]];
    });
    
    it(@"should store it, and respond with proper amount", ^{
      [sut put:candies];
      [[sut.candies should] haveCountOf:2];
    });
  });
  
  describe(@"when asked to pick", ^{
    context(@"some candies but there are no candies", ^{
      [[[sut pick:5] should] beNil];
    });
    
    context(@"2 candies", ^{
      beforeEach(^{
        [sut put:@[[Candy new], [Candy new]]];
      });
      
      it(@"should give only available amount of candies", ^{
        [[[sut pick:1] should] haveCountOf:1];
        [[sut.candies should] haveCountOf:1];
        [[theValue([sut canPick:1]) should] beTrue];
        [[theValue([sut canPick:2]) should] beFalse];
      });
    });
  });
});

SPEC_END
