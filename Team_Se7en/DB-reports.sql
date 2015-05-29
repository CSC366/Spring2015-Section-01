-- Report 1
SELECT CampaignName, Audience, Version, Subject, DeployDate, (UniqueOpens / UniqueDelivers) AS OpenRate,
   (UniqueClicks / UniqueOpens) AS ClickToOpenRate, (UniqueClicks / UniqueDelivers) AS ClickRate,
   (UniqueUnsubsb / UniqueOpens) AS UnsubRate
FROM EmailData
;

-- Report 2
SELECT State, MONTHNAME(RegDate) as Month, Permission,
   COUNT(DISTINCT CustomerID) as numCustomers
FROM CustomerData
WHERE State <> 'N/A'
GROUP BY State, MONTHNAME(RegDate), Permission
;

-- Report 3
SELECT Carrier, MONTHNAME(RegDate) as Month, Name as Device,
   COUNT(DISTINCT CustomerID) as numCustomers
FROM DeviceRegData
GROUP BY Carrier, MONTHNAME(RegDate), Name
;
