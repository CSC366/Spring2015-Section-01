SELECT Month, Year, State, Permission, Num_Customers
FROM AccountRegCube3D
GROUP BY Year, Month, State, Permission
;

-- CSV Query
/*SELECT CONCAT_WS(',', Month, Year, State, Permission, Num_Customers)
FROM AccountRegCube3D
GROUP BY Year, Month, State, Permission
;
*/