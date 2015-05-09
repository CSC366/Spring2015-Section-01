-- populating RegSrcs
INSERT INTO RegSrcs (RegSrcID, Name)
   (SELECT DISTINCT RegSrcID, RegSrcName
    FROM tempAccounts)
   UNION
   (SELECT DISTINCT RegSrcID, RegSrcName
    FROM tempDevices)
;

-- populating Devices
-- remove bad data
DELETE FROM tempModels
WHERE Name = '';
-- insert
INSERT INTO Devices (Model, Name, Type, Carrier)
   SELECT DISTINCT Model, Name, Type, Carrier
   FROM tempModels
;

-- populating Customers
INSERT INTO Customers (CustomerID, Zip, State, Gender, Income,
   Permission, Language, RegDate, Tier, NumRegs, RegSrcID)
   SELECT DISTINCT Ac.CustomerId, Ac.Zip, Ac.State, Ac.Gender, Ac.Income,
          Ac.Permission, Ac.Language, Ac.RegDate, Ac.Tier,
          D.numReg, Ac.RegSrcID
   FROM (SELECT DISTINCT CustomerID, Zip, State, Gender, Income,
                         Permission, Language, RegDate, Tier, RegSrcID
         FROM tempAccounts
         GROUP BY CustomerID) Ac,
        (SELECT DISTINCT CustomerID, numReg
         FROM tempDevices) D
   WHERE Ac.CustomerID = D.CustomerID
      OR Ac.CustomerID NOT IN (SELECT DISTINCT CustomerID
                               FROM tempDevices)
;

-- populating Registrations
INSERT INTO Registrations (RegID, PurchaseDate, PurchaseStoreName,
   PurchaseStoreState, PurchaseStoreCity, Ecomm, Serial, Model,
   RegDate, CustomerID, RegSrcID)
      SELECT RegID, PurchaseDate, PurchaseStoreName, PurchaseStoreState,
             PurchaseStoreCity, Ecomm, Serial, Model, RegDate,
             CustomerID, RegSrcID
      FROM tempDevices
;

-- populating Emails

-- populating Campaigns

-- populating Messages

-- populating Links

-- populating EventTypes

-- populating Events
