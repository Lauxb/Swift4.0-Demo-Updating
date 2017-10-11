//
//  UIButton+Layout.m
//  MethodSwizzle
//
//  Created by liuxb on 2017/10/11.
//  Copyright © 2017年 liuxb. All rights reserved.
//

#import "UIButton+Layout.h"
#import <objc/runtime.h>

@implementation UIButton (Layout)

static const char* titleRectKey = "lxb_titleRectKey";
static const char* imageRectKey = "lxb_imageRectKey";

- (CGRect)titleRect {
    return [objc_getAssociatedObject(self, titleRectKey) CGRectValue];
}

- (void)setTitleRect:(CGRect)titleRect {
    objc_setAssociatedObject(self, titleRectKey, [NSValue valueWithCGRect:titleRect], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)imageRect {
    return [objc_getAssociatedObject(self, imageRectKey) CGRectValue];
}

- (void)setImageRect:(CGRect)imageRect{
    objc_setAssociatedObject(self, imageRectKey, [NSValue valueWithCGRect:imageRect], OBJC_ASSOCIATION_RETAIN);
}


#pragma mark 通过运行时，动态替换方法
+ (void)load {
    MethodSwizzle(self, @selector(titleRectForContentRect:),@selector(override_titleRectForContentRect:));
    MethodSwizzle(self, @selector(imageRectForContentRect:),@selector(override_imageRectForContentRect:));
}

void MethodSwizzle(Class c, SEL originalSEL, SEL swappedSEL) {
    Method originalMethod = class_getInstanceMethod(c, originalSEL);
    Method swappedMethod = class_getInstanceMethod(c, swappedSEL);
    
    //运行时函数class_addMethod，如果方法已存在，则失败返回，可以用作“检查”
    if (class_addMethod(c, originalSEL, method_getImplementation(swappedMethod), method_getTypeEncoding(swappedMethod))) {
        //如果添加成功（在父类中重写的方法），再把目标类中的方法替换为旧有的实现
        class_replaceMethod(c, swappedSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swappedMethod);
    }
}

- (CGRect)override_titleRectForContentRect:(CGRect)contentRect {
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [self override_titleRectForContentRect:contentRect];
}

- (CGRect)override_imageRectForContentRect:(CGRect)contentRect {
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [self override_imageRectForContentRect:contentRect];
}

@end
