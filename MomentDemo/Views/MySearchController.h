//
//  MySearchController.h
//  uTel
//
//  Created by Jay on 27/10/2017.
//  Copyright © 2017 XIN QIANG TECHNOLOGY TRADE CO., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySearchController : UISearchController

- (void)changeBarTintColor:(UIColor *)barTintColor withNormal:(BOOL)normal;

- (void)changeSearchCancelButton;

- (void)changeSearchFieldColor:(UIColor *)color;

+ (MySearchController *)instance:(id<UISearchResultsUpdating>)searchResultsUpdaterDelegate withSearchDelegate:(id<UISearchBarDelegate>)searchBarDelegate;

+ (MySearchController *)instance:(id<UISearchResultsUpdating>)searchResultsUpdaterDelegate withSearchDelegate:(id<UISearchBarDelegate>)searchBarDelegate withSearchResultController:(UIViewController *)resultVC;

@end
