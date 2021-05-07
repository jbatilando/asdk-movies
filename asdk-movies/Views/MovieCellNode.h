//
//  MovieCellNode.h
//  asdk-movies
//
//  Created by Miguel Batilando on 5/5/21.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCellNode : ASCellNode
- (instancetype)initWithMovieObject:(Movie *)movie;
@end

NS_ASSUME_NONNULL_END
