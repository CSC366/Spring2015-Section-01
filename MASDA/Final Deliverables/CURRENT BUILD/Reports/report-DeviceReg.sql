SELECT Month, Year, Carrier_Name, model_id, Num_Customers
FROM DeviceRegCube3D, DevicesOLAP
WHERE DeviceRegCube3D.Device_Name = DevicesOLAP.id
GROUP BY Year, Month, Carrier_Name, Device_Name
;

-- CSV Query
/*SELECT CONCAT_WS(',', Month, Year, Carrier_Name, model_id, Num_Customers)
FROM DeviceRegCube3D, DevicesOLAP
WHERE DeviceRegCube3D.Device_Name = DevicesOLAP.id
GROUP BY Year, Month, Carrier_Name, Device_Name
;
*/