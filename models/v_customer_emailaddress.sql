{{config(materialized='view')}}

with v_customer_emailaddress as
(
    SELECT DISTINCT
        ADR6.ADDRNUMBER     AS Address_Number
       ,ADR6.CLIENT         AS Client
       ,ADR6.CONSNUMBER     AS Sequence_Number
       ,ADR6.DATE_FROM      AS Address_Valid_From
       ,ADR6.DFT_RECEIV     AS Standard_Recipient_Indicator
       ,ADR6.ENCODE         AS Desired_Data_Coding_Indicator
       ,ADR6.FLGDEFAULT    AS Default_Email_Address_Indicator
       ,ADR6.FLG_NOUSE      AS Communication_Number_Not_Used_Indicator
       ,ADR6.HOME_FLAG      AS Home_Email_Address_Indicator
       ,ADR6.PERSNUMBER     AS Person_Number
       ,ADR6.R3_USER        AS SAP_System_Indicator
       ,ADR6.SMTP_ADDR      AS Email_Address
       ,ADR6.SMTP_SRCH      AS Email_Address_Search_Field
       ,ADR6.TNEF           AS Receive_TNEF_Coding_Via_SMTP_Indicator
       ,ADR6.VALID_FROM     AS Valid_From
       ,ADR6.VALID_TO       AS Valid_To
	   ,ADRT.REMARK         AS Email_Note
FROM {{source('Customer','ADR6')}} AS ADR6 
LEFT JOIN  {{source('Customer','ADRT')}} AS ADRT
	ON ADR6.ADDRNUMBER = ADRT.ADDRNUMBER
	AND ADR6.PERSNUMBER = ADRT.PERSNUMBER
	AND ADR6.CONSNUMBER = ADRT.CONSNUMBER
	AND ADRT.COMM_TYPE ='INT'
	AND ADRT.LANGU ='E'
)select * from v_customer_emailaddress