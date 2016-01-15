//
//  GCBasicObject.h
//  GameChat
//
//  Created by zys on 13-1-17.
//  Copyright (c) 2013年 Ruoogle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonTypes.h"

@interface GCObject : NSObject


/* JSON转译为NSDictionary之后，根据Dictionary里面的key值进行初始化，自动调用|setValuesWithDictionary| */
- (id)initWithJSONDic:(NSDictionary *)jsonDic;

/* 根据Dictionary里面的key值进行赋值 */
- (void)setValuesWithDictionary:(NSDictionary *)dictionary;

/* 返回一个NSDictionary, 通过Key-Value方式把包含的数据传出去 
 
 @brief Allows generation of JSON for otherwise unsupported classes.
 
 If you have a custom class that you want to create a JSON representation for you can implement
 this method in your class. It should return a representation of your object defined
 in terms of objects that can be translated into JSON. For example, a Person
 object might implement it like this:
 
 @code
 - (id)proxyForJson {
 
   return [NSDictionary dictionaryWithObjectsAndKeys:
   name, @"name",
   phone, @"phone",
   email, @"email",
   nil];
 }
 
 @endcode */
- (id)proxyForJson;
- (id)proxyClientACKForJson;

/* 返回对象在JSON中的默认key值 */
+ (NSString *)jsonKey;

/* 保存到数据库抽象接口，父类做申明，不实现 */
- (void)saveToDB;
@end
