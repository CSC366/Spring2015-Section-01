-- Report 1
SELECT CampaignName, Audience, Version, Subject, DeployDate, UniqueDelivers, UniqueOpens, UniqueClicks,
   (UniqueOpens / UniqueDelivers) AS OpenRate, (UniqueClicks / UniqueOpens) AS ClickToOpenRate,
   (UniqueClicks / UniqueDelivers) AS ClickRate, (UniqueUnsubs / UniqueOpens) AS UnsubRate
FROM EmailData
INTO OUTFILE '~/366/report1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Report 2
SELECT * FROM CustomerData
INTO OUTFILE '~/366/report2.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Report 3
SELECT * FROM DeviceRegData
INTO OUTFILE '~/366/report3.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
