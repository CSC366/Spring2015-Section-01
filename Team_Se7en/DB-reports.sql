-- Report 1
SELECT CampaignName, Audience, Version, Subject, DeployDate, as Delivered, as Opened, as Clickers, as OpenRate, as ClickToOpenRate, as ClickRate, as UnsubRate
FROM 

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
