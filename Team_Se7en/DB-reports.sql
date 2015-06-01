-- Report 1
SELECT CampaignName, Audience, Version, Subject, DeployDate, UniqueDelivers, UniqueOpens, UniqueClicks,
   (UniqueOpens / UniqueDelivers) AS OpenRate, (UniqueClicks / UniqueOpens) AS ClickToOpenRate,
   (UniqueClicks / UniqueDelivers) AS ClickRate, (UniqueUnsubs / UniqueOpens) AS UnsubRate
FROM EmailData;

-- Report 2
SELECT * FROM CustomerData;

-- Report 3
SELECT * FROM DeviceRegData;
