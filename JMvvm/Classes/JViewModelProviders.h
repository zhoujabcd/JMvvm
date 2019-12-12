//
//  JViewModelProviders.h
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@class JViewModelProvider;
@class UIApplication;

NS_ASSUME_NONNULL_BEGIN

@interface JViewModelProviders : NSObject

@property (nonatomic, copy)NSDictionary* providerMap;

+ (instancetype)shareInstance;

+ (JViewModelProvider *)ofViewController:(UIViewController *)viewController;

+ (JViewModelProvider *)ofApplication:(UIApplication *)application;

+ (void)clean;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (void)addProvider:(JViewModelProvider *)provider key:(NSString *)key;

- (void)removeAllProvider;

@end

NS_ASSUME_NONNULL_END
