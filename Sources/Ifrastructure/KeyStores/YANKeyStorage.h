//
//  YANKeyStorage.h
//  YMoney
//
//  Created by Дмитрий on 04.11.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YANKeyStorage : NSObject

-(instancetype) initForTest;

-(id)loadData:(NSString*)key;

-(BOOL)saveData:(id)data
        withKey:(NSString*)key;

-(BOOL)deleteDataWithKey:(NSString*)key;

-(BOOL)cleanKeyStorage;

@end


