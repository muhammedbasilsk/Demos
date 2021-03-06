//
// NSManagedObject+RBExtras.m
//
// Copyright (c) 2011 Robert Brown
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "NSManagedObject+RBExtras.h"


@implementation NSManagedObject (RBExtras)

+ (id)createManagedObjectInContext:(NSManagedObjectContext *)context {
    
    return [self createManagedObjectWithName:NSStringFromClass([self class]) 
                                   inContext:context
                                    withZone:nil];
}

+ (id)createManagedObjectInContext:(NSManagedObjectContext *)context withZone:(NSZone *)zone {
    
    return [self createManagedObjectWithName:NSStringFromClass([self class]) 
                                   inContext:context
                                    withZone:zone];
}

+ (id)createManagedObjectWithName:(NSString *)name inContext:(NSManagedObjectContext *)context withZone:(NSZone *)zone {
    
    NSParameterAssert(name && context);
    
    NSEntityDescription * entDesc = [NSEntityDescription entityForName:name
                                                inManagedObjectContext:context];
    
    NSManagedObject * obj = [[self allocWithZone:zone] initWithEntity:entDesc 
                                       insertIntoManagedObjectContext:context];
    
    return obj;
}

- (id)loadIntoMOC:(NSManagedObjectContext *)moc {
    return [moc objectWithID:[self objectID]];
}

+ (NSArray *)managedObjectIDsFromSet:(NSSet *)set {
    return [self managedObjectIDsFromArray:[set allObjects]];
}

+ (NSArray *)managedObjectIDsFromArray:(NSArray *)array {
    
    NSMutableArray * objIDs = [NSMutableArray array];
    
    for (NSManagedObject * obj in array) {
        [objIDs addObject:[obj objectID]];
    }
    
    return objIDs;
}

+ (NSEntityDescription *)entityForContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription entityForName:NSStringFromClass([self class])
                       inManagedObjectContext:context];
}

+ (NSFetchRequest *)fetchRequestForContext:(NSManagedObjectContext *)context {
    NSFetchRequest * request = [NSFetchRequest new];
    [request setEntity:[self entityForContext:context]];
    return request;
}

@end
