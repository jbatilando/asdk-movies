//
//  MovieCellNode.m
//  asdk-movies
//
//  Created by Miguel Batilando on 5/5/21.
//

#import "MovieCellNode.h"

@implementation MovieCellNode {
    Movie          *_movie;
    ASNetworkImageNode  *_movieImageNode;
    ASTextNode          *_titleNode;
    ASTextNode          *_overviewNode;
}

- (instancetype)initWithMovieObject:(Movie *)movie {
    self = [super init];
    
    if (!(self = [super init]))
      return nil;
    
    _movie = movie;
    
    // TODO: movieImageNode
    _movieImageNode = [[ASNetworkImageNode alloc] init];
    _movieImageNode.URL = [NSURL URLWithString: [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500/%@", movie.posterPath]];
    [self addSubnode:_movieImageNode];

    _titleNode = [[ASTextNode alloc] init];
    _titleNode.attributedText = [[NSAttributedString alloc] initWithString:movie.title];
    [self addSubnode:_titleNode];
    
    _overviewNode = [[ASTextNode alloc] init];
    _overviewNode.attributedText = [[NSAttributedString alloc] initWithString:movie.overview];
    [self addSubnode:_overviewNode];
                
    [self setNeedsLayout];
    
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    _movieImageNode.style.preferredSize = CGSizeMake(100.0f, 200.0f);
    
    ASStackLayoutSpec *stackLayoutSpec = [ASStackLayoutSpec
                                          stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                          spacing:8.0f
                                          justifyContent:ASStackLayoutJustifyContentStart
                                          alignItems:ASStackLayoutAlignItemsStart
                                          children:@[_movieImageNode, _titleNode, _overviewNode]];
    
    return [ASInsetLayoutSpec
            insetLayoutSpecWithInsets:UIEdgeInsetsMake(8.0f, 16.0f, 8.0f, 16.0f)
            child:stackLayoutSpec];
}

@end
