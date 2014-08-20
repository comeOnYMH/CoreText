//
//  CoreTextView.m
//  CoreText
//
//  Created by 杨名海 on 14-8-14.
//  Copyright (c) 2014年 杨名海. All rights reserved.
//

#import "CoreTextView.h"
#import <CoreText/CoreText.h>
@implementation CoreTextView
@synthesize mAttrStr;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mAttrStr = [[NSMutableAttributedString alloc] initWithString:@"古来圣贤皆寂寞，唯有饮者留其名，人生得意须尽欢，莫使金准空对月"];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    /*
    //简单测试代码
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    CGContextFillRect(ctx, CGRectMake(0, 200, 200, 100));
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 0.5);
    CGContextFillRect(ctx, CGRectMake(0, 200, 100, 200));
    */
    
    //每个字形都不做变换
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    
    //将y坐标导致到左上角
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height);
    CGContextConcatCTM(ctx, flipVertical);
    
    //设置字体属性
    UIFont *font = [UIFont systemFontOfSize:24];
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);
    [mAttrStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, 3)];
    
    
    //设置前景色(字体颜色)
    [mAttrStr addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor blueColor].CGColor range:NSMakeRange(4, 7)];
    
    //设置字体间距
    long charSpace = 10;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &charSpace);
    [mAttrStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)(num) range:NSMakeRange(0, 10)];
    
    //行间距
    CTParagraphStyleSetting paragraphSetting;
    CGFloat lineSpace = 10.0f;
    paragraphSetting.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    paragraphSetting.value = &lineSpace;
    paragraphSetting.valueSize = sizeof(lineSpace);
    
    //创建设置数组用于配置样式属性
    CTParagraphStyleSetting setters[] = {paragraphSetting};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(setters, 1);
    [mAttrStr addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)paragraphStyle range:NSMakeRange(0, mAttrStr.length)];
    
    
    
    //设置绘图框架CTFramesetter——CGMutablePath——CTFrame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mAttrStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(5, -5, self.bounds.size.width, self.bounds.size.height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    CTFrameDraw(frame, ctx);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
