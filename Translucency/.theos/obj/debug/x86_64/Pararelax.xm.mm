#line 1 "Pararelax.xm"


typedef NS_ENUM(NSUInteger, UIBackgroundStyle) {
    UIBackgroundStyleDefault,
    UIBackgroundStyleTransparent,
    UIBackgroundStyleLightBlur,
    UIBackgroundStyleDarkBlur,
    UIBackgroundStyleDarkTranslucent,
    UIBackgroundStyleExtraDarkBlur,
    UIBackgroundStyleBlur
};

@interface UIApplication (UIBackgroundStyle)
-(void)_setBackgroundStyle:(UIBackgroundStyle)style;
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UIApplication; @class UIView; @class UIViewController; 


#line 17 "Pararelax.xm"
static void (*_logos_orig$ParallaxMain$UIViewController$viewDidAppear)(_LOGOS_SELF_TYPE_NORMAL UIViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$ParallaxMain$UIViewController$viewDidAppear(_LOGOS_SELF_TYPE_NORMAL UIViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$ParallaxMain$UIApplication$_setBackgroundStyle$)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, UIBackgroundStyle); static void _logos_method$ParallaxMain$UIApplication$_setBackgroundStyle$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, UIBackgroundStyle); static void (*_logos_orig$ParallaxMain$UIView$setBackgroundColor$)(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$ParallaxMain$UIView$setBackgroundColor$(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST, SEL, UIColor *); 



static void _logos_method$ParallaxMain$UIViewController$viewDidAppear(_LOGOS_SELF_TYPE_NORMAL UIViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$ParallaxMain$UIViewController$viewDidAppear(self, _cmd);
    
    [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleDarkBlur];
}



static void _logos_method$ParallaxMain$UIApplication$_setBackgroundStyle$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIBackgroundStyle backgroundStyle) {

    _logos_orig$ParallaxMain$UIApplication$_setBackgroundStyle$(self, _cmd, UIBackgroundStyleDarkBlur);
    
}


static void _logos_method$ParallaxMain$UIView$setBackgroundColor$(_LOGOS_SELF_TYPE_NORMAL UIView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIColor * color) {
    _logos_orig$ParallaxMain$UIView$setBackgroundColor$(self, _cmd, [UIColor clearColor]);
    
    [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleDarkBlur];
}



static __attribute__((constructor)) void _logosLocalCtor_36835025(int __unused argc, char __unused **argv, char __unused **envp) {
    
    
    
    
   
        {Class _logos_class$ParallaxMain$UIViewController = objc_getClass("UIViewController"); MSHookMessageEx(_logos_class$ParallaxMain$UIViewController, @selector(viewDidAppear), (IMP)&_logos_method$ParallaxMain$UIViewController$viewDidAppear, (IMP*)&_logos_orig$ParallaxMain$UIViewController$viewDidAppear);Class _logos_class$ParallaxMain$UIApplication = objc_getClass("UIApplication"); MSHookMessageEx(_logos_class$ParallaxMain$UIApplication, @selector(_setBackgroundStyle:), (IMP)&_logos_method$ParallaxMain$UIApplication$_setBackgroundStyle$, (IMP*)&_logos_orig$ParallaxMain$UIApplication$_setBackgroundStyle$);Class _logos_class$ParallaxMain$UIView = objc_getClass("UIView"); MSHookMessageEx(_logos_class$ParallaxMain$UIView, @selector(setBackgroundColor:), (IMP)&_logos_method$ParallaxMain$UIView$setBackgroundColor$, (IMP*)&_logos_orig$ParallaxMain$UIView$setBackgroundColor$);}
    
    
}

