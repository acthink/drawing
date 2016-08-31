//
//  ViewController.m
//  MGConfigDemo
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 wmg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong, nullable) NSMutableArray * drawPaths;
@property (nonatomic, strong, nullable) NSMutableArray * drawLayers;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 44, 100, 50)];
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [clearBtn setTitle:@"clear" forState:UIControlStateNormal];
    clearBtn.tag = 1;
    [clearBtn addTarget:self action:@selector(backOrClear:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: clearBtn];
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, 100, 50)];
    backBtn.backgroundColor = [UIColor grayColor];
    [backBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    backBtn.tag = 2;
    [backBtn addTarget:self action:@selector(backOrClear:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: backBtn];
    
    
}

- (void)backOrClear:(UIButton *)sender{
    switch (sender.tag) {
        case 1:{
            for (CAShapeLayer * layer in self.drawLayers) {
                [layer removeFromSuperlayer];
            }
            self.drawLayers = nil;
            [self.drawPaths removeAllObjects];
        }
            break;
            
        default:{
            CAShapeLayer * layer = self.drawLayers.lastObject;
            
            [layer removeFromSuperlayer];
            [self.drawLayers removeLastObject];
        }
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:[[touches anyObject] locationInView:self.view]];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.frame = self.view.bounds;
    
    layer.path = path.CGPath;
    
    layer.lineWidth = 3.0f;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.miterLimit = 2.;
    layer.lineDashPhase = 10;
    layer.lineDashPattern = @[@1,@0];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.fillRule = kCAFillRuleEvenOdd;
//    layer setNeedsDisplayInRect:<#(CGRect)#>
    layer.lineCap = kCALineCapRound;
    
    layer.lineJoin = kCALineJoinRound;
    
    // 结合 CABasicAnimation 可以变成 动画绘制
    
    // 将layer添加进图层
    [self.view.layer addSublayer:layer];
    [self.drawPaths addObject:path];
    [self.drawLayers addObject:layer];

    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UIBezierPath * path = self.drawPaths.lastObject;
    CAShapeLayer * layer = self.drawLayers.lastObject;
    [path addLineToPoint:[[touches anyObject] locationInView:self.view]];
    layer.path = path.CGPath;
}

- (NSMutableArray *)drawPaths{
    if (_drawPaths == nil) {
        _drawPaths = [NSMutableArray array];
    }
    return _drawPaths;
}

- (NSMutableArray *)drawLayers{
    if (_drawLayers == nil) {
        _drawLayers = [NSMutableArray array];
    }
    return _drawLayers;
}




@end
