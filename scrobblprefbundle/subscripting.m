
// Taken from MobileTerminal project

@interface NSDictionary (Subscripts)
- (id)objectForKeyedSubscript:(id)key;
@end

@implementation NSDictionary (Subscripts)
- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}
@end

@interface NSMutableDictionary (Subscripts)
- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)key;
@end

@implementation NSMutableDictionary (Subscripts)
- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)key {
    [self setObject:object forKey:key];
}
@end

@interface NSArray (Subscripts)
- (id)objectAtIndexedSubscript:(NSUInteger)index;
@end

@implementation NSArray (Subscripts)
- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}
@end

@interface NSMutableArray (Subscripts)
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;
@end

@implementation NSMutableArray (Subscripts)
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    [self replaceObjectAtIndex:index withObject:object];
}
@end

@interface NSOrderedSet (Subscripts)
- (id)objectAtIndexedSubscript:(NSUInteger)index;
@end

@implementation NSOrderedSet (Subscripts)
- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}
@end

@interface NSMutableOrderedSet (Subscripts)
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;
@end

@implementation NSMutableOrderedSet (Subscripts)
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    [self setObject:object atIndex:index];
}
@end

