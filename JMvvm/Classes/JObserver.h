//
//  JObserver.h
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JObserver : NSObject

@property(nonatomic, strong)void(^callBack)(void);

@end

NS_ASSUME_NONNULL_END
