 {******************************************************************************

图标顺序对应表

 0     New        新增
 1     Edit       修改
 2     Delete     删除
 3     Define     定义
 4     Export     导出
 5     First      第一条
 6     Help       帮助
 7     Last       最后一条
 8     Next       下一条
 9     Preview    预览
10     Print      打印
11     Prior      前一条
12     Search     查找
13     Exit       退出
14     Save       保存
15     Cancel     取消
16     Commit     选入
17     Refresh    刷新
18     Locate     定位
19     Up         上移
20     Down       下移
21     UnSel      不选
22     Special    专项
23     Balance    余额
24     Hurry      催款
25     UnSelAll   全消
26     SelAll     全选
27     DelRow     删行
28     Voucher    凭证
29     AddRow     增行
30     ChkRgt     勾对
31     ChkLgr     对账
32     Ledger     总帐
33     Way        方向
34     Detail     明细
35     Check      检查
36     TryCount   试算
37     Trans      转帐
38     Revert     还原
39     OutPut     输出
40     Setup      设置
41     Convert    转换
42     Assistant  辅助
43     Filter     过滤
44     Select     选中
45     Cashier    签字
46     Audit      审核
47     Flag       标错
48     Yesterday  昨天
49     btnBack    上步
50     btnNext    下步
51     Low        下级
52     Assistant1 辅助1
53     Assistant2 辅助帐薄联查
54     SubCode    下级科目联查
55     Detail1    详细
******************************************************************************}

unit udmIcon;

interface

uses
  SysUtils, Classes, ImgList, Controls,uResOpr,Graphics;

type
  TdmIcon = class(TDataModule)
    ImgLst16: TImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    {装载16×16的图标资源}
    procedure LoadIcon16;
  public
    { Public declarations }
    HsResOpr: THsResOpr;
  end;

var
  dmIcon: TdmIcon;

implementation

{$R *.dfm}

procedure TdmIcon.LoadIcon16;
const sDllName = 'Icon16.Dll';
var Icon: TIcon;
begin
  Icon     := TIcon.Create;
  try
    imgLst16.Clear;
    //Index 0  新增
    HsResOpr.GetDllIcoRes(Icon, 'New',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 1  修改
    HsResOpr.GetDllIcoRes(Icon, 'Edit',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 2  删除
    HsResOpr.GetDllIcoRes(Icon, 'Delete',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 3  定义
    HsResOpr.GetDllIcoRes(Icon, 'Define',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 4  导出
    HsResOpr.GetDllIcoRes(Icon, 'Export',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 5  第一条
    HsResOpr.GetDllIcoRes(Icon, 'First',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 6  帮助
    HsResOpr.GetDllIcoRes(Icon, 'Help',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 7  最后一条
    HsResOpr.GetDllIcoRes(Icon, 'Last',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 8  下一条
    HsResOpr.GetDllIcoRes(Icon, 'Next',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 9  预览
    HsResOpr.GetDllIcoRes(Icon, 'Preview',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 10  打印
    HsResOpr.GetDllIcoRes(Icon, 'Print',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 11  前一条
    HsResOpr.GetDllIcoRes(Icon, 'Prior',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 12  查找
    HsResOpr.GetDllIcoRes(Icon, 'Search',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 13  退出
    HsResOpr.GetDllIcoRes(Icon, 'Exit',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 14  保存
    HsResOpr.GetDllIcoRes(Icon, 'Save',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 15  取消
    HsResOpr.GetDllIcoRes(Icon, 'Cancel',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 16  提交
    HsResOpr.GetDllIcoRes(Icon, 'Commit',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 17  刷新
    HsResOpr.GetDllIcoRes(Icon, 'Refresh',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 18  定位
    HsResOpr.GetDllIcoRes(Icon, 'Locate',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 19  上移
    HsResOpr.GetDllIcoRes(Icon, 'Up',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 20  下移
    HsResOpr.GetDllIcoRes(Icon, 'Down',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 21  不选
    HsResOpr.GetDllIcoRes(Icon, 'UnSel',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 22  专项
    HsResOpr.GetDllIcoRes(Icon, 'Special',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 23  余额
    HsResOpr.GetDllIcoRes(Icon, 'Balance',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 24  催款
    HsResOpr.GetDllIcoRes(Icon, 'Hurry',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 25  全消
    HsResOpr.GetDllIcoRes(Icon, 'UnSelAll',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 26  全选
    HsResOpr.GetDllIcoRes(Icon, 'SelAll',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 27  删行
    HsResOpr.GetDllIcoRes(Icon, 'DelRow',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 28  凭证
    HsResOpr.GetDllIcoRes(Icon, 'Voucher',sDllName);
    imgLst16.AddIcon(Icon);


    //Index 29  增行
    HsResOpr.GetDllIcoRes(Icon, 'AddRow',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 30  勾对
    HsResOpr.GetDllIcoRes(Icon, 'ChkRgt',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 31  对账
    HsResOpr.GetDllIcoRes(Icon, 'ChkLgr',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 32  总帐
    HsResOpr.GetDllIcoRes(Icon, 'Ledger',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 33  方向
    HsResOpr.GetDllIcoRes(Icon, 'Way',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 34  明细
    HsResOpr.GetDllIcoRes(Icon, 'Detail',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 35  检查
    HsResOpr.GetDllIcoRes(Icon, 'Check',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 36  试算
    HsResOpr.GetDllIcoRes(Icon, 'TryCount',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 37  转帐
    HsResOpr.GetDllIcoRes(Icon, 'Trans',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 38  还原
    HsResOpr.GetDllIcoRes(Icon, 'Revert',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 39  输出
    HsResOpr.GetDllIcoRes(Icon, 'OutPut',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 40  设置
    HsResOpr.GetDllIcoRes(Icon, 'Setup',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 41  转换
    HsResOpr.GetDllIcoRes(Icon, 'Convert',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 42  辅助
    HsResOpr.GetDllIcoRes(Icon, 'Assistant',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 43  过滤
    HsResOpr.GetDllIcoRes(Icon, 'Filter',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 44  选中
    HsResOpr.GetDllIcoRes(Icon, 'Select',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 45   签字
    HsResOpr.GetDllIcoRes(Icon, 'Cashier',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 46   审核
    HsResOpr.GetDllIcoRes(Icon, 'Audit',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 47   标错
    HsResOpr.GetDllIcoRes(Icon, 'Flag',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 48   昨天
    HsResOpr.GetDllIcoRes(Icon, 'Yesterday',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 49   上步
    HsResOpr.GetDllIcoRes(Icon, 'btnBack',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 50   下步
    HsResOpr.GetDllIcoRes(Icon, 'btnNext',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 51   下级
    HsResOpr.GetDllIcoRes(Icon, 'Low',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 52   辅助1
    HsResOpr.GetDllIcoRes(Icon, 'assistant1',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 53   辅助帐薄联查
    HsResOpr.GetDllIcoRes(Icon, 'assistant2',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 54   下级科目联查
    HsResOpr.GetDllIcoRes(Icon, 'SubCode',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 55   详细
    HsResOpr.GetDllIcoRes(Icon, 'Detail1',sDllName);
    imgLst16.AddIcon(Icon);
  finally
    Icon.Free;
  end;
end;

procedure TdmIcon.DataModuleCreate(Sender: TObject);
begin
  HsResOpr := THsResOpr.Create;
  LoadIcon16;
end;

procedure TdmIcon.DataModuleDestroy(Sender: TObject);
begin
  HsResOpr.Free;
end;

end.
