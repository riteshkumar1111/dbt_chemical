{{config(materialized='view')}}

with v_customer_parent as
(
    select KNVP_SEL.KNA1_KUNNR                  AS Customer_Number
          ,KNVP_SEL.NAME1                       AS Name
          ,KNVP_SEL.KTOKD                       AS Customer_Account_Group
          ,KNVP_SEL.KUNN2                       AS Partner_Customer_Number
          ,KNVP_SEL.PARVW                       AS Partner_Function
          ,KNVP_SEL.KNVP_KUNNR                  AS Customer_Number_KNVP
          -- ,KNA1_SEL.Customer_Number             AS Customer
          ,KNA1_SEL.Name                        AS Customer_Name
          ,KNA1_SEL.Central_Deletion_Indicator  AS Central_Deletion_Indicator
from(select KNA1.KUNNR  AS KNA1_KUNNR
            ,KNA1.NAME1  
            ,KNA1.KTOKD
            ,KNVP.KUNN2
            ,KNVP.PARVW  
            ,KNVP.KUNNR  AS KNVP_KUNNR 
            from {{source('Customer','KNA1')}} AS KNA1
            LEFT JOIN {{source('Customer','KNVP')}} AS KNVP 
            ON KNVP.KUNN2 = KNA1.KUNNR AND KNVP.PARVW = 'WE' AND KNVP.SPART NOT IN ('IC','ID')
    ) AS KNVP_SEL -- Ship-to
    LEFT JOIN( SELECT KUNNR   AS Customer_Number
                      ,NAME1  AS Name
                      ,CASE WHEN LOEVM = 'X' THEN 'Deleted' ELSE '' END AS Central_Deletion_Indicator
                      FROM {{source('Customer','KNA1')}}
                      WHERE KTOKD IN ('0001','ZAFF')) KNA1_SEL  -- Sold-to, Affiliate
    ON KNVP_SEL.KNVP_KUNNR = KNA1_SEL.Customer_Number
    WHERE KNA1_SEL.Customer_Number IS NOT NULL
)select * from v_customer_parent