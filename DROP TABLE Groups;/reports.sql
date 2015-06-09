SELECT Campaign_Name, Audience, Version, Subject_Line, Deployment_Date,
	(numDelivered - numBounce) AS Delivered,
    numOpened,
    (numOpened/numDelivered) AS Open_Rate,
    IFNULL((numClicks/numOpened),0) AS Click_to_Open_Rate,
    (numClicks/numDelivered) AS Click_Rate,
    (numUnsubscribe/numDelivered) AS Unsub_Rate
FROM DW_Campaign_Performance
WHERE numDelivered > 0;

SELECT State, Reg_Year, Reg_Month, Cust_Permission, Count
FROM drop_table_group.DW_Customer_Reg
WHERE State != ''
ORDER BY Reg_Year, Reg_Month;

SELECT Carrier, Reg_Year, Reg_Month, Device_Model, Count
FROM drop_table_group.DW_Device_Reg
ORDER BY Reg_Year, Reg_Month;
