## Cleaning Project
### The objective of this project is to get, clean and process a wearable comuting data set to make it more readable and to summarize it.

There are 2 sets of data:
- Test data
- Training data

The test and training data is each divided into 3 files:
- File containing the contestant id
- File containing the code for the type of activity being performed
- File containing the measurements for each of the variables

There are also meta data files which tells us the activity names, the measurement names etc

The objective of the project is to 
- combine the 2 test and training data
- extract only the mean and standard deviation measurments only
- change the labels of each of the measurements to meaningful names
- the activity names should be descriptive
- create a new tidy data set which summarizes the data by showing the mean value of each measurement grouping by the contestant number and activity name

I use the dplyr package in this project.
First i read each of the 6 data files into 5 variables.
Then i combine the test data into one variable by bringing the contestant number and the activity number into the main data file. The new columsn go to the end of the file
Do the same thing for the training data.
Now we have 2 variables will all the data for test and training data.

To achieve the 1st objective, we use the rbind command since the columns are same between the 2 variables.
Read the features.txt which is meta data about the measurements. Add the last 2 columns which we added to our original variable.
This is now our headings vector.

After looking at the features.txt we know which columns are for mean and std and which are neither of them.
so subset from the big group which has measuremens about all the employees

Merge the big data set with the activity name sheet.
Name the columns to meaningful values.

group by based on contestent number and activity name
Summarize each of the other variables based on above grouping.
