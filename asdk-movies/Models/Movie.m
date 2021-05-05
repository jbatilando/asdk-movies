//
//  Movie.m
//  asdk-movies
//
//  Created by Miguel Batilando on 5/4/21.
//

#import "Movie.h"

@implementation Movie

- (id)init:(NSDictionary *)dictionary {
    self = [super init];
    
    self.title = dictionary[@"title"];
    self.overview = dictionary[@"overview"];
    
    return self;
}

+ (NSArray *)movies:(NSArray *)dictionaries {
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        [movies addObject:[[Movie alloc] init:dictionary]];
    }
    return movies;
}

@end
