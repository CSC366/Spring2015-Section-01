SELECT * FROM EmailCampaignPerformance ORDER BY `Campaign Name`,Audience,Version,`Subject Line`,`Deployment Date`;
SELECT * FROM AccountRegistrationReport ORDER BY `MONTHNAME(CustomerAccount.regDate)`,`YEAR(CustomerAccount.regDate)`;
SELECT * FROM DeviceRegistrationReport ORDER BY `MONTHNAME(DeviceRegistration.registration_date)`,`YEAR(DeviceRegistration.registration_date)`;
