//
//  ViewController.m
//  ios_calendar
//
//  Created by Maxim Bilan on 1/1/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import "ViewController.h"
#import "PopoverViewController.h"
#import "UIPopoverController+iPhone.h"

@interface ViewController ()
{
    PopoverViewController *viewController;
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet CalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverContentController"];
    
    popover = [[UIPopoverController alloc] initWithContentViewController:viewController];
	popover.popoverContentSize = CGSizeMake(300, 320);
	popover.delegate = self;
	
    self.calendarView.calendarDelegate = self;

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	
	self.calendarView.minimumDate = [dateFormatter dateFromString:@"2018-02-20"];
	[self.calendarView setMinimumDate:[NSDate date]];
	//self.calendarView.maximumDate = [dateFormatter dateFromString:@"2019-06-10"];

	self.calendarView.shouldShowHeaders = YES;
	[self.calendarView refresh];
	
	//self.calendarView.dayCellWidth = 65;
	//self.calendarView.dayCellHeight = 65;
	//self.calendarView.monthCellWidth = 160;
	//self.calendarView.monthCellHeight = 60;
	//self.calendarView.yearCellWidth = 98;
	//self.calendarView.yearCellHeight = 60;
	//[self.calendarView refresh];
}

- (void)didChangeCalendarDate:(NSDate *)date
{
    NSLog(@"didChangeCalendarDate:%@", date);
}

- (void)didChangeCalendarDate:(NSDate *)date withType:(NSInteger)type withEvent:(NSInteger)event
{
    NSLog(@"didChangeCalendarDate:%@ withType:%ld withEvent:%ld", date, (long)type, (long)event);
}

- (void)didDoubleTapCalendar:(NSDate *)date withType:(NSInteger)type
{
    NSLog(@"didDoubleTapCalendar:%@ withType:%ld", date, (long)type);
}

- (void) didSelectRangeForStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate{
    NSLog(@"%s: start date :%@ \n end date : %@",__PRETTY_FUNCTION__,startDate,endDate);
}

- (IBAction)popoverButtonAction:(UIButton *)sender
{
    [popover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)buttonTap:(id)sender
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = 2014;
    comps.month= 9;
    comps.day = 15;
    NSDate *toDate = [cal dateFromComponents:comps];
    [self.calendarView setCurrentDate:toDate];
}

@end
