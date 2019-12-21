//
//  MutableLiveData.h
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JObserver;

NS_ASSUME_NONNULL_BEGIN

@interface JMutableLiveData<T> : NSObject
{
    
}

@property (nonatomic, copy)NSDictionary<NSString*, JObserver *>* observerDic;

-(instancetype)init NS_DESIGNATED_INITIALIZER;

-(void)setValue:(T)value;

-(T)getValue;

-(void)observer:(void(^)(void))callBack atPath:(NSString *)path;

-(void)removeObserve:(NSString *)path;

-(void)removeAllObserve;

@end

NS_ASSUME_NONNULL_END
