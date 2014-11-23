Getting-and-Cleaning-Data
=========================
This repository is part of the Coursera Getting-and-Cleaning-Data Course. It consists of the following files
- readme.md -> a read me file to get an idea of what is in the repository as well as how the function run_analysis.R runs
- run_analysis.R -> an R code, where data taken from UCI HAR Dataset is investigated
- codebook.txt with a description of the variables

The data investigated are for Human Activity Recognition Using Smartphones Datasets. It is data of an experiment carried out on 30 volunteers, who had to perform 6 kind of activities. Different things are measured (s. Codebook for more information). Initially, there are test and train data. 

run_analysis.R
In order to be able to run this file, the working directory has to be the folder "UCI HAR Dataset".

The first part of run_analysis.R reads different files (the experiment result (signals), the person number, the activity) from the test data as well as the train data and merges them in one dataset, called dataset. The files are merged using cbind() and rbind(), respectively.

Then only those measurements are taken, where they have taken the mean or the std (standard deviation). For this, I read the additional file features.txt, the description for this file can be found in features_info.txt.  

The variables are obtained from applying different functions on the signals, such as mean, std, max, min. I selected those containing mean, std using the grep function and then update the dataset. I leave out those variables, where the angle is applied to the mean, as this is in my opinion no pure mean or std. 

Next, I look at the dataset and the column Activity, has numbers, which stand for a certain kind of activity. I substitute (using factor) these activities by their names, e.g. 1 is substituted by "WALKING". 

I then rename the columns of the experimental results. For this I read the names from the features.txt and substitute them for the meaningless original column names V1, etc.

Finally, I create a copy of this dataset, called dataclone. Using the aggregate function I create a new table containing the average of each variable and sort this by the Person and by the activity he or she is doing. I do this for every variable. 

The result is stored in a text file called result.txt.

