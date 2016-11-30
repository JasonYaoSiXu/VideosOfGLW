//
//  MapperDictionary.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/21.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "MapperDictionary.h"

@implementation MapperDictionary

+(NSArray <NSDictionary *>*)mapperObject:(NSDictionary *)dict {
    
    NSMutableArray *dictArray = [[NSMutableArray alloc] init];
    NSArray <NSString *>* keyArray = [dict allKeys];
    
    NSMutableDictionary *dictItemArray = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in keyArray) {
        
        NSLog(@"%@",[key class]);
        
        if ([dict[key] isKindOfClass:[NSArray <NSDictionary *> class]]) {
            for (NSDictionary *itemDict in dict[key]) {
//                [dictArray addObject:[self mapperObject: itemDict]];
//                [dictArray addObject:[self dictionary: itemDict]];
                [dictArray addObjectsFromArray:[self mapperObject:itemDict]];
//                for (NSDictionary *item in [self mapperObject:itemDict]) {
//                    [dictArray addObject:item];
//                }
                
            }
        } else {
            dictItemArray[key] = dict[key];
        }
        
    }
    
    [dictArray addObject:dictItemArray];
    return dictArray;
}


+(NSDictionary *)dictionary:(NSDictionary *)dict {
    
    NSMutableDictionary *dictArray = [[NSMutableDictionary alloc] init];
    NSArray *keyArray = [dict allKeys];
    
    for(NSString *key in keyArray) {
        
        if (([dict[key] isKindOfClass:[NSArray <NSDictionary *> class]])) {
            
        } else {
            dictArray[key] = dict[key];
        }
        
    }
    
    return dictArray;
}



@end
