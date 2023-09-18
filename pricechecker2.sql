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
)
SELECT

/*
 CAST(ROUND([1001]*0.20 + [1001], 2) AS FLOAT) AS hmoopd20,
 CONCAT('update iwitemprices set price = ''' ,CAST(ROUND([1001]*0.20 + [1001], 2) AS FLOAT),
 '''',' where FK_iwitems = ''',ItemID,'''',' and FK_mscPriceSchemes in (''1042'')' ),
 */
ItemID,
ItemDescription,
-- OPD BASE 
[1001] as Outpatient,


    --- 5% OPD
    [1016] as CURRENT_HMO_5_PERCENT_Outpatient,
    case
        when round([1001] * 0.05 + [1001], 2) = [1016] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,

    cast(round([1001] * 0.05 + [1001], 2) AS FLOAT) as hmo5opd,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1001] * 0.05 + [1001], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1016'')'
        ) AS SCRIPT_HMO5,


    --- 10% OPD
    [1029] as CURRENT_HMO_10_PERCENT_Outpatient,
    case
        when round([1001] * 0.10 + [1001], 2) = [1029] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,

    cast(round([1001] * 0.10 + [1001], 2) as float) as hmo10opd,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1001] * 0.10 + [1001], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1029'')'
        ) AS SCRIPT_HMO10,


    --- 15% OPD
    [1069] as CURRENT_HMO_15_PERCENT_Outpatient,
    case
        when round([1001] * 0.15 + [1001], 2) = [1069] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK15,

    cast(round([1001] * 0.15 + [1001], 2)as float) as hmo15opd,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1001] * 0.15 + [1001], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1069'')'
        ) AS SCRIPT_HMO15,


    --- 12% OPD
    [1044] as CURRENT_HMO_12_PERCENT_Outpatient,
    case
        when round([1001] * 0.12 + [1001], 2) = [1044] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,

    cast(round([1001] * 0.12 + [1001], 2)as float) as hmo12opd,
    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1001] * 0.12 + [1001], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1044'')'
        ) AS SCRIPT_HMO12,

    --- 20% OPD
    [1042] as CURRENT_HMO_20_PERCENT_Outpatient,
    case
        when round([1001] * 0.20 + [1001], 2) = [1042] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,

    cast(ROUND([1001] * 0.20 + [1001], 2)as float) as hmo20opd,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1001] * 0.20 + [1001], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1042'')'
        ) AS SCRIPT_HMO20,


-- ER
[1002] as Emergency,
    --- 5% ER
    [1015] as CURRENT_HMO_5_PERCENT_Emergency,
    case
        when round([1002] * 0.05 + [1002], 2) = [1015] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,

    cast(round([1002] * 0.05 + [1002], 2)as float) as er5,

    ---SCRIPT FOR UPDATE
    CONCAT(
        'update iwitemprices set price = ''',
        CAST(ROUND([1002] * 0.05 + [1002], 2) AS FLOAT),
        '''',
        ' where FK_iwitems = ''',
        ItemID,
        '''',
        ' and FK_mscPriceSchemes in (''1015'')'
    ) AS SCRIPT_HMO5,


    --- 10% ER
    [1028] as CURRENT_HMO_10_PERCENT_Emergency,
    case
        when round([1002] * 0.10 + [1002], 2) = [1028] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,

    cast(round([1002] * 0.10 + [1002], 2)as float) as er10,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1002] * 0.10 + [1002], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1028'')'
        ) AS SCRIPT_HMO10,


--- 12% ER
    [1041] as HMO_12_PERCENT_Emergency,
    case
        when round([1002] * 0.12 + [1002], 2) = [1041] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,

    cast(round([1002] * 0.12 + [1002], 2)as float) as er12,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1002] * 0.12 + [1002], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1041'')'
        ) AS SCRIPT_HMO12,


    --- 15% ER
    [1079] as CURRENT_HMO_15_PERCENT_Emergency,
    case
        when round([1002] * 0.15 + [1002], 2) = [1079] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK15,

    cast(round([1002] * 0.15 + [1002], 2)as float) as er15,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1002] * 0.15 + [1002], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1079'')'
        ) AS SCRIPT_HMO15,



    --- 20% ER
    [1056] as HMO_20_PERCENT_Emergency,
    case
        when round([1002] * 0.20 + [1002], 2) = [1056] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,

    cast(round([1002] * 0.20 + [1002], 2)as float) as er20,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(ROUND([1002] * 0.20 + [1002], 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1056'')'
        ) AS SCRIPT_HMO20,

        
-- CASH_TRANSACTION
[1004] as Cash_Transaction,

    --- 5% CASH
    [1027] as HMO_5_PERCENT_Cash_Transaction,
    case
        when round([1004] * 0.05 + [1004], 2) = [1027] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,

    cast(round([1004] * 0.05 + [1004], 2)as float) as cash5,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1004] * 0.05 + [1004], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1027'')'
        ) AS SCRIPT_HMO05,

        
    --- 10% CASH
    [1039] as HMO_10_PERCENT_Cash_Transaction,
    case
        when round([1004] * 0.10 + [1004], 2) = [1039] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,

    cast(round([1004] * 0.10 + [1004], 2)as float) as cash10,
    
     ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1004] * 0.10 + [1004], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1039'')'
        ) AS SCRIPT_HMO10,

        
    
    --- 12% CASH
    [1045] as HMO_12_PERCENT_Cash_Transaction,
    case
        when round([1004] * 0.12 + [1004], 2) = [1045] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,

    cast(round([1004] * 0.12 + [1004], 2)as float) as cash12,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1004] * 0.12 + [1004], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1045'')'
        ) AS SCRIPT_HMO12,


--- 15% CASH
    [1070] as HMO_12_PERCENT_Cash_Transaction,
    case
        when round([1004] * 0.15 + [1004], 2) = [1070] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK15,
    cast(round([1004] * 0.15 + [1004], 2)as float) as cash12,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1004] * 0.15 + [1004], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1070'')'
        ) AS SCRIPT_HMO15,


    --- 20% CASH
    [1066] as HMO_20_PERCENT_Cash_Transaction,
    case
        when round([1004] * 0.20 + [1004], 2) = [1066] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,

    cast(round([1004] * 0.20 + [1004], 2)as float) as cash20,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1004] * 0.20 + [1004], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1066'')'
        ) AS SCRIPT_HMO20,

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
        ) AS SCRIPT_HM20,


    -- private 
    [1006] as Private,
    --- 5% PRIVATE
    [1018] as HMO_5_PERCENT_Private,
    case
        when round([1006] * 0.05 + [1006], 2) = [1018] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    
    round([1006] * 0.05 + [1006], 2) as private5,

    ---SCRIPT FOR UPDATE
        CONCAT(
            'update iwitemprices set price = ''',
            CAST(round([1006] * 0.05 + [1006], 2, 2) AS FLOAT),
            '''',
            ' where FK_iwitems = ''',
            ItemID,
            '''',
            ' and FK_mscPriceSchemes in (''1018'')'
        ) AS SCRIPT_HM05,

    --- 10% PRIVATE
    [1031] as HMO_10_PERCENT_Private,
    case
        when round([1006] * 0.10 + [1006], 2) = [1031] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1006] * 0.10 + [1006], 2) as private10,
    --- 12% PRIVATE
    [1047] as HMO_12_PERCENT_Private,
    case
        when round([1006] * 0.12 + [1006], 2) = [1047] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1006] * 0.12 + [1006], 2) as private12,
    --- 20% PRIVATE
    [1058] as HMO_20_PERCENT_Private,
    case
        when round([1006] * 0.20 + [1006], 2) = [1058] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,
    round([1006] * 0.20 + [1006], 2) as private20,
    -- semi private
    [1007] as Semi_Private,
    --- 5% SEMI PRIVATE
    [1019] as HMO_5_Semi_Private,
    case
        when round([1007] * 0.05 + [1007], 2) = [1019] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    round([1007] * 0.05 + [1007], 2) as semi5,
    --- 10% SEMI PRIVATE
    [1032] as HMO_10_PERCENT_Semi_Private,
    case
        when round([1007] * 0.10 + [1007], 2) = [1032] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1007] * 0.10 + [1007], 2) as semi10,
    --- 12% SEMI PRIVATE
    [1048] as HMO_12_PERCENT_Semi_Private,
    case
        when round([1007] * 0.12 + [1007], 2) = [1048] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1007] * 0.12 + [1007], 2) as semi12,
    --- 20% SEMI PRIVATE
    [1059] as HMO_20_PERCENT_Semi_Private,
    case
        when round([1007] * 0.20 + [1007], 2) = [1059] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,
    round([1007] * 0.20 + [1007], 2) as semi20,
    -- suite
    [1008] as Suite,
    --- 5% SUITE
    [1020] as HMO_5_PERCENT_Suite,
    case
        when round([1008] * 0.05 + [1008], 2) = [1020] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    round([1008] * 0.05 + [1008], 2) as suite5,
    --- 10% SUITE
    [1033] as HMO_10_PERCENT_Suite,
    case
        when round([1008] * 0.10 + [1008], 2) = [1033] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1008] * 0.10 + [1008], 2) as suite10,
    --- 12% SUITE
    [1049] as HMO_12_PERCENT_Suite,
    case
        when round([1008] * 0.12 + [1008], 2) = [1049] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1008] * 0.12 + [1008], 2) as suite12,
    --- 20% SUITE
    [1060] as HMO_20_PERCENT_Suite,
    case
        when round([1008] * 0.20 + [1008], 2) = [1060] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,
    round([1008] * 0.20 + [1008], 2) as suite20,
    -- ward
    [1009] as Ward,
    --- 5% WARD
    [1021] as HMO_5_PERCENT_Ward,
    case
        when round([1009] * 0.05 + [1009], 2) = [1021] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    round([1009] * 0.05 + [1009], 2) as ward5,
    --- 10% WARD
    [1030] as HMO_10_PERCENT_Ward,
    case
        when round([1009] * 0.10 + [1009], 2) = [1030] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1009] * 0.10 + [1009], 2) as ward10,
    --- 12% WARD
    [1050] as HMO_12_PERCENT_Ward,
    case
        when round([1009] * 0.12 + [1009], 2) = [1050] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1009] * 0.12 + [1009], 2) as ward12,
    --- 20% WARD
    [1057] as HMO_20_PERCENT_Ward,
    case
        when round([1009] * 0.20 + [1009], 2) = [1057] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,
    round([1009] * 0.20 + [1009], 2) as ward20,
    -- recovery
    [1010] as Recovery,
    --- 5% RECOVERY
    [1022] as HMO_5_PERCENT_Recovery,
    case
        when round([1010] * 0.05 + [1010], 2) = [1022] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    round([1010] * 0.05 + [1010], 2) as recov5,
    --- 10% RECOVERY
    [1034] as HMO_10_PERCENT_Recovery,
    case
        when round([1010] * 0.10 + [1010], 2) = [1034] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1010] * 0.10 + [1010], 2) as recov10,
    --- 12% RECOVERY
    [1051] as HMO_12_PERCENT_Recovery,
    case
        when round([1010] * 0.12 + [1010], 2) = [1051] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1010] * 0.12 + [1010], 2) as recov12,
    --- 20% RECOVERY
    [1061] as HMO_20_PERCENT_Recovery,
    case
        when round([1010] * 0.20 + [1010], 2) = [1061] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,
    round([1010] * 0.20 + [1010], 2) as recov20,
    -- delivery
    [1011] as Delivery,
    --- 5% DELIVERY
    [1023] as HMO_5_PERCENT_Delivery,
    case
        when round([1011] * 0.05 + [1011], 2) = [1023] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    round([1011] * 0.05 + [1011], 2) as deli5,
    --- 10% DELIVERY
    [1035] as HMO_10_PERCENT_Delivery,
    case
        when round([1011] * 0.10 + [1011], 2) = [1035] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1011] * 0.10 + [1011], 2) as deli10,
    --- 12% DELIVERY
    [1052] as HMO_12_PERCENT_Delivery,
    case
        when round([1011] * 0.12 + [1011], 2) = [1052] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1011] * 0.12 + [1011], 2) as deli12,
    --- 20% DELIVERY
    [1062] as HMO_20_PERCENT_Delivery,
    case
        when round([1011] * 0.20 + [1011], 2) = [1062] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,
    round([1011] * 0.20 + [1011], 2) as deli20,
    -- NICU
    [1012] as NICU,
    --- 5% NICU
    [1024] as HMO_5_PERCENT_NICU,
    case
        when round([1012] * 0.05 + [1012], 2) = [1024] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    round([1012] * 0.05 + [1012], 2) as nicu5,
    --- 10% NICU
    [1040] as HMO_10_PERCENT_NICU,
    case
        when round([1012] * 0.10 + [1012], 2) = [1040] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1012] * 0.10 + [1012], 2) as nicu10,
    --- 12% NICU
    [1053] as HMO_12_PERCENT_NICU,
    case
        when round([1012] * 0.12 + [1012], 2) = [1053] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1012] * 0.12 + [1012], 2) as nicu12,
    --- 20% NICU
    [1067] as HMO_20_PERCENT_NICU,
    case
        when round([1012] * 0.20 + [1012], 2) = [1067] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,
    round([1012] * 0.20 + [1012], 2) as nicu20,
    -- ICU
    [1013] as ICU,
    --- 5% ICU
    [1025] as HMO_5_PERCENT_ICU,
    case
        when round([1013] * 0.05 + [1013], 2) = [1025] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    round([1013] * 0.05 + [1013], 2) as icu5,
    --- 10% ICU
    [1037] as HMO_10_PERCENT_ICU,
    case
        when round([1013] * 0.10 + [1013], 2) = [1037] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1013] * 0.10 + [1013], 2) as icu10,
    --- 12% ICU
    [1054] as HMO_12_PERCENT_ICU,
    case
        when round([1013] * 0.12 + [1013], 2) = [1054] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1013] * 0.12 + [1013], 2) as icu12,
    --- 20% ICU
    [1064] as HMO_20_PERCENT_ICU,
    case
        when round([1013] * 0.20 + [1013], 2) = [1064] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK20,
    round([1013] * 0.20 + [1013], 2) as icu20,
    -- NICU_ISO
    [1014] as NICU_Isolation,
    --- 5% NICU ISO
    [1026] as HMO_5_PERCENT_NICU_Isolation,
    case
        when round([1014] * 0.05 + [1014], 2) = [1026] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK5,
    round([1014] * 0.05 + [1014], 2) as nicu_iso5,
    --- 10% NICU ISO
    [1036] as HMO_10_PERCENT_NICU_Isolation,
    case
        when round([1014] * 0.10 + [1014], 2) = [1036] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK10,
    round([1014] * 0.10 + [1014], 2) as nicu_iso10,
    --- 12% NICU ISO
    [1055] as HMO_12_PERCENT_NICU_Isolation,
    case
        when round([1014] * 0.12 + [1014], 2) = [1055] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1014] * 0.12 + [1014], 2) as nicu_iso12,
    --- 20% NICU ISO
    [1063] as HMO_20_PERCENT_NICU_Isolation,
    case
        when round([1014] * 0.20 + [1014], 2) = [1063] then 'TRUE'
        else 'FALSE'
    end as HMOCHECK12,
    round([1014] * 0.20 + [1014], 2) as nicu_iso20
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

ORDER BY ItemDescription;
