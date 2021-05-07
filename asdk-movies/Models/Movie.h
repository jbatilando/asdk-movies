//
//  Movie.h
//  asdk-movies
//
//  Created by Miguel Batilando on 5/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (atomic, strong) NSString *title;
@property (atomic, strong) NSString *overview;
@property (atomic, strong) NSString *posterPath;

- (id)init:(NSDictionary *)dictionary;
+ (NSArray *)movies:(NSArray *)dictionaries;
@end

NS_ASSUME_NONNULL_END
