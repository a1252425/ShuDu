//
//  SDTXTReaderPageView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderPageView.h"
#import "SDTXTConfigModel.h"
#import <CoreText/CoreText.h>

@interface SDTXTReaderPageView ()
{
    NSString *_content;
}

@end

@implementation SDTXTReaderPageView

- (instancetype)initWithContent:(NSString *)pageContent {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        _content = pageContent;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIEdgeInsets insets = [SDTXTConfigModel sharedInstance].contentInsets;
    CGRect pathRect = CGRectMake(insets.left, insets.bottom, rect.size.width - insets.left - insets.right, rect.size.height - insets.top - insets.bottom);

    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_content attributes:[SDTXTConfigModel sharedInstance].attribute];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGPathRef path = CGPathCreateWithRect(pathRect, NULL);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetterRef);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CTFrameDraw(frameRef, context);
    CFRelease(frameRef);
}

@end
