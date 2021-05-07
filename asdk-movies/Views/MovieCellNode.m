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
    ASStackLayoutSpec *stackLayoutSpec = [ASStackLayoutSpec
                                          stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                          spacing:10.0f
                                          justifyContent:ASStackLayoutJustifyContentStart
                                          alignItems:ASStackLayoutAlignItemsStart
                                          children:@[_titleNode, _overviewNode]];
    
    return [ASInsetLayoutSpec
            insetLayoutSpecWithInsets:UIEdgeInsetsMake(8.0f, 16.0f, 8.0f, 16.0f)
            child:stackLayoutSpec];
}

@end
