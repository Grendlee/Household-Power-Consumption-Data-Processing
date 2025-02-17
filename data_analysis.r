#our library functions
library(zoo)

# print working directory
getwd()
#####################---------------PART1-------------#############################
# read the data.txt file
# made sure the data.txt file is in the same directory as this .R file
data <- read.table("Group_Assignment_Dataset.txt", header = TRUE, sep = ",")


#convert data column strings into datetime object to help with data processing and 
#to extract specific days from a time series according to a group number 16
data$Date <- as.POSIXlt(data$Date, format = "%d/%m/%Y")

print("missing values before interpolation")
print(colSums(is.na(data)))

#Apply linear interpolation to all missing (NA) values for each feature (column)
#loop through the columns in the data set
for (column in names(data))
{
  #check for atleast one missing (NA) vlaue in the feature
  if(any(is.na(data[[column]])))
  {
    #interprolate the missing (NA) value and fill it in
    data[[column]] <- na.approx(data[[column]])
  }
}

print("missing values after interpolation")
print(colSums(is.na(data)))

# now that are missing values (NA) have been filled in using linear interpolation
# we move on to detecting point anomalies

#used to calc percentage of anomalies
anomalies_counter <- 0

#copy of data that in separate from data
data_copy <- data.frame(data)

numeric_data <- Filter(is.numeric, data)

numeric_columns <- names(numeric_data)

#print out the column names that contain numeric data
print(numeric_columns)



#copy data to repplace with z-scores
zScores <-data

#for each column calculate the Z-scores
for(columns in numeric_columns)
{
  #Z-scrore is defined as (data point - mean)/ standard dev
  zScore <- (data[[columns]] - mean(data[[columns]])) / sd(data[[columns]])
  
  #now using the zScore we can count the number of outliers
  column_anomalies <- sum(abs(zScore) > 3)
  
  #print the number of anomalies and percentage for each column
  column_data_points <- length(data[[columns]])
  column_anomaly_percentage <- (column_anomalies / column_data_points) * 100
  
  print(paste("Column ", columns, ": ", column_anomalies, " anomalies out of ",  column_data_points, " column data points.","(", column_anomaly_percentage,"%)", sep = ""))
  
  #sum the number of anomalies found in this column
  anomalies_counter <- anomalies_counter + column_anomalies
  
  #replace data with zscore numbers
  zScores[[columns]] <- zScore
}

#total the number of data features
data_counter <- sum(lengths(data[numeric_columns]))

anomaly_percentage <- (anomalies_counter / data_counter) * 100
#print the percentage of anomalies and total feature counter
print(paste("----------------------------------------"))
print(paste("The total data count is: ", data_counter, ".", sep = ""))
print(paste("The total anomaly count is: ", anomalies_counter, ".", sep = ""))

print(paste("The precentage of anomalies in the entire data set is: ", anomaly_percentage,"%.", sep = ""))




#the 16th week starting from 1/1/2007 is april 23rd 2007 - april 29th 2007
first_day <- as.POSIXlt("23/4/2007", format = "%d/%m/%Y")
last_day <- as.POSIXlt("29/4/2007", format = "%d/%m/%Y")

#filter data for week 16 corresponding to our group
week_16_data <- subset(data, data$Date >= first_day & data$Date <= last_day)
week_16_zScores <- subset(zScores, zScores$Date >= first_day & zScores$Date <= last_day)

#print out head of week 16 data and z scores
print(head(week_16_data))
print(head(week_16_zScores))

#print out tail of week 16 data and z scores
print(tail(week_16_data))
print(tail(week_16_zScores))


#####################---------------PART2-------------#############################


#filter the numeric columns A, B ,C ,D ,E ,F ,G that are represented by...
#Global_active_power Column, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3
selected_week_16_data <-Filter(is.numeric, week_16_data)

#use cor() to calc to correlation matrix using the pearson method
correlation_matrix_week_16 <- cor(selected_week_16_data, method = "pearson")
#print the matrix using color coding to show statistical significance
corrplot(correlation_matrix_week_16)
#print the matrix raw values
print(correlation_matrix_week_16)