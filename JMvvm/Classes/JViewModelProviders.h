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

@property (nonatomic, copy)NSMutableDictionary* providerMap;

+ (instancetype)shareInstance;

+ (JViewModelProvider *)ofViewController:(UIViewController *)viewController;

+ (JViewModelProvider *)ofApplication:(UIApplication *)application;

+ (void)clean;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
