#---------------
# library 
library(ggplot2)
library(reshape)

#---------------------------------------
# Set training data and connect to it 
# 
trainingData <- '/Users/soojunghong/Documents/kaggle/data/train_ver2.csv'
con = file(trainingData, "r")

#----------------
# Read 20 rows
partialData <- read.csv(con, nrows=50)
partialData
str(partialData)


#--------------------------------
# column and short description 
#
#ncodpers 	Customer code
#ind_empleado 	Employee index: A active, B ex employed, F filial, N not employee, P pasive (is employee of bank)
#ind_cno_fin_ult1 	Payroll Account
#conyuemp  	Spouse index. 1 if the customer is spouse of an employee
#segmento  	segmentation: 01 - VIP, 02 - Individuals 03 - college graduated
#sexo 	Customer's sex

#----------------------------
# Analysis of columns 

# employee of bank 
# ind_cno_fin_ult1 : payroll account
# employee of bank and payroll account has no relationship
employee_payroll <- partialData[, c('ind_empleado', 'ind_cno_fin_ult1')]
employee_payroll

print(partialData$ind_empleado)
table(partialData$ind_empleado)
table(partialData$ind_cno_fin_ult1)

table(employee_payroll)
dataFrame <- as.data.frame.matrix(table(employee_payroll)) 
dataFrame
plot(dataFrame$`1`)

#renta :	Gross income of the household
rentaData <- partialData[, c('renta')]
rentaData[is.na(rentaData)] <- 0
print(partialData$renta)

plot(partialData$renta)

#--------------------
# table for all types of account 
table(partialData$ind_ahor_fin_ult1) 	#Saving Account
table(partialData$ind_cco_fin_ult1) 	#Current Accounts
table(partialData$ind_fond_fin_ult1)  #Funds
table(partialData$ind_recibo_ult1) 	#Direct Debit

# age distribution 
factor(partialData$age)
table(partialData$age) #for each age, the number of occurrence
prop.table(table(partialData$age))
barplot(table(partialData$age))
barplot(prop.table(table(partialData$age))):
  
#-----------------------------
# relationship between age and 'ind_ecue_fin_ult1' 	e-account
print(partialData$ind_ecue_fin_ult1)
table(partialData$ind_ecue_fin_ult1) #portion of yes(1) and no(0)


age_eaccount <- partialData[, c("age", "ind_ecue_fin_ult1")]
age_eaccount
table(age_eaccount)
dataFrame <- as.data.frame.matrix(table(age_eaccount)) 
dataFrame
plot(dataFrame$`1`) #age and e-account number

cod_provData <- partialData[, c("ncodpers", "ind_actividad_cliente")]
cod_provData
data.frame(cod_provData)
  
prop.table(partialData)

#------------------------
#scatter plot matrics
pairs(partialData[,2:7])

customerNo <- partialData[, c("ncodpers")]
customerNo

segmentation <- partialData[, c("segmento")] 
segmentation 

age <- partialData[, c("age")]
age
payrollAccount <- partialData[,c("ind_cno_fin_ult1")]
payrollAccount

plot(segmentation, payrollAccount)
qplot(customerNo, age, data=partialData, geom="line")

dataForPCA <- partialData[, c("ncodpers", "age", "renta", "antiguedad")]  # ind_ahor_fin_ult1", "ind_tjcr_fin_ult1")]
dataForPCA[is.na(dataForPCA)] <- 0 #replace NA with zero
dataForPCA

#---------------------------------------
# PCA (Principle Component Analysis)
prin_comp <- prcomp(dataForPCA, scale. = T)
names(prin_comp)

biplot(prin_comp, scale = 0)

#----------------------
# 'age' and 'payroll' 
data_age_payroll <- partialData[, c("ncodpers","age", "ind_nomina_ult1")]
data_age_payroll

# get the range for the x and y axis
ageRange <- range(partialData$age)
payrollRange <- range(partialData$ind_nomina_ult1)
ageRange
payrollRange

# aggregate of 'age' and sum of 'ind_nomina_ult1'
aggdata <-aggregate(data_age_payroll$ind_nomina_ult1, by=list(data_age_payroll$age), FUN=sum)
aggdata

#----------------------------------------
# plot of 'int_nomina_ult1' of each age 
# Density curve
plot(data_age_payroll$age, data_age_payroll$ind_nomina_ult1, type="l", xlab="Age", ylab="Hold Payroll Account" ) 


#---------------------------
# close connection to file
close(con)

