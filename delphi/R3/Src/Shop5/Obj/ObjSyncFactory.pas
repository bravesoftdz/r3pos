unit ObjSyncFactory;

interface
uses Dialogs,SysUtils,zBase,Variants,Classes,DB,ZIntf,ZDataset,ObjCommon,ZDbcCache,ZDbcIntfs,Math;
type
  //0 synFlag
  TSyncSingleTable=class(TZFactory)
  private
    InsertQuery:TZQuery;
    UpdateQuery:TZQuery;
    COMMIdx:integer;
    TIME_STAMPIdx:integer;
    Init:boolean;
    FMaxCol: integer;
    procedure SetMaxCol(const Value: integer);
  protected
    procedure InitSQL(AGlobal: IdbHelp;TimeStamp:boolean=true);virtual;
    function GetRowAccessor: TZRowAccessor;
    procedure FillParams(ZQuery: TZQuery);virtual;
  public
    function CheckUnique(s:string):boolean;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //初始化
    procedure InitClass;override;
    destructor Destroy;override;
    property RowAccessor:TZRowAccessor read GetRowAccessor;
    property MaxCol:integer read FMaxCol write SetMaxCol;
  end;
  //1 synFlag
  TSyncCaRelations=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //2 synFlag
  TSyncCaRelationInfo=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //3 synFlag
  TSyncPubBarcode=class(TSyncSingleTable)
  private
    temp:TZQuery;
  public
    procedure InitSQL(AGlobal: IdbHelp;TimeStamp:boolean=true);override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //初始化
    procedure InitClass;override;
    destructor  Destroy;override;
  end;
  //4 synFlag
  TSyncPubIcInfo=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //5 synFlag
  TSyncStockOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncStockOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncStockData=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //6 synFlag
  TSyncSalesOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSalesOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSalesData=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //7 synFlag
  TSyncChangeOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncChangeOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncChangeData=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //8 synFlag
  TSyncStkIndentOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncStkIndentOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncStkIndentData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //9 synFlag
  TSyncSalIndentOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSalIndentOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSalIndentData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  //10 synFlag
  TSyncAccountInfo=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  //11 synFlag
  TSyncIoroOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncIoroOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncIoroData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //12 synFlag
  TSyncTransOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //13 synFlag
  TSyncRecvOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRecvOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRecvData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //14 synFlag
  TSyncPayOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncPayOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncPayData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //15 synFlag
  TSyncRckDaysCloseList=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRckDaysClose=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRckGodsDaysOrder=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRckCGodsDays=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRckAcctDaysOrder=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //16 synFlag
  TSyncRckMonthCloseList=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRckMonthClose=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRckGodsMonthOrder=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncRckAcctMonthOrder=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //17 synFlag
  TSyncCloseForDayList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncCloseForDay=class(TSyncSingleTable)
  private
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncCloseForDayAble=class(TSyncSingleTable)
  private
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //18 synFlag
  TSyncPriceOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncPriceOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncPriceData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncPromShop=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //19 synFlag
  TSyncCheckOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncCheckOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncCheckData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //20 synFlag
  TSyncCaTenant=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  //21 synFlag
  TSyncGodsRelation=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //22 synFlag
  TSyncGodsInfo=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TSyncLocusForStckData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TSyncLocusForSaleData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TSyncLocusForChagData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //23
  TSyncSequence=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //24
  TSyncMscQuestion=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncMscQuestionItem=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //25
  TSyncCaModule=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //26
  TSyncSysReportList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSysReport=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSysReportTemplate=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //27 IC卡流水信息
  TSyncICGlideInfo=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
implementation

{ TSyncSingleTable }

function TSyncSingleTable.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP'),Params);
end;

procedure TSyncSingleTable.FillParams(ZQuery:TZQuery);
var
  i:integer;
  WasNull:boolean;
  Comm:string;
begin
  if MaxCol=0 then MaxCol := RowAccessor.ColumnCount;
  for i:= 0 to MaxCol-1 do
    begin
      case RowAccessor.GetColumnType(i+1) of
      stBoolean:
        begin
          ZQuery.Params[i].AsBoolean := RowAccessor.GetBoolean(i+1,WasNull);
        end;
      stShort,stByte:
        begin
          ZQuery.Params[i].AsSmallInt := RowAccessor.GetShort(i+1,WasNull);
        end;
      stInteger:
        begin
          ZQuery.Params[i].AsInteger := RowAccessor.GetInt(i+1,WasNull);
        end;
      stLong:
        begin
          ZQuery.Params[i].Value := RowAccessor.GetLong(i+1,WasNull);
        end;
      stFloat,stDouble,stBigDecimal:
        begin
          ZQuery.Params[i].AsFloat := RowAccessor.GetBigDecimal(i+1,WasNull);
        end;
      stString:
        begin
          ZQuery.Params[i].AsString := RowAccessor.GetString(i+1,WasNull);
        end;
      stUnicodeString,stUnicodeStream:
        begin
          ZQuery.Params[i].AsString := RowAccessor.GetUnicodeString(i+1,WasNull);
        end;
      stBytes:
        begin
          ZQuery.Params[i].AsString := RowAccessor.GetString(i+1,WasNull);
        end;
      stDate,stTime,stTimestamp:
        begin
          ZQuery.Params[i].AsDateTime := RowAccessor.GetTimestamp(i+1,WasNull);
        end;
      stAsciiStream,stBinaryStream:
        begin
          ZQuery.Params[i].AsBlob := RowAccessor.GetString(i+1,WasNull);
        end
      else
        Raise Exception.Create('不支持的数据类型');
      end;
      if (i=(COMMIdx-1)) and (Params.FindParam('COMM_LOCK')=nil) then //把通讯标志位改为 1
         begin
           Comm := ZQuery.Params[i].AsString;
           Comm[1] := '1';
           ZQuery.Params[i].AsString := Comm;
         end;
      if (i=(TIME_STAMPIdx-1)) then
         begin
           if ZQuery.Params[i].Value>2808566734 then
              ZQuery.Params[i].Value := 5497000;
           if (Params.FindParam('TIME_STAMP_NOCHG')<>nil) and (Params.ParamByName('TIME_STAMP_NOCHG').AsInteger = 0) and (ZQuery.Params[i].Value < Params.ParamByName('SYN_TIME_STAMP').Value) then
              ZQuery.Params[i].Value := Params.ParamByName('SYN_TIME_STAMP').Value;
         end;
      if WasNull then ZQuery.Params[i].Value := null;
    end;
  if ZQuery.Params.FindParam('LAST_TIME_STAMP')<>nil then
     ZQuery.Params.FindParam('LAST_TIME_STAMP').Value := Params.ParamByName('TIME_STAMP').Value;
end;
function TSyncSingleTable.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger in [0,2]) then
     begin
       FillParams(InsertQuery);
       try
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if Params.ParamByName('KEY_FLAG').AsInteger=2 then Exit;
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       if (Params.ParamByName('KEY_FLAG').AsInteger in [0,1]) then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
       end else r := 0;
       if r=0 then
          begin
            if (Comm='02') or (Comm='12') then Exit;
            FillParams(InsertQuery);
            try
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncSingleTable.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

function TSyncSingleTable.CheckUnique(s: string): boolean;
begin
  result :=
    (pos('unique',lowercase(s))>0)
    or
    (pos('primary',lowercase(s))>0)
    or                                                      
    (pos('sql0803',lowercase(s))>0)
    or
    (pos('主健',s)>0)
    or
    (pos('关健字',s)>0)
    or
    (pos('重复键',s)>0)
    or
    (pos('唯一约束',s)>0);
end;

function TSyncSingleTable.GetRowAccessor: TZRowAccessor;
begin
  if assigned(DataSet) and assigned(TZQuery(DataSet).UpdateObject) then
     result := TZQuery(DataSet).UpdateObject.ZNewRowAccessor
  else
     Raise Exception.Create('没有指定同步对像，不能完成同步操作.');
end;

procedure TSyncSingleTable.InitClass;
begin
  inherited;
  Init := false;
  InsertQuery := nil;
  UpdateQuery := nil;
end;

procedure TSyncSingleTable.InitSQL(AGlobal: IdbHelp;TimeStamp:boolean=true);
var
  i:integer;
  InsertFld,UpdateFld,ValueFld,WhereStr:string;
  KeyFields:TStringList;
begin
  if Init then Exit;
  if MaxCol=0 then MaxCol := RowAccessor.ColumnCount;
  for i:=1 to MaxCol do
    begin
      if InsertFld<>'' then InsertFld := InsertFld + ',';
      InsertFld := InsertFld+RowAccessor.GetColumnName(i);
      if ValueFld<>'' then ValueFld := ValueFld + ',';
      ValueFld := ValueFld+':'+RowAccessor.GetColumnName(i);
      if UpdateFld<>'' then UpdateFld := UpdateFld + ',';
      UpdateFld := UpdateFld+RowAccessor.GetColumnName(i)+'=:'+RowAccessor.GetColumnName(i);
      if RowAccessor.GetColumnName(i)='COMM' then
         COMMIdx := i;
      if RowAccessor.GetColumnName(i)='TIME_STAMP' then
         TIME_STAMPIdx := i;
    end;
  KeyFields:=TStringList.Create;
  try
    KeyFields.Delimiter := ';';
    KeyFields.DelimitedText := Params.ParambyName('KEY_FIELDS').AsString;
    for i:=0 to KeyFields.Count -1 do
      begin
        if WhereStr<>'' then WhereStr := WhereStr + ' and ';
        WhereStr := WhereStr+KeyFields[i]+'=:'+KeyFields[i];
      end;
  finally
    KeyFields.Free;
  end;
  if Assigned(InsertQuery) then freeandnil(InsertQuery);
  InsertQuery := TZQuery.Create(nil);
  InsertQuery.SQL.Text := 'insert into '+Params.ParambyName('TABLE_NAME').AsString+'('+InsertFld+') values('+ValueFld+')';
  if Assigned(UpdateQuery) then freeandnil(UpdateQuery);
  UpdateQuery := TZQuery.Create(nil);
  if TimeStamp and (Params.ParambyName('KEY_FLAG').AsInteger=0) then
     begin
       if WhereStr<>'' then WhereStr :=WhereStr+' and ';
       WhereStr :=WhereStr+'TIME_STAMP<=:LAST_TIME_STAMP';
     end;
  UpdateQuery.SQL.Text := 'update '+Params.ParambyName('TABLE_NAME').AsString+' set '+UpdateFld+' where '+WhereStr;

  Init := true;
end;

procedure TSyncSingleTable.SetMaxCol(const Value: integer);
begin
  FMaxCol := Value;
end;

destructor TSyncSingleTable.Destroy;
begin
  if InsertQuery<>nil then InsertQuery.Free;
  if UpdateQuery<>nil then UpdateQuery.Free;
  inherited;
end;

{ TSyncCaRelations }

function TSyncCaRelations.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where (TENANT_ID=:TENANT_ID or RELATI_ID=:TENANT_ID) and TIME_STAMP>:TIME_STAMP'),Params);
end;

function TSyncCaRelations.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where (TENANT_ID=:TENANT_ID or RELATI_ID=:TENANT_ID) and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncCaRelation }

function TSyncCaRelationInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) '+
   'where TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID) or (TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP)'),Params);
end;

function TSyncCaRelationInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str,ComStr:string;
begin
  if Params.ParamByName('SYN_COMM').AsBoolean then
     ComStr := ParseSQL(AGlobal.iDbType,' and substring(i.COMM,1,1)<>''1''');
  Str :=
  'select i.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' i,'+
  '(select j.TENANT_ID as TENANT_ID,s.TIME_STAMP as TIME_STAMP from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID '+
  ' ) r where i.TENANT_ID=r.TENANT_ID and (i.TIME_STAMP>:TIME_STAMP or r.TIME_STAMP>:TIME_STAMP) '+ComStr +
  ' union all '+
  'select i.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' i where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+ComStr;

//  Str :=
//  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' i '+
//  'where TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID and (s.TIME_STAMP>:TIME_STAMP or i.TIME_STAMP>:TIME_STAMP)) or (TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP)';
//  if Params.ParamByName('SYN_COMM').AsBoolean then
//     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncPubBarcode }

function TSyncPubBarcode.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) '+
    'where TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID) '+
    ' or (TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP) '+
    ''),Params);
end;

function TSyncPubBarcode.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var sv:TZQuery;
begin
  InitSQL(AGlobal,false);
  sv := UpdateQuery;
  try
     if not(FieldbyName('BARCODE_TYPE').AsInteger in [0,1,2]) then
     begin
       UpdateQuery := temp;
     end;
     inherited BeforeInsertRecord(AGlobal);
  finally
     UpdateQuery := sv;
  end;
end;

function TSyncPubBarcode.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+
  ' union all '+
  'select b.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' b,PUB_GOODS_RELATION c,CA_RELATION j,CA_RELATIONS s '+
  'where b.TENANT_ID=j.TENANT_ID and b.GODS_ID=c.GODS_ID and c.RELATION_ID=j.RELATION_ID and c.RELATION_ID=s.RELATION_ID and j.RELATION_ID=s.RELATION_ID and c.TENANT_ID=s.TENANT_ID '+
  ' and s.RELATI_ID=:TENANT_ID and (b.TIME_STAMP>:TIME_STAMP or c.TIME_STAMP>:TIME_STAMP or s.TIME_STAMP>:TIME_STAMP) '+
  '';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := 'select * from ('+Str+') j where '+ParseSQL(AGlobal.iDbType,'substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

destructor TSyncPubBarcode.Destroy;
begin
  if temp<>nil then temp.Free;
  inherited;
end;

procedure TSyncPubBarcode.InitClass;
begin
  inherited;
  temp := TZQuery.Create(nil);
end;

procedure TSyncPubBarcode.InitSQL(AGlobal: IdbHelp; TimeStamp: boolean);
var Inted:boolean;
begin
  Inted := Init;
  inherited;
  if not Inted then Temp.SQL.Text := UpdateQuery.SQL.Text+' and BARCODE=:BARCODE';
end;

{ TSyncPubIcInfo }

function TSyncPubIcInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,PASSWRD,USING_DATE,COMM,TIME_STAMP from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncStockOrder }

function TSyncStockOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID'),self);
end;

function TSyncStockOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAbleInfo;
var rs:TZQuery;
begin
   if (FieldbyName('STOCK_MNY').AsFloat <> 0) and (FieldbyName('STOCK_TYPE').asInteger in [1,3]) and (FieldbyName('ABLE_ID').asString<>'') then
   begin
     if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
//     if roundto(FieldbyName('STOCK_MNY').AsFloat-FieldbyName('ADVA_MNY').AsFloat,-3)<>0 then
     begin
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text :=
         'insert into ACC_PAYABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,ABLE_TYPE,ACCT_MNY,PAYM_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,STOCK_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES(:ABLE_ID,:TENANT_ID,:SHOP_ID,:CLIENT_ID,:ACCT_INFO,:ABLE_TYPE,:STOCK_MNY,0,:ADVA_MNY,:RECK_MNY,:STOCK_DATE,:STOCK_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
       CopyToParams(rs.Params);
       if FieldbyName('STOCK_TYPE').asString='1' then
          begin
            rs.ParambyName('ABLE_TYPE').AsString := '4';
            rs.ParambyName('ACCT_INFO').AsString := '进货货款【单号'+FieldbyName('GLIDE_NO').AsString+'】';
          end
       else
       if FieldbyName('STOCK_TYPE').asString='3' then
          begin
            rs.ParambyName('ABLE_TYPE').AsString := '5';
            rs.ParambyName('ACCT_INFO').AsString := '进货退款【单号'+FieldbyName('GLIDE_NO').AsString+'】';
          end;
       rs.ParambyName('ABLE_ID').AsString := FieldbyName('ABLE_ID').asString;
       rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('STOCK_MNY').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
       AGlobal.ExecQuery(rs);
     finally
       rs.Free;
     end;
     end;
   end;
end;
procedure UpdateAbleInfo;
var rs:TZQuery;
begin
   if (FieldbyName('STOCK_TYPE').asInteger in [1,3]) and (FieldbyName('ABLE_ID').asString<>'') then
   begin
     if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
//     if roundto(FieldbyName('STOCK_MNY').AsFloat-FieldbyName('ADVA_MNY').AsFloat,-3)<>0 then
     begin
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text :=
         'update ACC_PAYABLE_INFO set ACCT_MNY=:STOCK_MNY,REVE_MNY=:ADVA_MNY,RECK_MNY=round(:RECK_MNY-PAYM_MNY,2),SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:STOCK_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '
       + 'where TENANT_ID=:TENANT_ID and ABLE_ID=:ABLE_ID and ABLE_TYPE=:ABLE_TYPE';
       CopyToParams(rs.Params);
       rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('STOCK_MNY').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
       if FieldbyName('STOCK_TYPE').asString='1' then
          begin
            rs.ParambyName('ABLE_TYPE').AsString := '4';
          end
       else
       if FieldbyName('STOCK_TYPE').asString='3' then
          begin
            rs.ParambyName('ABLE_TYPE').AsString := '5';
          end;
       AGlobal.ExecQuery(rs);
     finally
       rs.Free;
     end;
     end;
   end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_STOCKORDER';
       MaxCol := RowAccessor.ColumnCount - 1;
       InitSQL(AGlobal,false);
     end;
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                   UpdateAbleInfo;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r<>0 then UpdateAbleInfo;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncStockOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
    'select j.*,a.ABLE_ID from ('+
    'select * from STK_STOCKORDER where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID ) j left outer join ACC_PAYABLE_INFO a on j.TENANT_ID=a.TENANT_ID and j.STOCK_ID=a.STOCK_ID';
  SelectSQL.Text := Str;
end;

{ TSyncStockData }

function TSyncStockData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertStorageInfo;
begin
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             FieldbyName('CALC_MONEY').asFloat-roundto(FieldbyName('CALC_MONEY').asFloat/(1+FieldbyName('TAX_RATE').AsFloat)*FieldbyName('TAX_RATE').AsFloat,-2),1);
end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_STOCKDATA';
       MaxCol := RowAccessor.ColumnCount-1;
       InitSQL(AGlobal);
     end;
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertStorageInfo;
end;

function TSyncStockData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.*,b.TAX_RATE as TAX_RATE from STK_STOCKDATA a,STK_STOCKORDER b where a.TENANT_ID=b.TENANT_ID and a.STOCK_ID=b.STOCK_ID and a.TENANT_ID=:TENANT_ID and a.STOCK_ID=:STOCK_ID';
  SelectSQL.Text := Str;
end;

function TSyncStockData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,a.SHOP_ID,a.GODS_ID,a.PROPERTY_01,a.PROPERTY_02,a.BATCH_NO,a.CALC_AMOUNT,a.CALC_MONEY,b.TAX_RATE as TAX_RATE '+
       'from STK_STOCKDATA a,STK_STOCKORDER b where a.TENANT_ID=b.TENANT_ID and a.STOCK_ID=b.STOCK_ID and a.TENANT_ID=:TENANT_ID and a.STOCK_ID=:STOCK_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        DecStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                   rs.FieldbyName('GODS_ID').asString,
                   rs.FieldbyName('PROPERTY_01').asString,
                   rs.FieldbyName('PROPERTY_02').asString,
                   rs.FieldbyName('BATCH_NO').asString,
                   rs.FieldbyName('CALC_AMOUNT').asFloat,
                   rs.FieldbyName('CALC_MONEY').asFloat-roundto(rs.FieldbyName('CALC_MONEY').asFloat/(1+rs.FieldbyName('TAX_RATE').asFloat)*rs.FieldbyName('TAX_RATE').asFloat,-2),3);
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from STK_STOCKDATA where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID',Params);
  finally
    rs.Free;
  end;
end;

{ TSyncSalesOrder }

function TSyncSalesOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID'),self);
end;

function TSyncSalesOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAbleInfo;
var rs:TZQuery;
begin
   if (FieldbyName('PAY_D').AsFloat <> 0) and (FieldbyName('SALES_TYPE').AsInteger in [1,3,4]) and (FieldbyName('ABLE_ID').asString<>'') then
   begin
     if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
//     if roundto(FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat,-3)<>0 then
     begin
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text :=
         'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES(:ABLE_ID,:TENANT_ID,:SHOP_ID,:CLIENT_ID,:ACCT_INFO,:RECV_TYPE,:PAY_D,0,:ADVA_MNY,:RECK_MNY,:SALES_DATE,:SALES_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
       CopyToParams(rs.Params);
       case FieldbyName('SALES_TYPE').AsInteger of
       1,4: begin
            rs.ParambyName('RECV_TYPE').AsString := '1';
            rs.ParambyName('ACCT_INFO').AsString := '销售货款【单号'+FieldbyName('GLIDE_NO').AsString+'】';
          end;
       3:   begin
            rs.ParambyName('RECV_TYPE').AsString := '2';
            rs.ParambyName('ACCT_INFO').AsString := '销售退款【单号'+FieldbyName('GLIDE_NO').AsString+'】';
          end;
       end;
       rs.ParambyName('ABLE_ID').AsString := FieldbyName('ABLE_ID').asString;
       rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
       AGlobal.ExecQuery(rs);
     finally
       rs.Free;
     end;
     end;
   end;
end;
procedure InsertIntegralInfo;
var rs:TZQuery;
begin
  //更新积分
  if length(FieldbyName('CLIENT_ID').AsString)>0 then
  begin
     if (FieldbyName('BARTER_INTEGRAL').AsInteger<>0) or (FieldbyName('INTEGRAL').AsInteger<>0) then //扣减换购积分
     begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text :=
        ParseSQL(idbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) + :RULE_INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) + :ACCU_INTEGRAL  '+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID');
        rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
        rs.ParamByName('CLIENT_ID').AsString := FieldbyName('CLIENT_ID').AsString;
        rs.ParamByName('INTEGRAL').AsInteger := FieldbyName('BARTER_INTEGRAL').AsInteger-FieldbyName('INTEGRAL').AsInteger;
        rs.ParamByName('ACCU_INTEGRAL').AsInteger := FieldbyName('INTEGRAL').AsInteger;
        rs.ParamByName('RULE_INTEGRAL').AsInteger := FieldbyName('BARTER_INTEGRAL').AsInteger;
        AGlobal.ExecQuery(rs);
      finally
        rs.Free;
      end;
     end;
  end;
end;
procedure UpdateAbleInfo;
var rs:TZQuery;
begin
   if (FieldbyName('PAY_D').AsFloat <> 0) and (FieldbyName('SALES_TYPE').AsInteger in [1,3,4]) and (FieldbyName('ABLE_ID').asString<>'') then
   begin
     if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
//     if roundto(FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat,-3)<>0 then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text :=
           'update ACC_RECVABLE_INFO set ACCT_MNY=:PAY_D,REVE_MNY=:ADVA_MNY,RECK_MNY=round(:RECK_MNY-RECV_MNY,2),SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:SALES_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '
         + 'where TENANT_ID=:TENANT_ID and ABLE_ID=:ABLE_ID and RECV_TYPE=:RECV_TYPE';
         CopyToParams(rs.Params);
         rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
         case FieldbyName('SALES_TYPE').AsInteger of
         1,4: begin
              rs.ParambyName('RECV_TYPE').AsString := '1';
            end;
         3:   begin
              rs.ParambyName('RECV_TYPE').AsString := '2';
            end;
         end;
         AGlobal.ExecQuery(rs);
       finally
         rs.Free;
       end;
     end;
   end;
end;
function UpdateIntegralInfo:boolean;
var
  rs:TZQuery;
  Params:TftParamList;
begin
  rs := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    rs.SQL.Text := 'select INTEGRAL,BARTER_INTEGRAL,CLIENT_ID,SALES_TYPE from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('SALES_ID').AsString := FieldbyName('SALES_ID').AsString;
    AGlobal.Open(rs);
    result := not rs.IsEmpty;
    if result and (rs.FieldByName('SALES_TYPE').AsInteger in [1,3,4]) then
    begin
      if (rs.Fields[0].AsInteger <> 0) or (rs.Fields[1].AsInteger <> 0) then
         begin
           Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
           Params.ParamByName('CLIENT_ID').AsString := rs.FieldbyName('CLIENT_ID').AsString;
           Params.ParamByName('INTEGRAL').AsInteger := rs.FieldbyName('INTEGRAL').AsInteger-rs.FieldbyName('BARTER_INTEGRAL').AsInteger;
           Params.ParamByName('ACCU_INTEGRAL').AsInteger := rs.FieldbyName('INTEGRAL').AsInteger;
           Params.ParamByName('RULE_INTEGRAL').AsInteger := rs.FieldbyName('BARTER_INTEGRAL').AsInteger;
           AGlobal.ExecSQL(
             ParseSQL(AGlobal.iDbType,
             'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) - :RULE_INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) - :ACCU_INTEGRAL  '+
             'where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID'),Params);
         end;
      //更新积分
      InsertIntegralInfo;
    end;
  finally
    Params.Free;
    rs.Free;
  end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_SALESORDER';
       MaxCol := RowAccessor.ColumnCount - 1;
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
         InsertIntegralInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if UpdateIntegralInfo then
                      begin
                        UpdateAbleInfo;
                        FillParams(UpdateQuery);
                        AGlobal.ExecQuery(UpdateQuery);
                      end
                   else
                      Raise;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       if UpdateIntegralInfo then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
         if r<>0 then UpdateAbleInfo;
       end
       else
         r := 0;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
              InsertIntegralInfo;
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncSalesOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
     'select j.*,a.ABLE_ID from ( '+
     'select * from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) j left outer join ACC_RECVABLE_INFO a on j.TENANT_ID=a.TENANT_ID and j.SALES_ID=a.SALES_ID';
  SelectSQL.Text := Str;
end;

{ TSyncSalesData }

function TSyncSalesData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertStorageInfo;
begin
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('COST_PRICE').asFloat*FieldbyName('CALC_AMOUNT').asFloat,-2),2);

end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_SALESDATA';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertStorageInfo;
end;

function TSyncSalesData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SAL_SALESDATA where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
  SelectSQL.Text := Str;
end;

function TSyncSalesData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,a.SHOP_ID,a.GODS_ID,a.PROPERTY_01,a.PROPERTY_02,a.BATCH_NO,a.CALC_AMOUNT,a.COST_PRICE '+
       'from SAL_SALESDATA a where a.TENANT_ID=:TENANT_ID and a.SALES_ID=:SALES_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        IncStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                   rs.FieldbyName('GODS_ID').asString,
                   rs.FieldbyName('PROPERTY_01').asString,
                   rs.FieldbyName('PROPERTY_02').asString,
                   rs.FieldbyName('BATCH_NO').asString,
                   rs.FieldbyName('CALC_AMOUNT').asFloat,
                   roundto(rs.FieldbyName('COST_PRICE').asFloat*rs.FieldbyName('CALC_AMOUNT').asFloat,-2),3);
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from SAL_SALESDATA where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID',Params);
  finally
    rs.Free;
  end;
end;

{ TSyncChangeOrder }

function TSyncChangeOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID'),self);
end;

function TSyncChangeOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_CHANGEORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncChangeOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID';
  SelectSQL.Text := Str;
end;

{ TSyncChangeData }

function TSyncChangeData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertStorageInfo;
begin
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  if FieldbyName('CHANGE_TYPE').AsString = '1' then
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,-2),1)
  else
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,-2),1);
end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_CHANGEDATA';
       MaxCol := RowAccessor.ColumnCount-1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertStorageInfo;
end;

function TSyncChangeData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.*,b.CHANGE_TYPE as CHANGE_TYPE from STO_CHANGEDATA a,STO_CHANGEORDER b where a.TENANT_ID=b.TENANT_ID and a.CHANGE_ID=b.CHANGE_ID and a.TENANT_ID=:TENANT_ID and a.CHANGE_ID=:CHANGE_ID';
  SelectSQL.Text := Str;
end;

function TSyncChangeData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,a.SHOP_ID,a.GODS_ID,a.PROPERTY_01,a.PROPERTY_02,a.BATCH_NO,a.CALC_AMOUNT,a.COST_PRICE,b.CHANGE_TYPE as CHANGE_TYPE from STO_CHANGEDATA a,STO_CHANGEORDER b where a.TENANT_ID=b.TENANT_ID and a.CHANGE_ID=b.CHANGE_ID '+
       'and a.TENANT_ID=:TENANT_ID and a.CHANGE_ID=:CHANGE_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if FieldbyName('CHANGE_TYPE').AsString = '1' then
        DecStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                   rs.FieldbyName('GODS_ID').asString,
                   rs.FieldbyName('PROPERTY_01').asString,
                   rs.FieldbyName('PROPERTY_02').asString,
                   rs.FieldbyName('BATCH_NO').asString,
                   rs.FieldbyName('CALC_AMOUNT').asFloat,
                   roundto(rs.FieldbyName('CALC_AMOUNT').asFloat*rs.FieldbyName('COST_PRICE').asFloat,-2),3)
        else
        IncStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                   rs.FieldbyName('GODS_ID').asString,
                   rs.FieldbyName('PROPERTY_01').asString,
                   rs.FieldbyName('PROPERTY_02').asString,
                   rs.FieldbyName('BATCH_NO').asString,
                   rs.FieldbyName('CALC_AMOUNT').asFloat,
                   roundto(rs.FieldbyName('CALC_AMOUNT').asFloat*rs.FieldbyName('COST_PRICE').asFloat,-2),3);
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from STO_CHANGEDATA where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID',Params);
  finally
    rs.Free;
  end;
end;

{ TSyncStkIndentOrder }

function TSyncStkIndentOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID'),self);
end;

function TSyncStkIndentOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAbleInfo;
begin
   if (FieldbyName('ADVA_MNY').AsFloat <> 0) then
   begin
     AGlobal.ExecSQL(
         'insert into ACC_PAYABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,ABLE_TYPE,ACCT_MNY,PAYM_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,STOCK_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES('''+newid(FieldbyName('SHOP_ID').AsString)+''',:TENANT_ID,:SHOP_ID,:CLIENT_ID,'''+'预付款【订单号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''6'',:ADVA_MNY,0,0,:ADVA_MNY,:INDE_DATE,:INDE_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
    ,self);
   end;
end;
procedure UpdateAbleInfo;
var
   rs:TZQuery;
begin
   rs := TZQuery.Create(nil);
   try
     rs.SQL.Text :=
       'update ACC_PAYABLE_INFO set ACCT_MNY=:ADVA_MNY,RECK_MNY=round(:ADVA_MNY-PAYM_MNY,2),SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:INDE_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '
     + 'where TENANT_ID=:TENANT_ID and STOCK_ID=:INDE_ID and ABLE_TYPE=''6''';
     CopyToParams(rs.Params);
     AGlobal.ExecQuery(rs);
   finally
     rs.Free;
   end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_INDENTORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                   UpdateAbleInfo;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r <>0 then UpdateAbleInfo;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncStkIndentOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from STK_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID';
  SelectSQL.Text := Str;
end;

{ TSyncStkIndentData }

function TSyncStkIndentData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_INDENTDATA';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncStkIndentData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.* from STK_INDENTDATA a where a.TENANT_ID=:TENANT_ID and a.INDE_ID=:INDE_ID';
  SelectSQL.Text := Str;
end;

function TSyncStkIndentData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from STK_INDENTDATA where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID',Params);
end;

{ TSyncStockOrderList }

function TSyncStockOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,STOCK_ID from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncSalesOrderList }

function TSyncSalesOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,SALES_ID from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and (SHOP_ID=:SHOP_ID or CLIENT_ID=:SHOP_ID) and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncChangeOrderList }

function TSyncChangeOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,CHANGE_ID from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  if Params.ParamByName('END_TIME_STAMP').AsInteger>0 then
     Str := Str +' and TIME_STAMP<=:END_TIME_STAMP';
  SelectSQL.Text := Str;
end;

{ TSyncStkIndentOrderList }

function TSyncStkIndentOrderList.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,INDE_ID from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncSalIndentOrderList }

function TSyncSalIndentOrderList.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,INDE_ID from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncSalIndentOrder }

function TSyncSalIndentOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID'),self);
end;

function TSyncSalIndentOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAbleInfo;
begin
   if (FieldbyName('ADVA_MNY').AsFloat <> 0) then
   begin
     AGlobal.ExecSQL(
         'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES('''+newid(FieldbyName('SHOP_ID').AsString)+''',:TENANT_ID,:SHOP_ID,:CLIENT_ID,'''+'预收款【订单号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''3'',:ADVA_MNY,0,0,:ADVA_MNY,:INDE_DATE,:INDE_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
    ,self);
   end;
end;
procedure UpdateAbleInfo;
var
   rs:TZQuery;
begin
   rs := TZQuery.Create(nil);
   try
     rs.SQL.Text :=
       'update ACC_RECVABLE_INFO set ACCT_MNY=:ADVA_MNY,RECK_MNY=round(:ADVA_MNY-RECV_MNY,2),SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:INDE_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '
     + 'where TENANT_ID=:TENANT_ID and SALES_ID=:INDE_ID and RECV_TYPE=''3''';
     CopyToParams(rs.Params);
     AGlobal.ExecQuery(rs);
   finally
     rs.Free;
   end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_INDENTORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                   UpdateAbleInfo;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r <>0 then UpdateAbleInfo;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncSalIndentOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID';
  SelectSQL.Text := Str;
end;

{ TSyncSalIndentData }

function TSyncSalIndentData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_INDENTDATA';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncSalIndentData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.* from SAL_INDENTDATA a where a.TENANT_ID=:TENANT_ID and a.INDE_ID=:INDE_ID';
  SelectSQL.Text := Str;
end;

function TSyncSalIndentData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from SAL_INDENTDATA where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID',Params);
end;

{ TSyncAccountInfo }

function TSyncAccountInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,COMM,TIME_STAMP from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncIoroOrderList }

function TSyncIoroOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,IORO_ID from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncIoroOrder }

function TSyncIoroOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and IORO_ID=:IORO_ID'),self);
end;

function TSyncIoroOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_IOROORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncIoroOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from ACC_IOROORDER where TENANT_ID=:TENANT_ID and IORO_ID=:IORO_ID';
  SelectSQL.Text := Str;
end;

{ TSyncIoroData }

function TSyncIoroData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAccountInfo;
begin
  case FieldbyName('IORO_TYPE').AsInteger of
  1:
  AGlobal.ExecSQL(
        ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set IN_MNY=round(isnull(IN_MNY,0)+:IORO_MNY,2),BALANCE=round(isnull(BALANCE,0)+:IORO_MNY,2),'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),self);
  2:
  AGlobal.ExecSQL(
        ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set OUT_MNY=round(isnull(OUT_MNY,0)+:IORO_MNY,2),BALANCE=round(isnull(BALANCE,0)- :IORO_MNY,2),'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),self);
  end;
end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_IORODATA';
       MaxCol := RowAccessor.ColumnCount - 1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertAccountInfo;
end;

function TSyncIoroData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
       'select a.*,b.IORO_TYPE '+
       'from ACC_IORODATA a,ACC_IOROORDER b where a.TENANT_ID=b.TENANT_ID and a.IORO_ID=b.IORO_ID and a.TENANT_ID=:TENANT_ID and a.IORO_ID=:IORO_ID';
  SelectSQL.Text := Str;
end;

function TSyncIoroData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  ftParams:TftParamList;
begin
  rs := TZQuery.Create(nil);
  ftParams := TftParamList.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,a.ACCOUNT_ID,a.IORO_MNY,b.IORO_TYPE '+
       'from ACC_IORODATA a,ACC_IOROORDER b where a.TENANT_ID=b.TENANT_ID and a.IORO_ID=b.IORO_ID and a.TENANT_ID=:TENANT_ID and a.IORO_ID=:IORO_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        ftParams.ParamByName('TENANT_ID').AsInteger := rs.FieldbyName('TENANT_ID').AsInteger;
        ftParams.ParamByName('ACCOUNT_ID').AsString := rs.FieldbyName('ACCOUNT_ID').AsString;
        ftParams.ParamByName('IORO_MNY').AsFloat    := rs.FieldbyName('IORO_MNY').AsFloat;
        case rs.FieldbyName('IORO_TYPE').AsInteger of
        1:
        AGlobal.ExecSQL(
              ParseSQL(AGlobal.iDbType,
              'update ACC_ACCOUNT_INFO set IN_MNY=round(isnull(IN_MNY,0)- :IORO_MNY,2),BALANCE=round(isnull(BALANCE,0)- :IORO_MNY,2),'
            + 'COMM=' + GetCommStr(iDbType) + ','
            + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
            + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),ftParams);
        2:
        AGlobal.ExecSQL(
              ParseSQL(AGlobal.iDbType,
              'update ACC_ACCOUNT_INFO set OUT_MNY=round(isnull(OUT_MNY,0)- :IORO_MNY,2),BALANCE=round(isnull(BALANCE,0)+:IORO_MNY,2),'
            + 'COMM=' + GetCommStr(iDbType) + ','
            + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
            + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),ftParams);
        end;
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from ACC_IORODATA where TENANT_ID=:TENANT_ID and IORO_ID=:IORO_ID',Params);
  finally
    ftParams.Free;
    rs.Free;
  end;
end;

{ TSyncTransOrder}

function TSyncTransOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP'),self);
end;

function TSyncTransOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAccountInfo;
var Str:string;
begin
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=round(:TRANS_MNY+ifnull(IN_MNY,0),2),BALANCE=round(:TRANS_MNY+ifnull(BALANCE,0),2),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:IN_ACCOUNT_ID  ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  Str := 'update ACC_ACCOUNT_INFO set OUT_MNY=round(:TRANS_MNY+ifnull(OUT_MNY,0),2),BALANCE=round(ifnull(BALANCE,0)- :TRANS_MNY,2),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:OUT_ACCOUNT_ID ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

end;
function UpdateAccountInfo:boolean;
var Str:string;
begin
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=round(:TRANS_MNY+ifnull(IN_MNY,0),2),BALANCE=round(:TRANS_MNY+ifnull(BALANCE,0),2),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:IN_ACCOUNT_ID  ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  Str := 'update ACC_ACCOUNT_INFO set OUT_MNY=round(:TRANS_MNY+ifnull(OUT_MNY,0),2),BALANCE=round(ifnull(BALANCE,0)- :TRANS_MNY,2),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:OUT_ACCOUNT_ID ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_TRANSORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAccountInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if UpdateAccountInfo then
                   begin
                     FillParams(UpdateQuery);
                     AGlobal.ExecQuery(UpdateQuery);
                   end
                   else
                     Raise;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       if UpdateAccountInfo then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
       end
       else
         r := 0;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAccountInfo;
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncTransOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncRecvOrderList }

function TSyncRecvOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,RECV_ID from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncRecvOrder }

function TSyncRecvOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and RECV_ID=:RECV_ID'),self);
end;

function TSyncRecvOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_RECVORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncRecvOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from ACC_RECVORDER where TENANT_ID=:TENANT_ID and RECV_ID=:RECV_ID';
  SelectSQL.Text := Str;
end;

{ TSyncRecvData }

function TSyncRecvData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAccountInfo;
begin
  if VarIsNull(FieldbyName('RECV_MNY').NewValue) then FieldbyName('RECV_MNY').AsFloat := 0;

  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType ,
     'update ACC_RECVABLE_INFO set NEAR_DATE='''+formatDatetime('YYYY-MM-DD',now())+''',RECV_MNY=round(isnull(RECV_MNY,0)+:RECV_MNY,2),'+
     'RECK_MNY=round(isnull(RECK_MNY,0)- :RECV_MNY,2),COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where ABLE_ID=:ABLE_ID and TENANT_ID=:TENANT_ID')
     ,self);

  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set IN_MNY=round(isnull(IN_MNY,0)+:RECV_MNY,2),BALANCE=round(isnull(BALANCE,0)+:RECV_MNY,2),'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where ACCOUNT_ID=:ACCOUNT_ID and TENANT_ID=:TENANT_ID'),self);
end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_RECVDATA';
       MaxCol := RowAccessor.ColumnCount - 1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertAccountInfo;
end;

function TSyncRecvData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.*,b.ACCOUNT_ID from ACC_RECVDATA a,ACC_RECVORDER b where a.TENANT_ID=b.TENANT_ID and a.RECV_ID=b.RECV_ID and a.TENANT_ID=:TENANT_ID and a.RECV_ID=:RECV_ID';
  SelectSQL.Text := Str;
end;

function TSyncRecvData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  ftParams:TftParamList;
begin
  rs := TZQuery.Create(nil);
  ftParams := TftParamList.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,b.ACCOUNT_ID,a.ABLE_ID,a.RECV_MNY '+
       'from ACC_RECVDATA a,ACC_RECVORDER b where a.TENANT_ID=b.TENANT_ID and a.RECV_ID=b.RECV_ID and a.TENANT_ID=:TENANT_ID and a.RECV_ID=:RECV_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        ftParams.ParamByName('TENANT_ID').AsInteger := rs.FieldbyName('TENANT_ID').AsInteger; 
        ftParams.ParamByName('ACCOUNT_ID').AsString := rs.FieldbyName('ACCOUNT_ID').AsString;
        ftParams.ParamByName('ABLE_ID').AsString := rs.FieldbyName('ABLE_ID').AsString;
        ftParams.ParamByName('RECV_MNY').AsFloat := rs.FieldbyName('RECV_MNY').AsFloat;
        
        AGlobal.ExecSQL(
          ParseSQL(AGlobal.iDbType,'update ACC_RECVABLE_INFO set RECV_MNY=round(isnull(RECV_MNY,0)- :RECV_MNY,2),RECK_MNY=round(isnull(RECK_MNY,0)+:RECV_MNY,2) ,COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where TENANT_ID=:TENANT_ID and ABLE_ID=:ABLE_ID')
          ,self);

        AGlobal.ExecSQL(
            ParseSQL(AGlobal.iDbType,
            'update ACC_ACCOUNT_INFO set IN_MNY=round(isnull(IN_MNY,0)- :RECV_MNY,2),BALANCE=round(isnull(BALANCE,0)- :RECV_MNY,2),'
            + 'COMM=' + GetCommStr(iDbType) + ','
            + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
            + 'where ACCOUNT_ID=:ACCOUNT_ID and TENANT_ID=:TENANT_ID')
            ,self);

        rs.Next;
      end;
    AGlobal.ExecSQL('delete from ACC_RECVDATA where TENANT_ID=:TENANT_ID and RECV_ID=:RECV_ID',Params);
  finally
    ftParams.Free;
    rs.Free;
  end;
end;

{ TSyncPayOrderList }

function TSyncPayOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,PAY_ID from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncPayOrder }

function TSyncPayOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and PAY_ID=:PAY_ID'),self);
end;

function TSyncPayOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_PAYORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncPayOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from ACC_PAYORDER where TENANT_ID=:TENANT_ID and PAY_ID=:PAY_ID';
  SelectSQL.Text := Str;
end;

{ TSyncPayData }

function TSyncPayData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAccountInfo;
begin
  if VarIsNull(FieldbyName('PAY_MNY').NewValue) then FieldbyName('PAY_MNY').AsFloat := 0;
  
  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
     'update ACC_PAYABLE_INFO set NEAR_DATE='''+formatDatetime('YYYY-MM-DD',now())+''',PAYM_MNY=round(isnull(PAYM_MNY,0)+:PAY_MNY,2),'+
        'RECK_MNY=round(isnull(RECK_MNY,0)- :PAY_MNY,2) ,COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where ABLE_ID=:ABLE_ID and TENANT_ID=:TENANT_ID'),self);


  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
     'update ACC_ACCOUNT_INFO set OUT_MNY=round(isnull(OUT_MNY,0)+:PAY_MNY,2),BALANCE=round(isnull(BALANCE,0)- :PAY_MNY,2),'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where ACCOUNT_ID=:ACCOUNT_ID and TENANT_ID=:TENANT_ID'),self);

end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_PAYDATA';
       MaxCol := RowAccessor.ColumnCount - 1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertAccountInfo;
end;

function TSyncPayData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.*,b.ACCOUNT_ID from ACC_PAYDATA a,ACC_PAYORDER b where a.TENANT_ID=b.TENANT_ID and a.PAY_ID=b.PAY_ID and a.TENANT_ID=:TENANT_ID and a.PAY_ID=:PAY_ID';
  SelectSQL.Text := Str;
end;

function TSyncPayData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  ftParams:TftParamList;
begin
  rs := TZQuery.Create(nil);
  ftParams := TftParamList.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,b.ACCOUNT_ID,a.ABLE_ID,a.PAY_MNY '+
       'from ACC_PAYDATA a,ACC_PAYORDER b where a.TENANT_ID=b.TENANT_ID and a.PAY_ID=b.PAY_ID and a.TENANT_ID=:TENANT_ID and a.PAY_ID=:PAY_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        ftParams.ParamByName('TENANT_ID').AsInteger := rs.FieldbyName('TENANT_ID').AsInteger; 
        ftParams.ParamByName('ACCOUNT_ID').AsString := rs.FieldbyName('ACCOUNT_ID').AsString;
        ftParams.ParamByName('ABLE_ID').AsString := rs.FieldbyName('ABLE_ID').AsString;
        ftParams.ParamByName('PAY_MNY').AsFloat := rs.FieldbyName('PAY_MNY').AsFloat;
        
        AGlobal.ExecSQL(
           ParseSQL(AGlobal.iDbType,
           'update ACC_PAYABLE_INFO set PAYM_MNY=round(isnull(PAYM_MNY,0)- :PAY_MNY,2),RECK_MNY=round(isnull(RECK_MNY,0)+:PAY_MNY,2),COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where TENANT_ID=:TENANT_ID and ABLE_ID=:ABLE_ID')
           ,ftParams);

        AGlobal.ExecSQL(
           ParseSQL(AGlobal.iDbType,
              'update ACC_ACCOUNT_INFO set OUT_MNY=round(isnull(OUT_MNY,0)- :PAY_MNY,2),BALANCE=round(isnull(BALANCE,0)+ :PAY_MNY,2),'
            + 'COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
              'where ACCOUNT_ID=:ACCOUNT_ID and TENANT_ID=:TENANT_ID ')
           ,ftParams);
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from ACC_PAYDATA where TENANT_ID=:TENANT_ID and PAY_ID=:PAY_ID',Params);
  finally
    ftParams.Free;
    rs.Free;
  end;
end;

{ TSyncRckDaysCloseList }

function TSyncRckDaysCloseList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,CREA_DATE from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncRckGodsDaysOrder }

function TSyncRckGodsDaysOrder.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'RCK_GOODS_DAYS';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncRckGodsDaysOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from RCK_GOODS_DAYS where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE';
  SelectSQL.Text := Str;
end;

function TSyncRckGodsDaysOrder.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'delete from RCK_GOODS_DAYS where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE';
  AGlobal.ExecSQL(Str,Params);
end;

{ TSyncRckAcctDaysOrder }

function TSyncRckAcctDaysOrder.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'RCK_ACCT_DAYS';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncRckAcctDaysOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from RCK_ACCT_DAYS where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE';
  SelectSQL.Text := Str;
end;

function TSyncRckAcctDaysOrder.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'delete from RCK_ACCT_DAYS where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE';
  AGlobal.ExecSQL(Str,Params); 
end;

{ TSyncRckDaysClose }

function TSyncRckDaysClose.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE'),self);
end;

function TSyncRckDaysClose.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'RCK_DAYS_CLOSE';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncRckDaysClose.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE';
  SelectSQL.Text := Str;
end;

{ TSyncRckMonthClose }

function TSyncRckMonthClose.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MONTH=:MONTH'),self);
end;

function TSyncRckMonthClose.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'RCK_MONTH_CLOSE';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncRckMonthClose.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MONTH=:MONTH';
  SelectSQL.Text := Str;
end;

{ TSyncRckGodsMonthOrder }

function TSyncRckGodsMonthOrder.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'RCK_GOODS_MONTH';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncRckGodsMonthOrder.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from RCK_GOODS_MONTH where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MONTH=:MONTH';
  SelectSQL.Text := Str;
end;

function TSyncRckGodsMonthOrder.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'delete from RCK_GOODS_MONTH where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MONTH=:MONTH';
  AGlobal.ExecSQL(Str,Params); 
end;

{ TSyncRckAcctMonthOrder }

function TSyncRckAcctMonthOrder.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'RCK_ACCT_MONTH';
       InitSQL(AGlobal);
     end;
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncRckAcctMonthOrder.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from RCK_ACCT_MONTH where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MONTH=:MONTH';
  SelectSQL.Text := Str;
end;

function TSyncRckAcctMonthOrder.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'delete from RCK_ACCT_MONTH where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MONTH=:MONTH';
  AGlobal.ExecSQL(Str,Params); 
end;

{ TSyncRckMonthCloseList }

function TSyncRckMonthCloseList.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select  TENANT_ID,SHOP_ID,MONTH from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncCloseForDay }

function TSyncCloseForDay.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLSE_DATE=:CLSE_DATE and CREA_USER=:CREA_USER'),Params);
end;

function TSyncCloseForDay.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_CLOSE_FORDAY';
     end;
  InitSQL(AGlobal,false);
  FillParams(UpdateQuery);
  r := AGlobal.ExecQuery(UpdateQuery);
  if r=0 then
    begin
      try
        FillParams(InsertQuery);
        AGlobal.ExecQuery(InsertQuery);
      except
         on E:Exception do
            begin
              if not CheckUnique(E.Message) then
                 Raise;
            end;
      end;
    end;
  Result := True;
end;

function TSyncCloseForDay.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLSE_DATE=:CLSE_DATE and CREA_USER=:CREA_USER';
  SelectSQL.Text := Str;
end;

{ TSyncPriceOrderList }

function TSyncPriceOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select TENANT_ID,SHOP_ID,PROM_ID from SAL_PRICEORDER j where TENANT_ID=:TENANT_ID and '+
         '(SHOP_ID=:SHOP_ID or SHOP_ID in (select SHOP_ID from SAL_PROM_SHOP where TENANT_ID=j.TENANT_ID and PROM_ID=j.PROM_ID and SHOP_ID=:SHOP_ID)) '+
         'and CHK_DATE is not null and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(j.COMM,1,1)<>''1''');
  SelectSQL.Text := Str;
end;

{ TSyncPriceOrder }

function TSyncPriceOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID'),self);
end;

function TSyncPriceOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_PRICEORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncPriceOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SAL_PRICEORDER where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID';
  SelectSQL.Text := Str;
end;

{ TSyncPriceData }

function TSyncPriceData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_PRICEDATA';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncPriceData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SAL_PRICEDATA where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID';
  SelectSQL.Text := Str;
end;

function TSyncPriceData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from SAL_PRICEDATA where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID',Params);
end;

{ TSyncPromShop }

function TSyncPromShop.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_PROM_SHOP';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncPromShop.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SAL_PROM_SHOP where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID';
  SelectSQL.Text := Str;
end;

function TSyncPromShop.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from SAL_PROM_SHOP where TENANT_ID=:TENANT_ID and PROM_ID=:PROM_ID',Params);
end;

{ TSyncCheckOrderList }

function TSyncCheckOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select TENANT_ID,SHOP_ID,PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');
  SelectSQL.Text := Str;
end;

{ TSyncCheckOrder }

function TSyncCheckOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE'),self);
end;

function TSyncCheckOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_PRINTORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncCheckOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE';
  SelectSQL.Text := Str;
end;

{ TSyncCheckData }

function TSyncCheckData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_PRINTDATA';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncCheckData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from STO_PRINTDATA where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE';
  SelectSQL.Text := Str;
end;

function TSyncCheckData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from STO_PRINTDATA where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE',Params);
end;

{ TSyncCaTenant }

function TSyncCaTenant.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,
        'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) '+
        'where TENANT_ID in ( '+
        'select j.TENANT_ID as TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID '+
        'union all '+
        'select TENANT_ID from CA_RELATIONS s where s.RELATI_ID=:TENANT_ID '+
        'union all '+
        'select RELATI_ID as TENANT_ID from CA_RELATIONS s where s.TENANT_ID=:TENANT_ID '+
        ') or TENANT_ID=:TENANT_ID'));
end;

function TSyncCaTenant.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str,ComStr:string;
begin
//  Str :=
//  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' i '+
//  'where TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID and (s.TIME_STAMP>:TIME_STAMP or i.TIME_STAMP>:TIME_STAMP)) '+
//        ' or (TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP)'+
//        ' or TENANT_ID in (select TENANT_ID from CA_RELATIONS s where s.RELATI_ID=:TENANT_ID and (s.TIME_STAMP>:TIME_STAMP or i.TIME_STAMP>:TIME_STAMP))'+
//        ' or TENANT_ID in (select RELATI_ID from CA_RELATIONS s where s.TENANT_ID=:TENANT_ID and (s.TIME_STAMP>:TIME_STAMP or i.TIME_STAMP>:TIME_STAMP))'
//        ;
//  if Params.ParamByName('SYN_COMM').AsBoolean then
//     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');
// 优化后的SQL

  if Params.ParamByName('SYN_COMM').AsBoolean then
     ComStr := ParseSQL(AGlobal.iDbType,' and substring(i.COMM,1,1)<>''1''');

  Str :=
  'select i.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' i,( '+
  '   select j.TENANT_ID as TENANT_ID,s.TIME_STAMP as TIME_STAMP from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID '+
  '   union all '+
  '   select TENANT_ID,TIME_STAMP from CA_RELATIONS s where s.RELATI_ID=:TENANT_ID '+
  '   union all '+
  '   select RELATI_ID as TENANT_ID,TIME_STAMP from CA_RELATIONS s where s.TENANT_ID=:TENANT_ID '+
  '   ) r where i.TENANT_ID=r.TENANT_ID and (i.TIME_STAMP>:TIME_STAMP or r.TIME_STAMP>:TIME_STAMP) '+ComStr +
  ' union all '+
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' i where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+ComStr;

  SelectSQL.Text := Str;
end;

{ TSyncCloseForDayList }

function TSyncCloseForDayList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select distinct TENANT_ID,SHOP_ID,CLSE_DATE,CREA_USER from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');
  SelectSQL.Text := Str;
end;

{ TSyncCloseForDayAble }

function TSyncCloseForDayAble.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
var
  r:integer;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_RECVABLE_INFO';
     end;
  InitSQL(AGlobal,false);
  UpdateQuery.SQL.Text := 
    'update ACC_RECVABLE_INFO set RECK_MNY=round(:ACCT_MNY-RECV_MNY,2),ABLE_DATE=:ABLE_DATE,ACCT_MNY=:ACCT_MNY,ACCT_INFO=:ACCT_INFO,CREA_USER=:CREA_USER,CREA_DATE=:CREA_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' '+
    'where TENANT_ID=:TENANT_ID and ABLE_ID=:ABLE_ID';
  FillParams(InsertQuery);
  UpdateQuery.Params.AssignValues(InsertQuery.Params); 
  r := AGlobal.ExecQuery(UpdateQuery);
  if r=0 then
    begin
      try
        FillParams(InsertQuery);
        InsertQuery.ParambyName('RECV_MNY').asFloat := 0;
        InsertQuery.ParambyName('RECK_MNY').asFloat := InsertQuery.ParambyName('ACCT_MNY').asFloat;
        AGlobal.ExecQuery(InsertQuery);
      except
         on E:Exception do
            begin
              if not CheckUnique(E.Message) then
                 Raise;
            end;
      end;
    end;
  Result := True;
end;

function TSyncCloseForDayAble.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from ACC_RECVABLE_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and ABLE_DATE=:CLSE_DATE and CREA_USER=:CREA_USER and RECV_TYPE=''4''';
  SelectSQL.Text := Str;
end;

function TSyncCloseForDayAble.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'delete from ACC_RECVABLE_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and ABLE_DATE=:CLSE_DATE and CREA_USER=:CREA_USER and RECV_TYPE=''4'' and RECV_MNY=0';
  AGlobal.ExecSQL(Str,Params);
  Str := 'update ACC_RECVABLE_INFO set RECK_MNY=-RECV_MNY,ACCT_MNY=0 where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and ABLE_DATE=:CLSE_DATE and CREA_USER=:CREA_USER and RECV_TYPE=''4''';
  AGlobal.ExecSQL(Str,Params);
end;

{ TSyncGodsRelation }

function TSyncGodsRelation.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) '+
   'where TENANT_ID in (select s.TENANT_ID from CA_RELATIONS s where s.RELATI_ID=:TENANT_ID) or (TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP)'),Params);
end;

function TSyncGodsRelation.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str,ComStr:string;
begin
  if Params.ParamByName('SYN_COMM').AsBoolean then
     ComStr := ParseSQL(AGlobal.iDbType,' and substring(i.COMM,1,1)<>''1''');
  Str :=
  'select i.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' i,'+
  '(select s.TENANT_ID as TENANT_ID,s.RELATION_ID as RELATION_ID,s.TIME_STAMP as TIME_STAMP from CA_RELATIONS s where s.RELATI_ID=:TENANT_ID '+
  ' ) r where i.TENANT_ID=r.TENANT_ID and i.RELATION_ID=r.RELATION_ID and (i.TIME_STAMP>:TIME_STAMP or r.TIME_STAMP>:TIME_STAMP) '+ComStr+
  ' union all '+
  'select i.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' i where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+ComStr;

//  Str :=
//  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' i '+
//  'where TENANT_ID in (select s.TENANT_ID from CA_RELATIONS s where s.RELATION_ID=i.RELATION_ID and s.RELATI_ID=:TENANT_ID and (s.TIME_STAMP>:TIME_STAMP or i.TIME_STAMP>:TIME_STAMP)) or (TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP)';
//  if Params.ParamByName('SYN_COMM').AsBoolean then
//     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncGodsInfo }

function TSyncGodsInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) '+
   'where TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID) or (TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP)'),Params);
end;

function TSyncGodsInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+
  ' union all '+
  'select b.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' b,PUB_GOODS_RELATION c,CA_RELATION j,CA_RELATIONS s '+
  'where b.TENANT_ID=j.TENANT_ID and b.GODS_ID=c.GODS_ID and c.RELATION_ID=j.RELATION_ID and c.RELATION_ID=s.RELATION_ID and j.RELATION_ID=s.RELATION_ID and c.TENANT_ID=s.TENANT_ID '+
  ' and s.RELATI_ID=:TENANT_ID and (b.TIME_STAMP>:TIME_STAMP or c.TIME_STAMP>:TIME_STAMP or s.TIME_STAMP>:TIME_STAMP) '+
  '';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := 'select * from ('+Str+') j where '+ParseSQL(AGlobal.iDbType,'substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncLocusForStckData }

function TSyncLocusForStckData.BeforeDeleteRecord(
  AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update STK_LOCUS_FORSTCK set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID'),self);
end;

function TSyncLocusForStckData.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_LOCUS_FORSTCK';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncLocusForStckData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select * from STK_LOCUS_FORSTCK where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID';
end;

function TSyncLocusForStckData.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from STK_LOCUS_FORSTCK where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID',Params);
end;

{ TSyncLocusForSaleData }

function TSyncLocusForSaleData.BeforeDeleteRecord(
  AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update SAL_LOCUS_FORSALE set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID'),self);
end;

function TSyncLocusForSaleData.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_LOCUS_FORSALE';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncLocusForSaleData.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select * from SAL_LOCUS_FORSALE where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
end;

function TSyncLocusForSaleData.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from SAL_LOCUS_FORSALE where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID',Params);
end;

{ TSyncLocusForChagData }

function TSyncLocusForChagData.BeforeDeleteRecord(
  AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update STO_LOCUS_FORCHAG set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID'),self);
end;

function TSyncLocusForChagData.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_LOCUS_FORCHAG';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncLocusForChagData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select * from STO_LOCUS_FORCHAG where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID';
end;

function TSyncLocusForChagData.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from STO_LOCUS_FORCHAG where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID',Params);
end;

{ TSyncSequence }

function TSyncSequence.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select * from SYS_SEQUENCE where TENANT_ID=:TENANT_ID and SEQU_ID=:SEQU_ID';
    rs.Params[0].AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.Params[1].AsString := FieldbyName('SEQU_ID').AsString;
    AGlobal.Open(rs);
    if rs.FieldByName('FLAG_TEXT').AsString>FieldbyName('FLAG_TEXT').AsString then Exit;
    if rs.FieldByName('SEQU_NO').AsInteger>FieldbyName('SEQU_NO').AsInteger then Exit;
    result := inherited BeforeInsertRecord(AGlobal);
  finally
    rs.Free;
  end;
end;
{ TSyncMscQuestion }

function TSyncMscQuestion.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update MSC_QUESTION set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and QUESTION_ID=:QUESTION_ID'),self);
end;

function TSyncMscQuestion.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'MSC_QUESTION';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncMscQuestion.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select * from MSC_QUESTION where TENANT_ID=:TENANT_ID and QUESTION_ID=:QUESTION_ID';
end;

function TSyncMscQuestion.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from MSC_QUESTION where TENANT_ID=:TENANT_ID and QUESTION_ID=:QUESTION_ID',Params);
  AGlobal.ExecSQL('delete from MSC_QUESTION_ITEM where TENANT_ID=:TENANT_ID and QUESTION_ID=:QUESTION_ID',Params);
end;

{ TSyncMscQuestionItem }

function TSyncMscQuestionItem.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'MSC_QUESTION_ITEM';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncMscQuestionItem.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select * from MSC_QUESTION_ITEM where TENANT_ID=:TENANT_ID and QUESTION_ID=:QUESTION_ID';
end;

{ TSyncCaModule }

function TSyncCaModule.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where PROD_ID=:PROD_ID'),Params);
end;

function TSyncCaModule.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
   InitSQL(AGlobal);
   try
     FillParams(InsertQuery);
     AGlobal.ExecQuery(InsertQuery);
   except
     on E:Exception do
        begin
          if CheckUnique(E.Message) then
             begin
               FillParams(UpdateQuery);
               AGlobal.ExecQuery(UpdateQuery);
             end
          else
             Raise;
        end;
   end;
end;

function TSyncCaModule.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  rs :TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    Str := 'select count(*) from '+Params.ParambyName('TABLE_NAME').AsString+ ' where PROD_ID='''+Params.ParambyName('PROD_ID').asString+''' and TIME_STAMP>'+Params.ParambyName('TIME_STAMP').asString;
    if Params.ParamByName('SYN_COMM').AsBoolean then
       Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');
    rs.SQL.Text := Str;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger=0 then
       Str :='select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TIME_STAMP=0 and PROD_ID='''+Params.ParambyName('PROD_ID').asString+''''
    else
       Str :='select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where PROD_ID='''+Params.ParambyName('PROD_ID').asString+'''';
    SelectSQL.Text := Str;
  finally
    rs.Free;
  end;
end;

function TSyncCaModule.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from CA_MODULE where PROD_ID=:PROD_ID',Params);
  result := true;
end;

{ TSyncSysReportList }

function TSyncSysReportList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select distinct TENANT_ID,REPORT_ID from SYS_REPORT where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');
  SelectSQL.Text := Str;
end;

{ TSyncSysReport }

function TSyncSysReport.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update SYS_REPORT set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and REPORT_ID=:REPORT_ID'),self);
end;

function TSyncSysReport.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SYS_REPORT';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncSysReport.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SYS_REPORT where TENANT_ID=:TENANT_ID and REPORT_ID=:REPORT_ID';
  SelectSQL.Text := Str;
end;

{ TSyncSysReportTemplate }

function TSyncSysReportTemplate.BeforeInsertRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SYS_REPORT_TEMPLATE';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncSysReportTemplate.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SYS_REPORT_TEMPLATE where TENANT_ID=:TENANT_ID and REPORT_ID=:REPORT_ID';
  SelectSQL.Text := Str;
end;

function TSyncSysReportTemplate.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from SYS_REPORT_TEMPLATE where TENANT_ID=:TENANT_ID and REPORT_ID=:REPORT_ID',Params);
end;

{ TSyncICGlideInfo }

function TSyncICGlideInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAccountInfo;
var Str:string;
begin
  if FieldbyName('IC_GLIDE_TYPE').AsInteger = 1 then
     Str := 'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) + :GLIDE_MNY where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#'''
  else
     Str := 'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) - :GLIDE_MNY where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#''';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);
end;

function UpdateAccountInfo:boolean;
var
  Str:string;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select IC_GLIDE_TYPE,GLIDE_MNY,IC_CARDNO from SAL_IC_GLIDE where TENANT_ID=:TENANT_ID and GLIDE_ID=:GLIDE_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('GLIDE_ID').AsString := FieldbyName('GLIDE_ID').AsString;  
    AGlobal.Open(rs);
    result := not rs.IsEmpty;
    if not rs.IsEmpty then
       begin
         if rs.FieldbyName('IC_GLIDE_TYPE').AsInteger = 1 then
            Str := 'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) - '+formatFloat('#0.000',rs.FieldbyName('GLIDE_MNY').asFloat)+' where TENANT_ID=:TENANT_ID and IC_CARDNO='''+rs.FieldbyName('IC_CARDNO').AsString+''' and UNION_ID=''#'''
         else
            Str := 'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) + '+formatFloat('#0.000',rs.FieldbyName('GLIDE_MNY').asFloat)+' where TENANT_ID=:TENANT_ID and IC_CARDNO='''+rs.FieldbyName('IC_CARDNO').AsString+''' and UNION_ID=''#''';
         AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);
         InsertAccountInfo;
       end;
  finally
    rs.Free;
  end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_IC_GLIDE';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAccountInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if UpdateAccountInfo then
                   begin
                     FillParams(UpdateQuery);
                     AGlobal.ExecQuery(UpdateQuery);
                   end
                   else
                     Raise;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       if UpdateAccountInfo then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
       end
       else
         r := 0;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAccountInfo;
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;
end;

function TSyncICGlideInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  result := inherited BeforeOpenRecord(AGlobal);
end;

function TSyncICGlideInfo.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  result := inherited BeforeUpdateRecord(AGlobal);
end;

{ TSyncRckCGodsDays }

function TSyncRckCGodsDays.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'RCK_C_GOODS_DAYS';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncRckCGodsDays.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from RCK_C_GOODS_DAYS where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE';
  SelectSQL.Text := Str;
end;

function TSyncRckCGodsDays.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'delete from RCK_C_GOODS_DAYS where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE';
  AGlobal.ExecSQL(Str,Params);
end;

initialization
  RegisterClass(TSyncSingleTable);
  RegisterClass(TSyncCaTenant);
  RegisterClass(TSyncCaRelationInfo);
  RegisterClass(TSyncCaRelations);
  RegisterClass(TSyncGodsInfo);
  RegisterClass(TSyncGodsRelation);
  RegisterClass(TSyncPubBarcode);
  RegisterClass(TSyncPubIcInfo);
  RegisterClass(TSyncStockOrderList);
  RegisterClass(TSyncStockOrder);
  RegisterClass(TSyncStockData);
  RegisterClass(TSyncSalesOrderList);
  RegisterClass(TSyncSalesOrder);
  RegisterClass(TSyncSalesData);
  RegisterClass(TSyncChangeOrderList);
  RegisterClass(TSyncChangeOrder);
  RegisterClass(TSyncChangeData);
  RegisterClass(TSyncStkIndentOrderList);
  RegisterClass(TSyncStkIndentOrder);
  RegisterClass(TSyncStkIndentData);
  RegisterClass(TSyncSalIndentOrderList);
  RegisterClass(TSyncSalIndentOrder);
  RegisterClass(TSyncSalIndentData);
  RegisterClass(TSyncAccountInfo);
  RegisterClass(TSyncIoroOrderList);
  RegisterClass(TSyncIoroOrder);
  RegisterClass(TSyncIoroData);
  RegisterClass(TSyncTransOrder);
  RegisterClass(TSyncRecvOrderList);
  RegisterClass(TSyncRecvOrder);
  RegisterClass(TSyncRecvData);
  RegisterClass(TSyncPayOrderList);
  RegisterClass(TSyncPayOrder);
  RegisterClass(TSyncPayData);

  RegisterClass(TSyncPriceOrderList);
  RegisterClass(TSyncPriceOrder);
  RegisterClass(TSyncPriceData);
  RegisterClass(TSyncPromShop);

  RegisterClass(TSyncCheckOrderList);
  RegisterClass(TSyncCheckOrder);
  RegisterClass(TSyncCheckData);

  RegisterClass(TSyncRckDaysCloseList);
  RegisterClass(TSyncRckDaysClose);
  RegisterClass(TSyncRckGodsDaysOrder);
  RegisterClass(TSyncRckCGodsDays);
  RegisterClass(TSyncRckAcctDaysOrder);
  RegisterClass(TSyncRckMonthCloseList);
  RegisterClass(TSyncRckMonthClose);
  RegisterClass(TSyncRckGodsMonthOrder);
  RegisterClass(TSyncRckAcctMonthOrder);
  RegisterClass(TSyncCloseForDayList);
  RegisterClass(TSyncCloseForDay);
  RegisterClass(TSyncCloseForDayAble);
  RegisterClass(TSyncICGlideInfo);

  RegisterClass(TSyncLocusForStckData);
  RegisterClass(TSyncLocusForSaleData);
  RegisterClass(TSyncLocusForChagData);
  RegisterClass(TSyncSequence);
  RegisterClass(TSyncMscQuestion);
  RegisterClass(TSyncMscQuestionItem);

  RegisterClass(TSyncCaModule);
  RegisterClass(TSyncSysReportList);
  RegisterClass(TSyncSysReport);
  RegisterClass(TSyncSysReportTemplate);
finalization
  UnRegisterClass(TSyncSingleTable);
  UnRegisterClass(TSyncCaTenant);
  UnRegisterClass(TSyncCaRelationInfo);
  UnRegisterClass(TSyncCaRelations);
  UnRegisterClass(TSyncGodsInfo);
  UnRegisterClass(TSyncGodsRelation);
  UnRegisterClass(TSyncPubBarcode);
  UnRegisterClass(TSyncPubIcInfo);
  UnRegisterClass(TSyncStockOrderList);
  UnRegisterClass(TSyncStockOrder);
  UnRegisterClass(TSyncStockData);
  UnRegisterClass(TSyncSalesOrderList);
  UnRegisterClass(TSyncSalesOrder);
  UnRegisterClass(TSyncSalesData);
  UnRegisterClass(TSyncChangeOrderList);
  UnRegisterClass(TSyncChangeOrder);
  UnRegisterClass(TSyncChangeData);
  UnRegisterClass(TSyncStkIndentOrderList);
  UnRegisterClass(TSyncStkIndentOrder);
  UnRegisterClass(TSyncStkIndentData);
  UnRegisterClass(TSyncSalIndentOrderList);
  UnRegisterClass(TSyncSalIndentOrder);
  UnRegisterClass(TSyncSalIndentData);
  UnRegisterClass(TSyncAccountInfo);
  UnRegisterClass(TSyncIoroOrderList);
  UnRegisterClass(TSyncIoroOrder);
  UnRegisterClass(TSyncIoroData);
  UnRegisterClass(TSyncTransOrder);
  UnRegisterClass(TSyncRecvOrderList);
  UnRegisterClass(TSyncRecvOrder);
  UnRegisterClass(TSyncRecvData);
  UnRegisterClass(TSyncPayOrderList);
  UnRegisterClass(TSyncPayOrder);
  UnRegisterClass(TSyncPayData);

  UnRegisterClass(TSyncPriceOrderList);
  UnRegisterClass(TSyncPriceOrder);
  UnRegisterClass(TSyncPriceData);
  UnRegisterClass(TSyncPromShop);

  UnRegisterClass(TSyncCheckOrderList);
  UnRegisterClass(TSyncCheckOrder);
  UnRegisterClass(TSyncCheckData);

  UnRegisterClass(TSyncRckDaysCloseList);
  UnRegisterClass(TSyncRckDaysClose);
  UnRegisterClass(TSyncRckGodsDaysOrder);
  UnRegisterClass(TSyncRckCGodsDays);
  UnRegisterClass(TSyncRckAcctDaysOrder);
  UnRegisterClass(TSyncRckMonthCloseList);
  UnRegisterClass(TSyncRckMonthClose);
  UnRegisterClass(TSyncRckGodsMonthOrder);
  UnRegisterClass(TSyncRckAcctMonthOrder);
  UnRegisterClass(TSyncCloseForDayList);
  UnRegisterClass(TSyncCloseForDay);
  UnRegisterClass(TSyncCloseForDayAble);
  UnRegisterClass(TSyncICGlideInfo);

  UnRegisterClass(TSyncLocusForStckData);
  UnRegisterClass(TSyncLocusForSaleData);
  UnRegisterClass(TSyncLocusForChagData);
  UnRegisterClass(TSyncSequence);
  UnRegisterClass(TSyncMscQuestion);
  UnRegisterClass(TSyncMscQuestionItem);

  UnRegisterClass(TSyncCaModule);
  UnRegisterClass(TSyncSysReportList);
  UnRegisterClass(TSyncSysReport);
  UnRegisterClass(TSyncSysReportTemplate);
end.
