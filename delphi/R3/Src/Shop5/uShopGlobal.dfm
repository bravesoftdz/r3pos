inherited ShopGlobal: TShopGlobal
  OldCreateOrder = True
  Left = 193
  Top = 106
  Height = 700
  Width = 1083
  object SYS_DEFINE: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select * from SYS_DEFINE where (TENANT_ID=0 or TENANT_ID=:TENANT' +
        '_ID) and COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_RIGHTS: TZQuery
    Tag = 1
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 136
    Top = 160
  end
  object CA_USERS: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select USER_ID,USER_SPELL,USER_NAME,ACCOUNT,DUTY_IDS,ROLE_IDS,SH' +
        'OP_ID,MM,DEPT_ID from VIW_USERS where COMM not in ('#39'02'#39','#39'12'#39')'
      'and TENANT_ID=:TENANT_ID and USER_ID<>'#39'system'#39' order by ACCOUNT')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_SHOP_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select SHOP_ID,SHOP_NAME,SHOP_SPELL,SEQ_NO from CA_SHOP_INFO whe' +
        're TENANT_ID=:TENANT_ID and COMM not in ('#39'02'#39','#39'12'#39') order by SEQ' +
        '_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_DUTY_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select DUTY_ID,DUTY_SPELL,DUTY_NAME,LEVEL_ID from CA_DUTY_INFO w' +
        'here COMM not in ('#39'02'#39','#39'12'#39')'
      'and TENANT_ID=:TENANT_ID order by LEVEL_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 240
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_ROLE_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select ROLE_ID,ROLE_SPELL,ROLE_NAME,RIGHT_FORDATA from CA_ROLE_I' +
        'NFO where COMM not in ('#39'02'#39','#39'12'#39')'
      'and TENANT_ID=:TENANT_ID order by ROLE_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 240
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_TENANT: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select * from CA_TENANT where TENANT_ID=:TENANT_ID and COMM not ' +
        'in ('#39'02'#39','#39'12'#39')')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 48
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_REGION_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where COD' +
        'E_TYPE='#39'8'#39' and COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <>
    Left = 240
    Top = 152
  end
  object PUB_PAYMENT: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from VIW_PAYMENT where TENAN' +
        'T_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39')'
      'order by CODE_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 240
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_GOODSINFO: TZQuery
    SortedFields = 'GODS_ID'
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select  GODS_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,UNIT_ID,C' +
        'ALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,'
      '       NEW_INPRICE,'
      '       NEW_INPRICE1,'
      '       NEW_INPRICE2,'
      '       NEW_OUTPRICE,'
      '       NEW_OUTPRICE1,'
      '       NEW_OUTPRICE2,'
      '       NEW_LOWPRICE,'
      
        '       SORT_ID2,SORT_ID7,SORT_ID8,USING_BARTER,BARTER_INTEGRAL,U' +
        'SING_BATCH_NO,USING_LOCUS_NO,RELATION_ID'
      
        'from VIW_GOODSPRICEEXT where TENANT_ID=:TENANT_ID and SHOP_ID=:S' +
        'HOP_ID and COMM not in ('#39'02'#39','#39'12'#39') order by GODS_CODE')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SHOP_ID'
        ParamType = ptUnknown
      end>
    IndexFieldNames = 'GODS_ID Asc'
    Left = 136
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SHOP_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_CLIENTINFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CLIENT_ID,LICENSE_CODE,CLIENT_CODE,CLIENT_NAME,CLIENT_SPE' +
        'LL,TELEPHONE2,ADDRESS,IC_CARDNO,SETTLE_CODE,INVOICE_FLAG,TAX_RAT' +
        'E,PRICE_ID,FLAG'
      ' from VIW_CLIENTINFO '
      'where COMM not in ('#39'02'#39','#39'12'#39')  and CLIENT_TYPE='#39'1'#39
      'and TENANT_ID=:TENANT_ID order by CLIENT_CODE')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_CUSTOMER: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CLIENT_ID,LICENSE_CODE,CLIENT_CODE,CLIENT_NAME,LINKMAN,CL' +
        'IENT_SPELL,ADDRESS,TELEPHONE2,IC_CARDNO,SETTLE_CODE,INVOICE_FLAG' +
        ',TAX_RATE,PRICE_ID,FLAG'
      ' from VIW_CUSTOMER'
      'where COMM not in ('#39'02'#39','#39'12'#39')  and CLIENT_TYPE='#39'2'#39
      'and TENANT_ID=:TENANT_ID order by CLIENT_CODE')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_MEAUNITS: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select UNIT_ID,UNIT_NAME,UNIT_SPELL,RELATION_FLAG from VIW_MEAUN' +
        'ITS where COMM not in ('#39'02'#39','#39'12'#39') and TENANT_ID=:TENANT_ID  orde' +
        'r by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 240
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_PARAMS: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,TYPE_CODE from PUB_PARAMS order by  TYP' +
        'E_CODE,CODE_ID')
    Params = <>
    Left = 240
    Top = 360
  end
  object CA_DEPT_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select  DEPT_ID,DEPT_NAME,DEPT_SPELL,LEVEL_ID,DEPT_TYPE,TELEPHON' +
        'E,LINKMAN,FAXES,REMARK,SEQ_NO '
      
        'from CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in ('#39'0' +
        '2'#39','#39'12'#39') order by LEVEL_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 480
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_BRAND_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as SORT_ID,'#39#26080#21697#29260#39' as SORT_NAME,'#39'W'#39' as SORT_SPELL,0 as ' +
        'SEQ_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO from VIW_GOODSSORT '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and SOR' +
        'T_TYPE=4'
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_GOODSSORT: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      'select SORT_ID,SORT_NAME,SORT_SPELL,LEVEL_ID,'
      
        'RELATION_ID,RELATION_NAME from VIW_GOODSSORT where COMM not in (' +
        #39'02'#39','#39'12'#39') and SORT_TYPE=1 and TENANT_ID=:TENANT_ID '
      'order by RELATION_ID DESC,LEVEL_ID,SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_CATE_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as SORT_ID,'#39#26080#31867#21035#39' as SORT_NAME,'#39'W'#39' as SORT_SPELL,0 as ' +
        'SEQ_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO from VIW_GOODSSORT '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and SOR' +
        'T_TYPE=2'
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 384
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_IMPT_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as SORT_ID,'#39#26080#39' as SORT_NAME,'#39'W'#39' as SORT_SPELL,0 as SE' +
        'Q_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO from VIW_GOODSSORT '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and SOR' +
        'T_TYPE=5'
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_COLOR_GROUP: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as SORT_ID,'#39#19981#20998#33394#39' as SORT_NAME,'#39'W'#39' as SORT_SPELL,0 as ' +
        'SEQ_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO from VIW_GOODSSORT '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and SOR' +
        'T_TYPE=7'
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_SIZE_GROUP: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as SORT_ID,'#39#19981#20998#30721#39' as SORT_NAME,'#39'W'#39' as SORT_SPELL,0 as ' +
        'SEQ_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO from VIW_GOODSSORT '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and SOR' +
        'T_TYPE=8'
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_AREA_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as SORT_ID,'#39#26080#39' as SORT_NAME,'#39'W'#39' as SORT_SPELL,0 as SE' +
        'Q_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO from VIW_GOODSSORT '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and SOR' +
        'T_TYPE=6'
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_COLOR_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select COLOR_ID,COLOR_NAME,COLOR_SPELL,SORT_ID7S,SEQ_NO,RELATION' +
        '_FLAG from VIW_COLOR_INFO '
      'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') '
      'order  by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_SIZE_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select SIZE_ID,SIZE_NAME,SIZE_SPELL,SORT_ID8S,SEQ_NO,RELATION_FL' +
        'AG from VIW_SIZE_INFO '
      'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') '
      'order  by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_BARCODE: TZQuery
    SortedFields = 'BARCODE'
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select GODS_ID,BARCODE,PROPERTY_01,PROPERTY_02,BATCH_NO,UNIT_ID,' +
        'BARCODE_TYPE from VIW_BARCODE '
      'where COMM not in ('#39'02'#39','#39'12'#39')'
      'and TENANT_ID=:TENANT_ID order by BARCODE')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    IndexFieldNames = 'BARCODE Asc'
    Left = 240
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_IDNTYPE_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO'
      
        'where COMM not in ('#39'02'#39','#39'12'#39') and TENANT_ID in (0,:TENANT_ID) an' +
        'd CODE_TYPE='#39'11'#39' order by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 240
    Top = 478
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_SALE_STYLE: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where TEN' +
        'ANT_ID=:TENANT_ID and CODE_TYPE='#39'2'#39' and COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_BANK_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where COD' +
        'E_TYPE='#39'7'#39' and TENANT_ID in (0,:TENANT_ID ) and COMM not in ('#39'02' +
        #39','#39'12'#39') order by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_CLIENTSORT: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as CODE_ID,'#39#26080#39' as CODE_NAME,'#39'W'#39' as CODE_SPELL,0 as SE' +
        'Q_NO  from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      
        'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO wh' +
        'ere CODE_TYPE='#39'5'#39' and TENANT_ID=:TENANT_ID and COMM not in ('#39'02'#39 +
        ','#39'12'#39')'
      'order by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_PRICEGRADE: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select * from PUB_PRICEGRADE where TENANT_ID=:TENANT_ID and COMM' +
        ' not in ('#39'02'#39','#39'12'#39')')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object ACC_ACCOUNT_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select * from VIW_ACCOUNT_INFO where TENANT_ID=:TENANT_ID and (P' +
        'AYM_ID<>'#39'A'#39'  or SHOP_ID=:SHOP_ID) and COMM not in ('#39'02'#39','#39'12'#39') or' +
        'der by PAYM_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SHOP_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SHOP_ID'
        ParamType = ptUnknown
      end>
  end
  object ACC_ITEM_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select * from VIW_ITEM_INFO where TENANT_ID=:TENANT_ID and COMM ' +
        'not in ('#39'02'#39','#39'12'#39')')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_MONTH_PAY_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO'
      
        'where COMM not in ('#39'02'#39','#39'12'#39') and TENANT_ID in (0,:TENANT_ID) an' +
        'd CODE_TYPE='#39'13'#39' order by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 664
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_DEGREES_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO'
      
        'where COMM not in ('#39'02'#39','#39'12'#39') and TENANT_ID in (0,:TENANT_ID) an' +
        'd CODE_TYPE='#39'14'#39' order by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 664
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_OCCUPATION_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO'
      
        'where COMM not in ('#39'02'#39','#39'12'#39') and TENANT_ID in (0,:TENANT_ID) an' +
        'd CODE_TYPE='#39'15'#39' order by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 664
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_SHOP_TYPE: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as CODE_ID,'#39#26080#39' as CODE_NAME,'#39'W'#39' as CODE_SPELL,0 as SE' +
        'Q_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and COD' +
        'E_TYPE='#39'12'#39
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 664
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_SETTLE_CODE: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as CODE_ID,'#39#26080#39' as CODE_NAME,'#39'W'#39' as CODE_SPELL,0 as SE' +
        'Q_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and COD' +
        'E_TYPE='#39'6'#39
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 664
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object STO_CHANGECODE: TZQuery
    Tag = 1
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CHANGE_CODE,CHANGE_NAME from STO_CHANGECODE where TENANT_' +
        'ID in (0,:TENANT_ID)  and COMM not in ('#39'02'#39','#39'12'#39') order by CHANG' +
        'E_CODE')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 40
    Top = 480
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_SUPPERSORT: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as CODE_ID,'#39#26080#39' as CODE_NAME,'#39'W'#39' as CODE_SPELL,0 as SE' +
        'Q_NO  from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      
        'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO wh' +
        'ere CODE_TYPE='#39'9'#39' and TENANT_ID=:TENANT_ID and COMM not in ('#39'02'#39 +
        ','#39'12'#39')'
      'order by SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 663
    Top = 471
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_STAT_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      'select CODE_ID,CODE_NAME,SEQ_NO from ('
      
        'select j.CODE_ID,case when b.CODE_NAME is null then j.CODE_NAME ' +
        'else b.CODE_NAME end as CODE_NAME,'
      
        'case when b.SEQ_NO is null then 0 else b.SEQ_NO end as SEQ_NO fr' +
        'om PUB_PARAMS j left outer join '
      
        '(select CODE_ID,CODE_NAME,SEQ_NO from  PUB_CODE_INFO where TENAN' +
        'T_ID=:TENANT_ID and CODE_TYPE='#39'16'#39' ) b on j.CODE_ID=b.CODE_ID '
      'where j.TYPE_CODE='#39'SORT_TYPE'#39')'
      
        'g where not(CODE_NAME like '#39#33258#23450#20041'%'#39') order by SEQ_NO, cast(CODE_ID' +
        ' as int)')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 478
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_GOODS_INDEXS: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO,SORT_TYPE from VIW_GO' +
        'ODSSORT '
      'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') '
      'order  by SORT_TYPE,SEQ_NO')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 664
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_RELATIONS: TZQuery
    Tag = 1
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select A.RELATION_ID as RELATION_ID ,CHANGE_PRICE,SINGLE_LIMIT,S' +
        'ALE_LIMIT,USING_MODULE,RELATION_NAME from CA_RELATIONS A,CA_RELA' +
        'TION B  '
      
        'where A.RELATION_ID=B.RELATION_ID and A.RELATI_ID=:TENANT_ID ord' +
        'er by A.RELATION_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 664
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_TREND_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from PUB_CODE_INFO where TEN' +
        'ANT_ID=:TENANT_ID and CODE_TYPE='#39'17'#39' and COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 504
    Top = 520
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_MODULE: TZQuery
    Tag = 1
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 136
    Top = 576
  end
  object SYS_FEE_OPTION: TZQuery
    Tag = 1
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME from PUB_CODE_INFO where TENANT_ID in (' +
        '0,:TENANT_ID)  and COMM not in ('#39'02'#39','#39'12'#39') order by CODE_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 568
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
end
