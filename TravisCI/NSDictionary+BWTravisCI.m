//
//  NSDictionary+BWTravisCI.m
//  TravisCI
//
//  Created by Bradley Grzesiak on 1/10/12.
//  Copyright (c) 2012 Bendyworks. All rights reserved.
//

#import "NSDictionary+BWTravisCI.h"

@implementation NSDictionary (BWTravisCI)

// Given self == {'a': '1', 'b': '2', 'c': '3'}
//
// [self subdictionaryUsingKeys:@"c", @"b", nil] == {'b': '2', 'c': '3'}
//
- (NSDictionary *)subdictionaryUsingKeys:(NSString *)keys, ...
{
    NSString *key;
    id value;
    NSMutableSet *keySet = [NSMutableSet set];
    va_list args;
    va_start(args, keys);
    for (key = keys; key != nil; key = va_arg(args, NSString*))
    {
        [keySet addObject:key];
    }
    va_end(args);
    
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:[keySet count]];
    for (key in keySet) {
        if ((value = [self objectForKey:key])) {
            [ret setValue:value forKey:key];
        }
    }

    return ret;
}

@end
