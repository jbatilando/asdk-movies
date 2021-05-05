//
//  MoviesViewController.m
//  asdk-movies
//
//  Created by Miguel Batilando on 5/4/21.
//

#import "MoviesViewController.h"
#import "Movie.h"
#import "Constants.h"

@interface MoviesViewController ()

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchMovies:^(NSArray *movies, NSError *error) {
        if (movies) {
            
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)fetchMovies:(void(^)(NSArray *movies, NSError *error))completion {
    // TODO:
    // - Hide API key
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
        } else {
            NSLog(@"%@", error);
        }
    }];
    [task resume];
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
