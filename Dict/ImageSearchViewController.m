//
//  ImageSearchViewController.m
//  Dict
//
//  Created by Oleksandr Kisilenko on 11/9/16.
//  Copyright © 2016 Oleksandr Kisilenko. All rights reserved.
//

#import "ImageSearchViewController.h"
#import <WebKit/WebKit.h>

@interface ImageSearchViewController ()

@end

@implementation ImageSearchViewController

- (void) viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration * theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView * webView = [[WKWebView alloc] initWithFrame: self.view.frame configuration: theConfiguration];
//    webView.navigationDelegate = self;
    NSURL * nsurl = [NSURL URLWithString: [[NSString alloc] initWithFormat: @"https://yandex.com/images/search?text=%@", self.term]];
    NSURLRequest * nsrequest = [NSURLRequest requestWithURL: nsurl];
    [webView loadRequest: nsrequest];
    [self.view addSubview: webView];

}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
