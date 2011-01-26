inherited ShopGlobal: TShopGlobal
  OldCreateOrder = True
  Left = 243
  Top = 92
  Height = 612
  Width = 692
  object SYS_DEFINE: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select * from SYS_DEFINE where TENANT_ID=0 or TENANT_ID=:TENANT_' +
        'ID and COMM not in ('#39'02'#39','#39'12'#39')')
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
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      'select '#39'0'#39' as MID,'#39'0'#39' as CHK ')
    Params = <>
    Left = 136
    Top = 160
  end
  object CA_USERS: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select USER_ID,USER_SPELL,USER_NAME,ACCOUNT,DUTY_IDS,ROLE_IDS,SH' +
        'OP_ID from VIW_USERS where COMM not in ('#39'02'#39','#39'12'#39')'
      'and (TENANT_ID=:TENANT_ID or TENANT_ID=0) order by ACCOUNT')
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
      
        'select SHOP_ID,SHOP_NAME,SHOP_SPELL from CA_SHOP_INFO where TENA' +
        'NT_ID=:TENANT_ID and COMM not in ('#39'02'#39','#39'12'#39') order by SEQ_NO')
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
      
        'select DUTY_ID,DUTY_SPELL,DUTY_NAME from CA_DUTY_INFO where COMM' +
        ' not in ('#39'02'#39','#39'12'#39')'
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
      
        'select ROLE_ID,ROLE_SPELL,ROLE_NAME from CA_ROLE_INFO where COMM' +
        ' not in ('#39'02'#39','#39'12'#39')'
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
      
        'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=8 an' +
        'd COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <>
    Left = 240
    Top = 152
  end
  object PUB_PAYMENT: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CODE_ID,CODE_NAME,CODE_SPELL from VIW_PAYMENT where TENAN' +
        'T_ID=:TENANT_ID and CODE_TYPE='#39'1'#39' and  COMM not in ('#39'02'#39','#39'12'#39')')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 240
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_GOODSINFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select GODS_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,CALC_UNITS' +
        ',SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,'
      '       NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE from VIW_GOODSINFO '
      'where COMM not in ('#39'02'#39','#39'12'#39')'
      'and TENANT_ID=:TENANT_ID order by GODS_CODE')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object PUB_CLIENTINFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select CLIENT_ID,LICENSE_CODE,CLIENT_CODE,CLIENT_NAME,CLIENT_SPE' +
        'LL,ADDRESS,IC_CARDNO'
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
      
        'select CLIENT_ID,LICENSE_CODE,CLIENT_CODE,CLIENT_NAME,CLIENT_SPE' +
        'LL,ADDRESS,IC_CARDNO'
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
      
        'select UNIT_ID,UNIT_NAME,UNIT_SPELL from VIW_MEAUNITS where COMM' +
        ' not in ('#39'02'#39','#39'12'#39') and TENANT_ID=:TENANT_ID  order by SEQ_NO')
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
      
        'select  DEPT_ID,DEPT_NAME,DEPT_SPELL,LEVEL_ID,TELEPHONE,LINKMAN,' +
        'FAXES,REMARK,SEQ_NO '
      'from CA_DEPT_INFO where TENANT_ID=:TENANT_ID order by LEVEL_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 472
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
        'T_TYPE='#39'4'#39
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
      'select SORT_ID,SORT_NAME,SORT_SPELL,LEVEL_ID'
      
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
        'T_TYPE='#39'2'#39
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
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
        'T_TYPE='#39'5'#39
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
  object PUB_COLOR_INFO: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select '#39'#'#39' as SORT_ID,'#39#19981#20998#33394#39' as SORT_NAME,'#39'W'#39' as SORT_SPELL,0 as ' +
        'SEQ_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO from VIW_GOODSSORT '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and SOR' +
        'T_TYPE='#39'7'#39
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 280
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
      
        'select '#39'#'#39' as SORT_ID,'#39#19981#20998#30721#39' as SORT_NAME,'#39'W'#39' as SORT_SPELL,0 as ' +
        'SEQ_NO from CA_TENANT'
      'where TENANT_ID=:TENANT_ID'
      'union all'
      'select SORT_ID,SORT_NAME,SORT_SPELL,SEQ_NO from VIW_GOODSSORT '
      
        'where  TENANT_ID=:TENANT_ID and  COMM not in ('#39'02'#39','#39'12'#39') and SOR' +
        'T_TYPE='#39'8'#39
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 336
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
        'T_TYPE='#39'6'#39
      'order  by  4')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 368
    Top = 392
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
end
