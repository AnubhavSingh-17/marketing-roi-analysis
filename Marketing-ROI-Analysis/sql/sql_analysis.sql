#table creating
create database marketroi;
use marketroi;
create table marketing_data (
campaign_id int auto_increment unique,
company varchar(50), 
campaign_type varchar(50), 
target_audience varchar(50),
duration varchar(50), 
channel_used varchar(50),
conversion_rate decimal(5,2), 
acquisition_cost decimal(10,2),
roi decimal(10,2) ,
location varchar(50),
language_speaking varchar(50), 
clicks int,
impressions int,
engagement_score int,
customer_segment varchar(50),
date_of_campaign date
);

#importing data
describe marketing_data;
LOAD DATA LOCAL INFILE 'D:/Marketing-ROI-Analysis/data/marketing_campaign_dataset.csv'
INTO TABLE marketing_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:/Marketing-ROI-Analysis/data/marketing_campaign_dataset.csv'
INTO TABLE marketing_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select distinct campaign_type from marketing_data;
select distinct channel_used from marketing_data;

#best channel
select channel_used, avg(roi) as avg_roi from marketing_data group by channel_used order by avg_roi desc;

#best campaign type
select campaign_type, avg(roi) as avg_roi from marketing_data group by campaign_type order by avg_roi desc;

#best audience, who respsonse best
select target_audience, avg(roi) as avg_roi from marketing_data group by target_audience order by avg_roi desc;

#best location
select location, avg(roi) as avg_roi from marketing_data group by location order by avg_roi desc;

#comparing the cost of acquiring the customer using diff channels
select channel_used , (sum(acquisition_cost)/sum(clicks*conversion_rate)) as customer_acquiring_cost from marketing_data group by channel_used order by customer_acquiring_cost asc;

#ad performance
select channel_used, (sum(clicks) / sum(impressions)) as ad_perform from marketing_data group by channel_used;

#top 5 worst campaign
select * from marketing_data order by roi asc limit 5;

#avg return acc to engagement score
select engagement_score, avg(roi) as avg_roi from marketing_data group by engagement_score order by engagement_score;

