WITH PivotData AS (
  SELECT
    ip.FK_iwItems AS ItemID,
    ip.price AS ItemPrice,
    ip.FK_mscPriceSchemes AS PriceSchemeID,
    itm.itemgroup AS ItemGroup,
    itm.itemdesc AS ItemDescription,
    itm.FK_mscItemCategory AS ItemCategoryID,
    cat.description AS ItemCategory,
    ip.FK_mscWarehouse AS WarehouseID,
    wh.description AS WarehouseName
  FROM
    iwItemPrices ip
    INNER JOIN IwiTEMS itm ON ip.FK_iwItems = itm.PK_iwItems
    INNER JOIN mscItemCategory cat ON itm.FK_mscItemCategory = cat.PK_mscItemCategory
    INNER JOIN mscWarehouse wh ON ip.FK_mscWarehouse = wh.PK_mscWarehouse
    INNER JOIN iwWareItem wi ON wi.FK_iwItems = itm.PK_iwItems AND wi.FK_mscWarehouse = wh.PK_mscWarehouse
    INNER JOIN mscPriceSchemes ps ON ip.FK_mscPriceSchemes = ps.PK_mscPriceSchemes
  WHERE
    ip.FK_mscWarehouse = '1006'
    AND itm.FK_mscItemCategory = '1001'
    --- CHANGE WAREHOUSE AND ITEM CATEGORY

	-- PHARMA
    -- ip.FK_mscWarehouse = '1006'
    -- AND itm.FK_mscItemCategory = '1001'

	--XRAY
	-- ip.FK_mscWarehouse = '1001'
    -- AND itm.FK_mscItemCategory = '1004'

	-- CT SCAN
	-- ip.FK_mscWarehouse = '1002'
    -- AND itm.FK_mscItemCategory = '1005'

	-- ULTRASOUND
	-- ip.FK_mscWarehouse = '1003'
    -- AND itm.FK_mscItemCategory = '1006'

	-- LABORATORY Laboratory
	-- ip.FK_mscWarehouse = '1005'
    -- AND itm.FK_mscItemCategory = '1013'

	-- LABORATORY Clinical Microscopy
	-- ip.FK_mscWarehouse = '1005'
    -- AND itm.FK_mscItemCategory = '1021'

	-- LABORATORY Immunology and Serology
	-- ip.FK_mscWarehouse = '1005'
    -- AND itm.FK_mscItemCategory = '1020'

	-- LABORATORY Microbiology
	-- ip.FK_mscWarehouse = '1005'
    -- AND itm.FK_mscItemCategory = '1065'

	-- LABORATORY Chemistry
	-- ip.FK_mscWarehouse = '1005'
    -- AND itm.FK_mscItemCategory = '1022'

	-- LABORATORY Hematology
	-- ip.FK_mscWarehouse = '1005'
    -- AND itm.FK_mscItemCategory = '1028'

	-- LABORATORY Histopathology
	-- ip.FK_mscWarehouse = '1005'
    -- AND itm.FK_mscItemCategory = '1029'

	-- LABORATORY Blood Station
	-- ip.FK_mscWarehouse = '1005'
    -- AND itm.FK_mscItemCategory = '1031'

	-- OR/DR OR Services
	-- ip.FK_mscWarehouse = '1032'
    -- AND itm.FK_mscItemCategory = '1053'

	-- DR Services
	-- ip.FK_mscWarehouse = '1032'
    -- AND itm.FK_mscItemCategory = '1054'

	 -- ER Services
	 -- ip.FK_mscWarehouse = '1032'
     -- AND itm.FK_mscItemCategory = '1054'

	 -- MISCELLANEOUS Miscellaneous Charges 
	 -- ip.FK_mscWarehouse = '1044'
     -- AND itm.FK_mscItemCategory = '1011'
)
SELECT
  ItemID,
  ItemDescription,
  -- Semi private
  [1007] as Semi_Private,
  --- 5% Semi private
  [1019] as HMO_5_Semi_Private,
  CASE
    WHEN ROUND([1007] * 0.05 + [1007], 2) = [1019] THEN 'TRUE'
    ELSE 'FALSE'
  END as HMOCHECK5,
  CAST(ROUND([1007] * 0.05 + [1007], 2) AS FLOAT) as Semi5,
  --- SCRIPT FOR UPDATE
  CONCAT(
    'UPDATE iwitemprices SET price = ''',
    CAST(ROUND([1007] * 0.05 + [1007], 2, 2) AS FLOAT),
    '''',
    ' WHERE FK_iwitems = ''',
    ItemID,
    '''',
    ' AND FK_mscPriceSchemes IN (''1019'')'
  ) AS SCRIPT_HM05,
  --- 10% Semi private
  [1032] as HMO_10_PERCENT_Semi_Private,
  CASE
    WHEN ROUND([1007] * 0.10 + [1007], 2) = [1032] THEN 'TRUE'
    ELSE 'FALSE'
  END as HMOCHECK10,
  CAST(ROUND([1007] * 0.10 + [1007], 2) AS FLOAT) as Semi10,
  --- SCRIPT FOR UPDATE
  CONCAT(
    'UPDATE iwitemprices SET price = ''',
    CAST(ROUND([1007] * 0.10 + [1007], 2, 2) AS FLOAT),
    '''',
    ' WHERE FK_iwitems = ''',
    ItemID,
    '''',
    ' AND FK_mscPriceSchemes IN (''1032'')'
  ) AS SCRIPT_HM10,
  --- 12% Semi private
  [1048] as HMO_12_PERCENT_Semi_Private,
  CASE
    WHEN ROUND([1007] * 0.12 + [1007], 2) = [1048] THEN 'TRUE'
    ELSE 'FALSE'
  END as HMOCHECK12,
  CAST(ROUND([1007] * 0.12 + [1007], 2) AS FLOAT) as Semi12,
  --- SCRIPT FOR UPDATE
  CONCAT(
    'UPDATE iwitemprices SET price = ''',
    CAST(ROUND([1007] * 0.12 + [1007], 2, 2) AS FLOAT),
    '''',
    ' WHERE FK_iwitems = ''',
    ItemID,
    '''',
    ' AND FK_mscPriceSchemes IN (''1048'')'
  ) AS SCRIPT_HM12,
  --- 15% Semi private
  [1073] as HMO_12_PERCENT_Semi_Private,
  CASE
    WHEN ROUND([1007] * 0.15 + [1007], 2) = [1073] THEN 'TRUE'
    ELSE 'FALSE'
  END as HMOCHECK12,
  CAST(ROUND([1007] * 0.15 + [1007], 2) AS FLOAT) as Semi15,
  --- SCRIPT FOR UPDATE
  CONCAT(
    'UPDATE iwitemprices SET price = ''',
    CAST(ROUND([1007] * 0.15 + [1007], 2, 2) AS FLOAT),
    '''',
    ' WHERE FK_iwitems = ''',
    ItemID,
    '''',
    ' AND FK_mscPriceSchemes IN (''1073'')'
  ) AS SCRIPT_HM15,
  --- 20% Semi private
  [1059] as HMO_20_PERCENT_Semi_Private,
  CASE
    WHEN ROUND([1007] * 0.20 + [1007], 2) = [1059] THEN 'TRUE'
    ELSE 'FALSE'
  END as HMOCHECK20,
  CAST(ROUND([1007] * 0.20 + [1007], 2) AS FLOAT) as Semi20,
  --- SCRIPT FOR UPDATE
  CONCAT(
    'UPDATE iwitemprices SET price = ''',
    CAST(ROUND([1007] * 0.20 + [1007], 2, 2) AS FLOAT),
    '''',
    ' WHERE FK_iwitems = ''',
    ItemID,
    '''',
    ' AND FK_mscPriceSchemes IN (''1059'')'
  ) AS SCRIPT_HM20
FROM PivotData
PIVOT (
  MAX(ItemPrice)
  FOR PriceSchemeID IN (
    [1001], [1002], [1003], [1004], [1005], [1006], [1007], [1008], [1009], [1010],
    [1011], [1012], [1013], [1014], [1015], [1016], [1017], [1018], [1019], [1020],
    [1021], [1022], [1023], [1024], [1025], [1026], [1027], [1028], [1029], [1030],
    [1031], [1032], [1033], [1034], [1035], [1036], [1037], [1038], [1039], [1040],
    [1041], [1042], [1043], [1044], [1045], [1046], [1047], [1048], [1049], [1050],
    [1051], [1052], [1053], [1054], [1055], [1056], [1057], [1058], [1059], [1060],
    [1061], [1062], [1063], [1064], [1065], [1066], [1067], [1068], [1069], [1070],
    [1071], [1072], [1073], [1074], [1075], [1076], [1077], [1078], [1079], [1080],
    [1081]
  )
) AS PivotTable
-- where ROUND([1007] * 0.05 + [1007], 2) != [1019]
-- where ROUND([1007] * 0.10 + [1007], 2) != [1032]
-- where ROUND([1007] * 0.12 + [1007], 2) != [1048]
-- where ROUND([1007] * 0.15 + [1007], 2) != [1073]
-- where ROUND([1007] * 0.20 + [1007], 2) != [1059]
ORDER BY ItemDescription;
