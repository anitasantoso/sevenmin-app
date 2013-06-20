//
//  RecordsViewController.h
//  sevenmin-app
//
//  Created by Anita Santoso on 19/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLCalendarView.h"

@interface RecordsViewController : UIViewController<DSLCalendarViewDelegate>
@property (strong, nonatomic) IBOutlet DSLCalendarView *calendarView;

@end
