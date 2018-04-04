#import <UIKit/UIKit.h>
#import <UIKit/UIApplication+Private.h>

@interface UIViewController (Z)
@property(readonly, nonatomic) UITableView *tableView;
@property(readonly, nonatomic) UITableView *collectionView;
@property(readonly, nonatomic) UITableView *table;
@property(readonly, nonatomic) UISearchController *searchController;
-(void)blurSearchBar;
-(void)fixMyNumber;
-(void)quickFix;
@property (assign) BOOL editMode;
@end

//@interface UIApplication (Z)
//- (void)_setBackgroundStyle:(long long)style;
//@end

@interface UIView (Z)
@property(nonatomic) UIColor *textColor;
@property(nonatomic) UILabel *textLabel;
@property(nonatomic) UILabel *nameLabel;
@property(nonatomic) UILabel *detailTextLabel;
-(void)clearBackgroundForView:(UIView *)view withForceWhite:(BOOL)force;
- (void)whiteTextForCell:(id)cell withForceWhite:(BOOL)force;
@end

@interface UITableViewCell (Z)
-(long long)tableViewStyle;
-(UITableView *)_tableView;
- (UILabel *)titleLabel;
- (UILabel *)valueLabel;
@end
@interface CNContactContentViewController
@property (assign) BOOL editMode;
@property(readonly, nonatomic) UITableView *tableView;
@end


//@interface UIApplication (Private)
//- (void)_setBackgroundStyle:(long long)style;
//@end
/*%hook UIView
-(void)setBackgroundColor:(UIColor *)color {
    if ([self isKindOfClass:[UIImageView class]] || [self isKindOfClass:[UIVisualEffectView class]] || [self isKindOfClass:[UIBlurEffect class]]) { %orig; }
    else { %orig([UIColor clearColor]); }
    //[[UIApplication sharedApplication] _setBackgroundStyle:3];
    [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleDarkBlur];
}
%end*/


static void createBlurView(UIView *view, CGRect bound, int effect)  {
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:effect]];
    visualEffectView.frame = bound;
    visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addSubview:visualEffectView];
    [view sendSubviewToBack:visualEffectView];
    [visualEffectView release];
}


%hook UIViewController


- (void)viewDidLoad {
    %orig;
        self.view.backgroundColor = [UIColor clearColor];
 //[[UIApplication sharedApplication] _setBackgroundStyle:3];
    [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleDarkBlur];
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nonexistant.jpg"]];
    iv.frame = [UIScreen mainScreen].bounds;
    
    

    
    
    //imported from Infinity
    createBlurView(iv, iv.frame, UIBlurEffectStyleDark);
    
    if ([ [[self class] description] isEqualToString:(@"ALApplicationPreferenceViewController")]) {
        //[((UITableView *)MSHookIvar<UITableView *>(self, "_tableView")) setBackgroundView:iv];
    }else if ([self respondsToSelector:@selector(table)]) {
        [self.table setBackgroundView:iv];
    //}else if ([self respondsToSelector:@selector(tableView)]) {
      //  [self.tableView setBackgroundView:iv];
    }else if ([self respondsToSelector:@selector(collectionView)]) {
        [self.collectionView setBackgroundView:iv];
    }else {
        // self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"/var/mobile/bg.jpg"]];
        // [self.view addSubview:iv];
        // [self.view sendSubviewToBack:iv];
        
        // NSLog(@">>> viewDidLoad >>> %@ %@", self, self.view);
        
        
        for(UITableView *v in [self.view subviews]) {
            if ([v isKindOfClass:[UITableView class]]) {
                 [v setBackgroundView:iv];
                v.backgroundColor = [UIColor clearColor];
            }
        }
        
        for(UICollectionView *v in [self.view subviews]) {
            if ([v isKindOfClass:[UICollectionView class]]) {
                 [v setBackgroundView:iv];
                v.backgroundColor = [UIColor clearColor];
            }
        }
        
        // if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.calculator"]) {
        //     [self.view addSubview:iv];
        //     [self.view sendSubviewToBack:iv];
        // }
        
        
    }
    
    @try {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    }
    @catch(NSException *e){}
    
    
    @try {
        if([[UIApplication sharedApplication].windows count] == 1)
        {
            UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
            [window addSubview:iv];
            [window sendSubviewToBack:iv];
        }
    }
    @catch(NSException *e){}
    
    for(UIWindow *window in [UIApplication sharedApplication].windows) {
        [window addSubview:iv];
        [window sendSubviewToBack:iv];
        window.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"var/mobile/nonexistant.jpg"]];
    }
    
    
    

}




%end

%hook UIApplication
-(void)_setBackgroundStyle:(UIBackgroundStyle)backgroundStyle {
    %orig(UIBackgroundStyleDarkBlur);
}
%end



