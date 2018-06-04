# MVP - Triathlon Tracker

# User Story
 - User has_many logs
 - User can create a log
 - User can view a list of logs
 - User can view a single log
 - User can edit a single log
 - User can delete a log

 - User can signup
 - User can login
 - User can logout


# Log Functionality

 Date: YYYY/MM/DD
 Swim Distance (meters): XX 
 Bike Distance (meters): XX 
 Run Distance (meters): XX 


# View All Logs
 - List of dates are 'clickable'

 List of Dates:
 Date: YYYY/MM/DD
 Date: YYYY/MM/DD
 ...

 Total Swim (meters): XX
 Total Bike (meters): XX
 Total Run (meters): XX

 https://theflatironschool.typeform.com/to/B9BrgH



 Form Requirements:

The app is written in Sinatra and utilizes the MVC pattern. *
--True

Uses ActiveRecord with Sinatra. *
--True

Has multiple model objects. *
--True

Has at least one :has_many relationship on the User model. *
--True

Please provide example of :has_many relationship, including Model names and line numbers. (e.g. User has_many Recipes, User model line 3) *
--User has_many Logs

Has user accounts with the ability to register and log in. *
--True

Users can't modify content created by other users. *


Please describe how this is accomplished, including the Model name for the resource whose editing is limited (e.g. A Recipe cannot be edited if it does not belong to the current user because of this piece of code I wrote: ...) *



Includes user input validations that guard against creation of bad data. *
--True

Please describe the validations in place. *
--Requires a date and at least 1 activity with data.


Displays validation failures to user with an error message. *


The Project's README...
...is present. *
--True
...includes a short description of the project. *
--True
...includes install instructions for the project. *
True
...includes contributors guide for the project. *
True
...includes a license or link to the license for the project. *
True