Despoina Evangelakou

           ------------------------------
           README file for run_analysis.R 
           ------------------------------

 
A bit of background Information 
-------------------------------

This script is provided for Getting, Cleaning and Reshaping the "Human Activity Recognition Using Smartphones Dataset (Version 1.0)". 

The experiment was executed by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto of the Smartlab - Non Linear Complex Systems Laboratory, DITEN - Università degli Studi di Genova. Its aim was to study the sensitiviy of a wearable device (Smartphone Samsung S2) to activity changes, such as walking, standing, lying, etc. 

Content of script 
-----------------

The run_analysis.R is a simple R script that gets the interesting data files, merges together the training and test dataset, cleans the data from any duplicates, makes the correspondence between measurements recorded during the experiment, and activities performed (walking, laying, etc.) and the subjects themselves. The goal was to provide a new tidier dataset that allows a more flexible and complete analysis of data. 

The produced, new dataset contains only the average of mean- and std- related vaiables per activity for each subject. 

How To Run It
-------------

To run the script, download it and save it to the directory where you have saved your data (not inside the data directory). Then, source the code in your R console: 'source('run_analysis.R')'

Additional Information
----------------------
For more information on the experiment and the decisions taken during the data cleaning and tidying up, see the Codebook. 

Acknowledgement
---------------

I wouldn't have been able to complete this project if it wasn't for the very detailed explanations provided by David Hood ('https://class.coursera.org/getdata-031/forum/thread?thread_id=28' and 'https://class.coursera.org/getdata-031/forum/thread?thread_id=113'), the comments and involvement of my course colleagues, specially of Leonard Greski and Gregory D. Home. 

I have also benefitted a lot by the Hadley Wickham's dplyr tutorial at the useR! 2014 conference and Kevin Markham's YouTube tutorial. 

Copyright
---------

The script, this file and the codebook were all created by Despoina Evangelakou as part of the Getting and Cleaning Data course offered by the Johns Hopkins University. They were created on August 2015 and are free to be re-used (CC-BY) by anyone that finds them at all interesting or useful. 