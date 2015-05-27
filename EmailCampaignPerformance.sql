CREATE TABLE EmailCampaignPerformanceTemp AS (
	SELECT CampaignName, Audience, Version, SubjectLine, DeploymentDate, Events.EventTypeID, COUNT(*) AS NumEmails
	FROM EmailMessagesSent LEFT JOIN EmailMessages
	ON EmailMessages.EmailMessageID = EmailMessagesSent.EmailMessageID  LEFT JOIN Events
	ON Events.EmailMessageID = EmailMessagesSent.EmailMessageID AND EmailMessagesSent.EmailID = Events.EmailID 
	GROUP BY CampaignName, Audience, Version, SubjectLine, DeploymentDate, EventTypeID
);

CREATE TABLE EmailCampaignPerformance AS (
	SELECT AllEmails.CampaignName, AllEmails.Audience, AllEmails.Version, AllEmails.SubjectLine, AllEmails.DeploymentDate, 
	 IFNULL(EmailsSent, 0) AS EmailsSent, IFNULL(EmailsBounced, 0) AS EmailsBounced, IFNULL(EmailsComplained, 0) AS EmailsComplained,
	 IFNULL(EmailsClicked, 0) AS EmailsClicked, IFNULL(EmailsOpened, 0) AS EmailsOpened, IFNULL(EmailsUnsubscribed, 0) AS EmailsUnsubscribed
	FROM (
		SELECT CampaignName, Audience, Version, SubjectLine, DeploymentDate
		FROM EmailMessagesSent LEFT JOIN EmailMessages
		ON EmailMessages.EmailMessageID = EmailMessagesSent.EmailMessageID
		GROUP BY CampaignName, Audience, Version, SubjectLine, DeploymentDate
	) AS AllEmails LEFT JOIN (
		SELECT CampaignName, Audience, Version, SubjectLine, DeploymentDate, NumEmails AS EmailsSent
		FROM EmailCampaignPerformanceTemp 
		WHERE EventTypeID = 20
	) AS EmailsSent 
	ON AllEmails.CampaignName = EmailsSent.CampaignName
	AND AllEmails.Audience = EmailsSent.Audience
	AND AllEmails.Version = EmailsSent.Version
	AND AllEmails.SubjectLine = EmailsSent.SubjectLine
	AND AllEmails.DeploymentDate = EmailsSent.DeploymentDate LEFT JOIN (
		SELECT CampaignName, Audience, Version, SubjectLine, DeploymentDate, SUM(NumEmails) AS EmailsBounced
		FROM EmailCampaignPerformanceTemp 
		WHERE EventTypeID != 0
		AND EventTypeID != 2
		AND EventTypeID != 11
		AND EventTypeID != 20
		AND EventTypeID != 37
		GROUP BY CampaignName, Audience, Version, SubjectLine, DeploymentDate
	) AS EmailsBounced
	ON AllEmails.CampaignName = EmailsBounced.CampaignName
	AND AllEmails.Audience = EmailsBounced.Audience
	AND AllEmails.Version = EmailsBounced.Version
	AND AllEmails.SubjectLine = EmailsBounced.SubjectLine
	AND AllEmails.DeploymentDate = EmailsBounced.DeploymentDate LEFT JOIN (
		SELECT CampaignName, Audience, Version, SubjectLine, DeploymentDate, NumEmails AS EmailsComplained
		FROM EmailCampaignPerformanceTemp 
		WHERE EventTypeID = 11
	) AS EmailsComplained
	ON AllEmails.CampaignName = EmailsComplained.CampaignName
	AND AllEmails.Audience = EmailsComplained.Audience
	AND AllEmails.Version = EmailsComplained.Version
	AND AllEmails.SubjectLine = EmailsComplained.SubjectLine
	AND AllEmails.DeploymentDate = EmailsComplained.DeploymentDate LEFT JOIN (
		SELECT CampaignName, Audience, Version, SubjectLine, DeploymentDate, NumEmails AS EmailsClicked
		FROM EmailCampaignPerformanceTemp 
		WHERE EventTypeID = 0
	) AS EmailsClicked
	ON AllEmails.CampaignName = EmailsClicked.CampaignName
	AND AllEmails.Audience = EmailsClicked.Audience
	AND AllEmails.Version = EmailsClicked.Version
	AND AllEmails.SubjectLine = EmailsClicked.SubjectLine
	AND AllEmails.DeploymentDate = EmailsClicked.DeploymentDate LEFT JOIN (
		SELECT CampaignName, Audience, Version, SubjectLine, DeploymentDate, NumEmails AS EmailsOpened
		FROM EmailCampaignPerformanceTemp 
		WHERE EventTypeID = 2
	) AS EmailsOpened
	ON AllEmails.CampaignName = EmailsOpened.CampaignName
	AND AllEmails.Audience = EmailsOpened.Audience
	AND AllEmails.Version = EmailsOpened.Version
	AND AllEmails.SubjectLine = EmailsOpened.SubjectLine
	AND AllEmails.DeploymentDate = EmailsOpened.DeploymentDate LEFT JOIN (
		SELECT CampaignName, Audience, Version, SubjectLine, DeploymentDate, NumEmails AS EmailsUnsubscribed
		FROM EmailCampaignPerformanceTemp 
		WHERE EventTypeID = 37
	) AS EmailsUnsubscribed
	ON AllEmails.CampaignName = EmailsUnsubscribed.CampaignName
	AND AllEmails.Audience = EmailsUnsubscribed.Audience
	AND AllEmails.Version = EmailsUnsubscribed.Version
	AND AllEmails.SubjectLine = EmailsUnsubscribed.SubjectLine
	AND AllEmails.DeploymentDate = EmailsUnsubscribed.DeploymentDate
);

DROP TABLE EmailCampaignPerformanceTemp;	





