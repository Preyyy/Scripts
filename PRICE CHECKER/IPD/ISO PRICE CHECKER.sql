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

/*
 CAST(ROUND([1001]*0.20 + [1001], 2) AS FLOAT) AS hmoopd20,
 CONCAT('update iwitemprices set price = ''' ,CAST(ROUND([1001]*0.20 + [1001], 2) AS FLOAT),
 '''',' where FK_iwitems = ''',ItemID,'''',' and FK_mscPriceSchemes in (''1042'')' ),
 */
ItemID,
ItemDescription,
-- isolation
    [1005] as Isolation,

    --- 5% ISO

    [1017] as HMO_5_PERCENT_Isolation,

    case
        when round([1005] * 0.05 + [1005], 2) = [1017] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,

    cast(round([1005] * 0.05 + [1005], 2)as float) as iso5,

     ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1005] * 0.05 + [1005], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1017'')'
        ) AS SCRIPT_HMO05,


    --- 10% ISO
    [1038] as HMO_10_PERCENT_Isolation,
    case
        when round([1005] * 0.10 + [1005], 2) = [1038] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    cast(round([1005] * 0.10 + [1005], 2)as float) as iso10,

     ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1005] *  0.10 + [1005], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1038'')'
        ) AS SCRIPT_HMO10,

    --- 12% ISO
    [1046] as HMO_12_PERCENT_Isolation,
    case
        when round([1005] * 0.12 + [1005], 2) = [1046] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    cast(round([1005] * 0.12 + [1005], 2)as float) as iso12,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1005] *  0.12 + [1005], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1046'')'
        ) AS SCRIPT_HMO12,

    --- 15% ISO
    [1068] as HMO_15_PERCENT_Isolation,
    case
        when round([1005] * 0.15 + [1005], 2) = [1068] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK15,

    cast(round([1005] * 0.15 + [1005], 2)as float) as iso15,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1005] *  0.15 + [1005], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1068'')'
        ) AS SCRIPT_HMO15,


    
    --- 20% ISO
    [1065] as HMO_20_PERCENT_Isolation,
    case
        when round([1005] * 0.20 + [1005], 2) = [1065] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,

    cast(round([1005] * 0.20 + [1005], 2)as float) as iso20,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1005] *  0.20 + [1005], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1065'')'
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
-- where round([1005] * 0.05 + [1005], 2) != [1017]
-- where round([1005] * 0.10 + [1005], 2) != [1038]
--
--
--
--
ORDER BY ItemDescription;
