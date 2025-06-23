/*
BUSINESS GOAL / BUSINESS PROBLEM
 1. Goal: Improve Forecast Accuracy Over Time

Problem Statement:
The forecasted sales often deviate from actual sales, leading to overstocking or stockouts.
 This impacts inventory costs and customer satisfaction. */

/* Question To Solve 1st Problem Statement 

1. What is The Average Forcast and Average Actual_Amount with Maximum and Min Amount of Each Category(Afer this, Check for how many times each category has sales more than thier daily average)
2. WHat is the Average Sales Amount Of Each Weekdays by category
3. Product That are majorly above forcast and Product That are Majorly Below Forecast
4. Total Sales By month and Total Forecast by Month
*/



/* Generating a new Table */
with New_Table as 
(SELECT
	Date,
    year(Date) as Year,
	monthname(Date) as Month,
    dayname(Date) as Day,
    category,
    Forecasted_Amount,
    Actual_Amount,
    Actual_Amount - Forecasted_Amount as SalesAndforecast_difference,
    case
		when Actual_Amount >= Forecasted_Amount then "Above_Forecast"
        else  "Below_Forecast"
	end PRoduct_Sales_Condition
FROM 
	random_dataset.coffee_shop_financial_data_2023)
    
SELECT
	*
FROM
	New_Table;


/* Identifying Key Performance Indicators */
with New_Table as 
(SELECT
	Date,
    year(Date) as Year,
	monthname(Date) as Month,
    dayname(Date) as Day,
    category,
    Forecasted_Amount,
    Actual_Amount,
    Actual_Amount - Forecasted_Amount as SalesAndforecast_difference,
    case
		when Actual_Amount >= Forecasted_Amount then "Above_Forecast"
        else  "Below_Forecast"
	end PRoduct_Sales_Condition
FROM 
	random_dataset.coffee_shop_financial_data_2023)
    
SELECT
	sum(Actual_Amount) as Total_Actual_Amount,
    sum(Forecasted_Amount) as Total_Forecasted_Amount,
    round(avg(Forecasted_Amount)) as Average_Forecast,
    round(avg(Actual_Amount)) as Avg_Actual_Amount,
    min(Actual_Amount) as Min_Actual_Amount,
    max(Actual_Amount) as Max_Actual_Amount
FROM
	New_Table;
	


/* 1. What is The Average Forcast and Average Actual_Amount with Maximum and Min Amount of Each Category */
/* Part 1 */
with New_Table as 
(SELECT
	Date,
    year(Date) as Year,
	monthname(Date) as Month,
    dayname(Date) as Day,
    category,
    Forecasted_Amount,
    Actual_Amount,
    Actual_Amount - Forecasted_Amount as SalesAndforecast_difference,
    case
		when Actual_Amount >= Forecasted_Amount then "Above_Forecast"
        else  "Below_Forecast"
	end PRoduct_Sales_Condition,
    case
		when Actual_Amount >= '381' then 1
        else  0
	end PRoduct_Sales_Condition_2

FROM 
	random_dataset.coffee_shop_financial_data_2023)
    
SELECT
	distinct category,
	avg(Forecasted_Amount) as Avg_Forecast,
    avg(Actual_Amount) as Avg_Actual_Amount,
    min(Actual_Amount) as Min_actual_Amount,
    Max(Actual_Amount) as Max_Actual_Amount,
    count(*) as Total_apperance,
    sum(PRoduct_Sales_Condition_2) as Total_Time_Above_General_Average_Amount
FROM
	New_Table
GROUP BY
	category
ORDER BY
	Avg_Actual_Amount DESC;
    


/* 1. What is The Average Forcast and Average Actual_Amount with Maximum and Min Amount of Each Category */
/* Part 2 */

with New_Table as 
(SELECT
	Date,
    year(Date) as Year,
	monthname(Date) as Month,
    dayname(Date) as Day,
    category,
    Forecasted_Amount,
    Actual_Amount,
    Actual_Amount - Forecasted_Amount as SalesAndforecast_difference,
    case
		when Actual_Amount >= Forecasted_Amount then "Above_Forecast"
        else  "Below_Forecast"
	end PRoduct_Sales_Condition,
    case
		when Actual_Amount >= '381' then 1
        else  0
	end T_Avg_Amount,

    case
		when Actual_Amount >= '300' then 1
        else  0
	end T_above_300,
    
    case
		when Actual_Amount >= '400' then 1
        else  0
	end T_above_400,

 case
		when Actual_Amount >= '500' then 1
        else  0
	end T_above_500,
    
 case
		when Actual_Amount >= '600' then 1
        else  0
	end T_above_600,

 case
		when Actual_Amount >= '700' then 1
        else  0
	end T_above_700,

 case
		when Actual_Amount >= '800' then 1
        else  0
	end T_above_800
FROM 
	random_dataset.coffee_shop_financial_data_2023)
    
SELECT
	distinct category,
	round(avg(Forecasted_Amount)) as Avg_Forecast,
    round(avg(Actual_Amount)) as Avg_Actual_Amount,
    count(*) as Total_apperance,
    round(sum(T_Avg_Amount)) as TTAG_AVG_Amount,
    round(sum(T_above_300)) as TTAG_300,
    round(sum(T_above_400)) as TTAG_400,
    round(sum(T_above_500)) as TTAG_500,
    round(sum(T_above_600)) as TTAG_600,
	round(sum(T_above_700)) as TTAG_700,
    round(sum(T_above_800)) as TTAG_800
FROM
	New_Table
GROUP BY
	category
ORDER BY
	Avg_Actual_Amount DESC;
    
    
    
/* Question 2 
2. WHat is the Average Sales Amount Of Each Weekdays by Category
*/

with New_Table as 
(SELECT
	Date,
    year(Date) as Year,
	monthname(Date) as Month,
    dayname(Date) as Day,
    category,
    Forecasted_Amount,
    Actual_Amount,
    Actual_Amount - Forecasted_Amount as SalesAndforecast_difference,
    case
		when Actual_Amount >= Forecasted_Amount then "Above_Forecast"
        else  "Below_Forecast"
	end PRoduct_Sales_Condition
FROM 
	random_dataset.coffee_shop_financial_data_2023)
    
SELECT
	distinct Day,
	round(avg(case when category ='Coffee Sales' then Actual_Amount end)) as Cofee_Sales,
    round(avg(case when category ='Food Sales' then Actual_Amount end)) as Food_Sales,
	round(avg(case when category ='Labor' then Actual_Amount end)) as Labor,
    round(avg(case when category ='Marketing' then Actual_Amount end)) as Marketing,
	round(avg(case when category ='Ingredients Cost' then Actual_Amount end)) as Ingredients_Cost,
	round(avg(case when category ='Rent' then Actual_Amount end)) as Rent,
	round(avg(case when category = 'Utilities' then Actual_Amount end)) as Utilities
FROM
	New_Table
GROUP BY
	Day
ORDER BY
	Day;
  
  
/* Question To Solve 1st Problem Statement 
3. Product That are majorly above forcast and Product That are Majorly Below Forecast
*/

with New_Table as 
(SELECT
	Date,
    year(Date) as Year,
	monthname(Date) as Month,
    dayname(Date) as Day,
    category,
    Forecasted_Amount,
    Actual_Amount,
    Actual_Amount - Forecasted_Amount as SalesAndforecast_difference,
    case
		when Actual_Amount >= Forecasted_Amount then "Above_Forecast"
        else  "Below_Forecast"
	end PRoduct_Sales_Condition
FROM 
	random_dataset.coffee_shop_financial_data_2023)
SELECT
	distinct category,
    round(avg(Actual_amount)) as avg_Actual_amount,
	sum(Forecasted_Amount) as Total_Forecasted_amount,
    sum(Actual_amount) as Total_Actual_amount,
	round(count(case when PRoduct_Sales_Condition ="Below_Forecast"  then PRoduct_Sales_Condition end)) as Below_Forecast,
    round(count(case when PRoduct_Sales_Condition ="Above_Forecast" then PRoduct_Sales_Condition end)) as Above_Forecast
    
FROM
	New_Table
GROUP BY
	category
ORDER BY
	category;
    
/* Question To Solve 1st Problem Statement 
4. Total Sales By month and Total Forecast by Month
*/

with New_Table as 
(SELECT
	Date,
    year(Date) as Year,
	monthname(Date) as Month,
    dayname(Date) as Day,
    category,
    Forecasted_Amount,
    Actual_Amount,
    Actual_Amount - Forecasted_Amount as SalesAndforecast_difference,
    case
		when Actual_Amount >= Forecasted_Amount then "Above_Forecast"
        else  "Below_Forecast"
	end PRoduct_Sales_Condition
FROM 
	random_dataset.coffee_shop_financial_data_2023)
SELECT
	distinct monthname(Date),
    round(avg(Actual_amount)) as avg_Actual_amount,
	sum(Forecasted_Amount) as Total_Forecasted_amount,
    sum(Actual_amount) as Total_Actual_amount
    
FROM
	New_Table
GROUP BY
	monthname(Date)
ORDER BY
	monthname(Date);
    
    

with New_Table as 
(SELECT
	Date,
    year(Date) as Year,
	monthname(Date) as Month,
    dayname(Date) as Day,
    category,
    Forecasted_Amount,
    Actual_Amount,
    Actual_Amount - Forecasted_Amount as SalesAndforecast_difference,
    case
		when Actual_Amount >= Forecasted_Amount then "Above_Forecast"
        else  "Below_Forecast"
	end PRoduct_Sales_Condition
FROM 
	random_dataset.coffee_shop_financial_data_2023)
SELECT
	distinct monthname(Date),
    avg(Forecasted_amount),
    count(monthname(Date)) as Total_count,
    sum(Forecasted_amount) / count(monthname(Date)) as Total_count
    
FROM
	New_Table
GROUP BY
	monthname(Date)
ORDER BY
	monthname(Date);
    
    


