inherited ShopGlobal: TShopGlobal
  OldCreateOrder = True
  Left = 506
  Top = 164
  Height = 604
  Width = 658
  object SYS_DEFINE: TZQuery
    SQL.Strings = (
      
        'select * from SYS_DEFINE where TENANT_ID='#39'----'#39' or TENANT_ID=:TE' +
        'NANT_ID and COMM not in ('#39'02'#39','#39'12'#39')')
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
    SQL.Strings = (
      'select '#39'0'#39' as MID,'#39'0'#39' as CHK ')
    Params = <>
    Left = 136
    Top = 160
  end
  object CA_USERS: TZQuery
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
    SQL.Strings = (
      
        'select SHOP_ID,SHOP_NAME,SHOP_SPELL from CA_SHOP_INFO where TENA' +
        'NT_ID=:TENANT_ID order by SEQ_NO')
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
    Left = 136
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_ROLE_INFO: TZQuery
    SQL.Strings = (
      
        'select ROLE_ID,ROLE_SPELL,ROLE_NAME from CA_ROLE_INFO where COMM' +
        ' not in ('#39'02'#39','#39'12'#39')'
      'and TENANT_ID=:TENANT_ID order by LEVEL_ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TENANT_ID'
        ParamType = ptUnknown
      end>
  end
  object CA_TENANT: TZQuery
    SQL.Strings = (
      'select * from CA_TENANT where TENANT_ID=:TENANT_ID')
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
end
