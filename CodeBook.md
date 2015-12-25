## Code Book for Cleaning Project
### Input Files

The data was divided into 2 part - one for training data and the other for testing data.

- x_test.txt is the file which contatins the measurements for each of the variables for which the data was collected.
- y_test.txt is the file which contains the code for the activity for which the measurements. There is a different file which translates the code to the activity name
- subject_test.txt is the file which contains the contestant code for which the measurements and activity code is there. Each line represents a contestant. Contestant code are from 1 to 30.

- x_train.txt, y_train.txt and subject_train.txt are the equivalent files for the training data.

The features.txt file is the description of each of the variables for which measurements have been taken. This is used for the headings of the measurement file.

activity_labels.txt has the description for the activities names.

### Transformations to get to the tidy data

First I combined the 'test' data into one file such that the contestant number and activity code are the last 2 columns.
Then I combined the 'train' data into the same file as 'test' data.

x_all is the df which I used to rbind both the 'test' and 'train' data.

Next I read the features.txt file to get the measurement names. I added 2 columns at the end for contestant number and measurement.
This is used as the heading of the x_all df.

Next I subsetted the columns of x_all to get only the mean() and std() functions.

Now I read the activity_labels.txt to get the activity names for the activity codes which are in x_all.

The 'merge' function is used to merge x_all and activity names into one file. I called it x_needed_name

Next I made headings for the x_needed_name as meaningful.

group_by function is used to group by the fields contestant number and measurement name
Then it was just a case of using the summarize_each function to find the mean of each of the variables for the above grouping.

Write_table is used to write the above tidy data set to a physical file.

