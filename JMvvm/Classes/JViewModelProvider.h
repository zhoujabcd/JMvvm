//
//  JViewModelProvider.h
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JViewModelProvider : NSObject

@property(nonatomic, copy)NSDictionary *modelMap;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (id)get:(Class)className;

- (id)getByName:(NSString *)classStr;

@end

NS_ASSUME_NONNULL_END
