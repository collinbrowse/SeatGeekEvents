# Fetch Rewards coding exercise (SeatGeekEvents)
An app to consume and display Seat Geek events

## Overview

Hi Fetch Rewards! Thank you so much for taking the time to look at my work. I had 
a blast working on it. Given the time frame, I had to make some tradeoffs here and
there. There's also some things outside of the scope of the exercise that I would do next. 
I've listed these all below. 

If there's anything else you need from me please let me know. My email is cbrowse13@gmail.com.

Thanks! 

## Features for the future
* Add Location Services to pull up events close to the user
* Add Lottie animations to animate the heart when a user favorites an event
* Add drag to refresh on the table view 
* Add an empty state view controller to show the user when there are no events or favorites
* Add an alert view to display errors and messages to the user

## Notes & Tradeoffs made
* The Seat Geek API seems to not have a way to get the picture of the home venue,
so I'm using a picture of a performer for the event
* Currently I am supporting iOS 13. I orginally made the app for iOS 14 before
changing the target deployment. While the switch wouldn't be technically difficult 
(like removing scene delegate), I would've had to re-engineer the data source for my
table view from a diffable data source to UITableViewDataSource functions. Given 
your comment about an unfinished application, I feel it's best to submit the application 
with the deployment target of iOS 13
* I decided to allow the user to favorite an event from the table view. This allows
for easy separation and organization of new events from favorited events. I felt as 
though this provided the best user experience because a user would want to easily 
access all favorites at the same time, and would not want to have to click on the 
event to favorite it. The ability to favorite an event from the table view reduces 
the number of taps by 2. 
