//
//  MoviesFeedNodeController.m
//  asdk-movies
//
//  Created by Miguel Batilando on 5/5/21.
//

#import "MoviesFeedNodeController.h"
#import "Movie.h"
#import "MovieCellNode.h"
#import "Constants.h"

#define AUTO_TAIL_LOADING_NUM_SCREENFULS  2.5

@interface MoviesFeedNodeController () <ASTableDelegate, ASTableDataSource>
@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) NSMutableArray *movies;
@end

@implementation MoviesFeedNodeController

- (instancetype)init {
    _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    self = [super initWithNode:_tableNode];

    if (self) {
        self.navigationItem.title = @"ASDK Movies";
        
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    // self.tableNode.leadingScreensForBatching = AUTO_TAIL_LOADING_NUM_SCREENFULS;  // overriding default of 2.0
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.node addSubnode:_tableNode];
        
    [self fetchMovies:^(NSMutableArray *movies, NSError *error) {
        if (movies) {
            self.movies = movies;
            [self.tableNode reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)fetchMovies:(void(^)(NSMutableArray *movies, NSError *error))completion {
    // TODO:
    // - Move this to Interactor
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/now_playing?api_key=%@", apiKey]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
            NSArray *movies = [Movie movies:dataDictionary[@"results"]];
            completion((NSMutableArray *)movies, nil);
        } else {
            NSLog(@"%@", error);
            completion(nil, error);
        }
    }];
    [task resume];
}

#pragma mark - ASTableDelegate
- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context {
    NSLog(@"willBeginBatchFetchWithContext");
}

#pragma mark - ASTableDataSource
- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie *movie = self.movies[indexPath.row];

    ASCellNode *(^cellNodeBlock)(void) = ^ASCellNode *() {
        ASCellNode *cellNode = [[MovieCellNode alloc] initWithMovieObject:movie];
        return cellNode;
    };
    
    return cellNodeBlock;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
