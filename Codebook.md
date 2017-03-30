<h2>Code book</h2>

This document provides information about the data used, and the transformation that have been done to the original data.

<h2>Data sets and script:</h2>

The script run_analysis.R gather data from a test data set and a training data set. More specific, the columns of the data
that contains mean and std for a range of features. Furthermore, the script tidy the data, and finally generate an aggregated
version of the data. The aggregated data is a mean of each feature for each activity, for each subject.
Each step in the script is commented in the script itself, for easy understanding.
Some of the steps could be done together, but then the code would be more difficult to read.
So, for the sake of this assignment, I've chosen to make the script a bit longer, but much easier to read.

<h2>The structure of the data sets are as follows:</h2>

Subject - A number for each person that have contributed to the test.
Activity - Six different activities that have been measured for each subject.

The activities are:

Walking
Walking_Upstairs
Walking_Downstairs
Sitting
Standing
Laying

Features - A total of 66 (mean and std) of a total of 561 measurements have been selected to create the final data set.
This, combined with one column for the subject, and one colum for the activity, makes a total of 68 columns in the tidy data set.

The labels for the features have been somewhat shortended, with the code gsub('[()]'.

A full description of all of the features is best obtained from the file features_info.txt, included with the original dataset.

<h2>Original data set information:</h2>

Taken from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

For more information read visit http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, the website where the original data came from.


Thanks to the following people for the work with generating the data used in this assignment:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
