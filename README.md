
Sections 1-3: 

	1) I first read in the appropriate libraries (dplyr)  
	2) Set the working directory 
	3) Read in the activity labels, features, and all of the train and test files (for X, Y, and Subject)

Section 4: 

I combine the X, Y, and Subject data frames into 3 singular ones (that rbind the test and train data sets for each type)

Section 5-7: 

I process the X, Y, and subject dataframes separately 

	X: I extract all the mean and SD() columns (by grepping the features name list) and extracting those corresponding oclumns in X 
	Y: I merge this data with the activity labels to obtain all the activity name 
	Subject: I simply rename the Subject column names to "Subject ID"

Section 8: 

I combine X,Y, and Subject by cbinding all 3 sets together 

Section 9: 

I create a subset of the averages of the data created in previous steps. I use dplyr to group by Subject and Activity and apply a summarise_each function to find the average of the features data I selected (of the mean / sd variables extracted)

