
{{config(materialized='view')}}

-----------------------------CUSTOMER MASTER-----------------------------
with v_customer_master as
(
    SELECT DISTINCT
	KNA1.KUNNR							AS Customer_Number
	,KNA1.NAME1							AS Customer_Name_1
	,KNA1.NAME2							AS Customer_Name_2
	,ADRC.COUNTRY                       AS Country_Key
	,T005T.LANDX                        AS Country_Name
	,ADRC.REGION                        AS Region_State_Province_County
	,T005U.BEZEI                        AS Region_State_Province_County_Name
	,KNA1.ORT01							AS Customer_City
	,KNA1.STRAS                         AS House_Number_Street
	,KNA1.TELF1                         AS Telephone_Number
	,KNA1.TELFX                         AS Fax_Number
	,KNA1.LOEVM                         AS Central_Deletion_Indicator
	,KNA1.XCPDK                         AS Onetime_Account_Indicator
	,KNA1.SORTL							AS Customer_Search_Term
	,KNA1.MCOD1                         AS Search_Term_Name_1
	,KNA1.MCOD2                         AS Search_Term_Name_2
	,KNA1.MCOD3                         AS Search_Term_City
	,KNA1.AUFSD                         AS Central_Order_Block
	,KNA1.BAHNE                         AS Express_Station
	,KNA1.BAHNS                         AS Train_Station
	,KNA1.BEGRU                         AS Authorization_Group
	,KNA1.BUBKZ                         AS Check_Digit
	,KNA1.ERDAT                         AS Customer_Created_On
	,KNA1.ERNAM                         AS Customer_Created_By
	,KNA1.EXABL                         AS Unloading_Points_Indicator
	,KNA1.FISKN                         AS Fiscal_Address
	,KNA1.KONZS                         AS Group_Key
	,KNA1.KTOKD                         AS Customer_Account_Group
	,KNA1.KUKLA                         AS Customer_Primary_Division
	,KNA1.LIFNR                         AS Vendor_Number
	,KNA1.LIFSD                         AS Central_Delivery_Block
	,KNA1.LOCCO                         AS Location_Code
	,KNA1.COUNC                         AS County_Code
	,KNA1.SPERR                         AS Central_Posting_Block
	,ADRC.LANGU                         AS Language_Key
	,T002T.SPTXT                        AS Language_Name
	,KNA1.STCD1                         AS Tax_Number_1
	,KNA1.STCD2                         AS Tax_Number_2
	,KNA1.TELF2                         AS Telephone_Number_2
	,KNA1.VBUND                         AS Trading_Partner
	,KNA1.STCEG                         AS VAT_Registration_Number
	,KNA1.DEAR2                         AS Sales_Partner_Indicator
	,KNA1.BRAN1                         AS Industry_Code_1
	,KNA1.BRAN5                         AS Industry_Code_5
	,KNA1.KATR10                        AS Attribute_10
	,KNA1.STKZN                         AS Natural_Person
	,KNA1.KTOCD                         AS Reference_Account_Group
	,KNA1.DUEFL                         AS Status_Of_Data_Transfer
	,KNA1.KDKG4                         AS Customer_Group_4
	,KNA1.FITYP                         AS Tax_Type
	,KNA1.STCDT                         AS Tax_Number_Type
	,KNA1.STCD3                         AS Tax_Number_3
	,KNA1.STCD4                         AS Tax_Number_4
	,KNA1.XICMS                         AS ICMS_Exemption
	,KNA1.BRSCH                         AS Industry_Key
	,KNA1.XSUBT                         AS Substit_Tribut_Cust_Grp
	,KNA1.CFOPC                         AS Customers_CFOP_Category
	,KNA1.TXLW1                         AS ICMS_Law
	,KNA1.TXLW2                         AS IPI_Law
	,KNA1.CASSD                         AS Central_Sales_Block
	,KNA1.KNURL                         AS URL
	,KNA1.J_1KFREPRE                    AS Name_Of_Representative
	,KNA1.J_1KFTBUS                     AS Type_Of_Business
	,KNA1.J_1KFTIND                     AS Type_Of_Industry
	,KNA1.NODEL                         AS Central_Deletion_Block
	,KNA1.OID_POREQD                    AS PO_Required_Indicator
	,KNA1.KATR4                         AS Attribute_4
	,ADRC.ADDRNUMBER                    AS Address_Number
	,ADRC.DATE_FROM                     AS Address_Valid_From
	,ADRC.NATION                        AS Address_Language_Version
	,ADRC.DATE_TO                       AS Address_Valid_To
	,ADRC.TITLE                         AS Title
	,ADRC.NAME1                         AS Name
	,ADRC.NAME2                         AS Name_2
	,ADRC.NAME3                         AS Name_3
	,ADRC.NAME4                         AS Name_4
	,ADRC.NAME_TEXT                     AS Converted_Name_Field
	,ADRC.NAME_CO                       AS Care_Of
	,ADRC.CITY1                         AS City
	,ADRC.CITY2                         AS City_District
	,ADRC.POST_CODE1                    AS Postal_Code
	,ADRC.POST_CODE2                    AS PO_Box_Postal_Code
	,ADRC.POST_CODE3                    AS Company_Postal_Code
	,ADRC.PO_BOX                        AS PO_Box
	,ADRC.PO_BOX_LOC                    AS PO_Box_City
	,ADRC.PO_BOX_REG                    AS PO_Box_Region
	,ADRC.TRANSPZONE                    AS Transportation_Zone
	,ADRC.STREET                        AS Street
	,ADRC.HOUSE_NUM1                    AS House_Number
	,ADRC.HOUSE_NUM2                    AS House_Number_Supplement
	,ADRC.HOUSE_NUM3                    AS House_Number_Range
	,ADRC.STR_SUPPL1                    AS Street_2
	,ADRC.STR_SUPPL2                    AS Street_3
	,ADRC.STR_SUPPL3                    AS Street_4
	,ADRC.LOCATION                      AS Street_5
	,ADRC.BUILDING                      AS Building
	,ADRC.FLOOR                         AS Floor
	,ADRC.ROOMNUMBER                    AS Room_Number
	,ADRC.ADDR_GROUP                    AS Address_Group
	,ADRC.FLAGGROUPS                    AS More_Address_Group_Indicator
	,ADRC.PERS_ADDR                     AS Personal_Address_Indicator
	,ADRC.SORT1                         AS Search_Term
	,ADRC.SORT2                         AS Search_Term_2
	,ADRC.DEFLT_COMM                    AS Communication_Method
	,ADRC.TEL_NUMBER                    AS First_Telephone_Number
	,ADRC.TEL_EXTENS                    AS First_Telephone_Extension
	,ADRC.FAX_NUMBER                    AS First_Fax_Number
	,ADRC.FAX_EXTENS                    AS First_Fax_Extension
	,ADRC.FLAGCOMM2                     AS Telephone_Numbers_Indicator
	,ADRC.FLAGCOMM3                     AS Fax_Numbers_Indicator
	,ADRC.FLAGCOMM4                     AS Teletex_Numbers_Indicator
	,ADRC.FLAGCOMM5                     AS Telex_Numbers_Indicator
	,ADRC.FLAGCOMM6                     AS Email_Addresses_Indicator
	,ADRC.FLAGCOMM7                     AS Remote_Mail_Address_Ind
	,ADRC.FLAGCOMM12                    AS URI_FTP_Address_Indicator
	,ADRC.FLAGCOMM13                    AS Pager_Address_Indicator
	,ADRC.MC_NAME1                      AS Name_In_Upper_Case
	,ADRC.MC_CITY1                      AS City_In_Upper_Case
	,ADRC.MC_STREET                     AS Street_In_Upper_Case
	,ADRC.EXTENSION1                    AS Data_Line
	,ADRC.EXTENSION2                    AS Telebox
	,ADRC.TIME_ZONE                     AS Time_Zone
	,ADRC.TAXJURCODE                    AS Tax_Jurisdiction
	,ADRC.LANGU_CREA                    AS Creation_Language
	,ADRC.ADRC_UUID                     AS Address_UUID
	,ADRC.UUID_BELATED                  AS Subsequent_UUID
	,ADRC.ADRC_ERR_STATUS               AS Address_Error_Status
	,ADRC.PO_BOX_LOBBY                  AS PO_Box_Lobby
	,ADRC.XPCPT                         AS Business_Purpose_Completed_Flag
    --,T077X.TXT30                        AS Customer_Account_Group_Name
    ,KNVP.Customer_Number_KNVP          AS Customer_Parent_Number
	,KNVP.Customer_Name                 AS Customer_Parent_Name
	,KNVP.Central_Deletion_Indicator    AS Customer_Parent_Central_Deletion_Indicator
	,KNA1.FAKSD                         AS Central_Billing_Block
	,TVAST.VTEXT                        AS Order_Block_Description
	,TVFST.VTEXT                        AS Billing_Block_Description
	,TVLST.VTEXT                        AS Delivery_Block_Description
    ,ADR6.Email_Address                 AS Email_Address
	,ADR6.Home_Email_Address_Indicator  AS Home_Email_Address_Indicator
	,TKUKT.VTEXT						AS Customer_Classification_Text
	
----------------KNA1----------------
FROM {{source('Customer','KNA1')}} AS KNA1
LEFT JOIN {{source('Customer','ADRC')}} AS ADRC
ON KNA1.ADRNR = ADRC.ADDRNUMBER
AND ADRC.NATION IN ('', 'C')
--AND KNA1.MANDT = ADRC.CLIENT
----------------T002T----------------
LEFT JOIN {{source('Customer','T002T')}} AS T002T
ON KNA1.SPRAS = T002T.SPRSL
AND T002T.SPRAS = 'E'
----------------T005T----------------
LEFT JOIN (SELECT * FROM {{source('Customer','T005T')}} WHERE SPRAS='E') AS T005T
ON KNA1.LAND1 = T005T.LAND1
LEFT JOIN {{ref('v_customer_parent')}} AS KNVP
ON KNA1.KUNNR = KNVP.Customer_Number
----------------TVFST----------------
LEFT JOIN {{source('Customer','TVFST')}} AS TVFST
ON KNA1.FAKSD = TVFST.FAKSP
AND TVFST.SPRAS = 'E'
----------------TVLST----------------
LEFT JOIN {{source('Customer','TVLST')}} AS TVLST
ON KNA1.LIFSD = TVLST.LIFSP
AND TVLST.SPRAS = 'E'
----------------TVAST----------------
LEFT JOIN {{source('Customer','TVAST')}} AS TVAST
ON KNA1.AUFSD = TVAST.AUFSP
AND TVAST.SPRAS = 'E'
LEFT JOIN {{ref('v_customer_emailaddress')}} AS ADR6
ON KNA1.ADRNR = ADR6.Address_Number
AND ADR6.Person_Number = ''
AND ADR6.Default_Email_Address_Indicator = 'X'
----------------TKURT----------------
LEFT JOIN {{source('Customer','TKUKT')}} AS TKUKT
ON KNA1.KUKLA = TKUKT.KUKLA
AND TKUKT.SPRAS = 'E'
----------------T005U----------------
LEFT JOIN {{source('Customer','T005U')}} T005U
ON ADRC.REGION = T005U.BLAND
and ADRC.COUNTRY = T005U.LAND1
and T005U.SPRAS = 'E'
)
select * from v_customer_master
