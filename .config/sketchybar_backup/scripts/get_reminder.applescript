# This script takes one argument: the name of the Reminders list.
on run argv
if (count of argv) is 0 then
return "" # Return nothing if no list name is provided
end if

set listName to item 1 of argv

try
tell application "Reminders"
# Get the first reminder in the specified list that is not completed.
set firstIncompleteReminder to the first reminder of list listName whose completed is false

# Return its name.
return name of firstIncompleteReminder
end tell
on error
# This "on error" block will run if the list doesn't exist
# or if there are no incomplete reminders in the list.
# In either case, we return an empty string.
return ""
end try
end run
