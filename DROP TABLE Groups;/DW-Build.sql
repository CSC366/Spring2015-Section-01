INSERT INTO DW_Email_Action (Message_Key, Event_TypeName, Count)
SELECT Message_Key, Event_TypeName, count(*)
FROM (
	SELECT Message_Key, Email_Sent.Email_Sent_Key, Event_TypeName
	FROM Email_Sent
    LEFT JOIN Email_Action ON Email_Action.Email_Sent_Key = Email_Sent.Email_Sent_Key
	LEFT JOIN Email_Event_Type ON Email_Event_Type.Event_Type_Key = Email_Action.Event_Type_Key
	GROUP BY Message_Key, Email_Sent_Key, Event_TypeName
) b
GROUP BY Message_Key, Event_TypeName;

INSERT INTO DW_Campaign_Performance(Campaign_Name, Audience, Version, Subject_Line, Deployment_Date, numClicks, numComplaint, numOpened, numDelivered, numUnsubscribe, numBounce, numNotSent)
SELECT Campaign_Name, Audience, Version, Subject_Line, 
	(
		SELECT Deployment_Date
        FROM Email_Sent
		WHERE Messages.Message_Key = Email_Sent.Message_Key
        LIMIT 1
    ) AS Deployment_Date,
	IFNULL((
		SELECT Count
		FROM DW_Email_Action
        WHERE Messages.Message_Key = DW_Email_Action.Message_Key
			AND Event_TypeName = 'Click'
	),0) AS numClicks,
	IFNULL((
		SELECT Count
		FROM DW_Email_Action
        WHERE Messages.Message_Key = DW_Email_Action.Message_Key
			AND Event_TypeName = 'Complaint'
	),0) AS numComplaint,
	IFNULL((
		SELECT Count
		FROM DW_Email_Action
        WHERE Messages.Message_Key = DW_Email_Action.Message_Key
			AND Event_TypeName = 'Email Opened'
	),0) AS numOpened,
	IFNULL((
		SELECT Count
		FROM DW_Email_Action
        WHERE Messages.Message_Key = DW_Email_Action.Message_Key
			AND Event_TypeName = 'Email Sent/Delivered'
	),0) AS numDelivered,
	IFNULL((
		SELECT Count
		FROM DW_Email_Action
        WHERE Messages.Message_Key = DW_Email_Action.Message_Key
			AND Event_TypeName = 'Unsubscribe'
	),0) AS numUnsubscribe,
	IFNULL((
		SELECT sum(Count)
		FROM DW_Email_Action
        WHERE Messages.Message_Key = DW_Email_Action.Message_Key
			AND (Event_TypeName = 'Hard bounce'
				OR Event_TypeName = 'Soft bounce'
                OR Event_TypeName = 'Technical/Other bounce'
                OR Event_TypeName = 'Unknown bounce'
                OR Event_TypeName = 'Soft bounce'
                OR Event_TypeName = 'Block bounce'
			)
	),0) AS numBounce,
	IFNULL((
		SELECT Count
		FROM DW_Email_Action
        WHERE Messages.Message_Key = DW_Email_Action.Message_Key
			AND Event_TypeName = 'NotSent'
	),0) AS numNotSent
FROM Messages;

INSERT INTO DW_Customer_Reg (State, Reg_Month, Reg_Year, Cust_Permission, Count)
SELECT State, month(Registration_Date), year(Registration_Date), Permission, COUNT(*)
FROM Customer_Data 
GROUP BY State, MONTH(Registration_Date), year(Registration_Date), Permission;

INSERT INTO DW_Device_Reg (Reg_Month, Reg_Year, Count, Device_Model, Carrier)
SELECT Reg_Month, Reg_Year, Count, Device_Model, Carrier_Name
FROM (
	SELECT Device_Key, MONTH(Registration_Date) AS Reg_Month, YEAR(Registration_Date) AS Reg_Year, COUNT(*) AS Count
	FROM Device_Registrations 
    WHERE Device_Key IS NOT NULL
    GROUP BY Device_Key, MONTH(Registration_Date), YEAR(Registration_Date)
) DR
LEFT JOIN Device_Models DM ON DR.Device_Key = DM.Device_Key
LEFT JOIN Carriers C ON DM.Carrier_Key = C.Carrier_Key;
