//
//  ADPoint.h
//  MyDemo
//
//  Created by Adu on 2018/9/6.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#ifndef ADPoint_h
#define ADPoint_h

struct ADPoint {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};

typedef struct ADPoint ADPoint;
typedef struct ADPoint ADPostion;


ADPoint ADPointMake(CGFloat x, CGFloat y, CGFloat z) {
    ADPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}


#endif /* ADPoint_h */
