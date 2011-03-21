 {******************************************************************************

ͼ��˳���Ӧ��

 0     New        ����
 1     Edit       �޸�
 2     Delete     ɾ��
 3     Define     ����
 4     Export     ����
 5     First      ��һ��
 6     Help       ����
 7     Last       ���һ��
 8     Next       ��һ��
 9     Preview    Ԥ��
10     Print      ��ӡ
11     Prior      ǰһ��
12     Search     ����
13     Exit       �˳�
14     Save       ����
15     Cancel     ȡ��
16     Commit     ѡ��
17     Refresh    ˢ��
18     Locate     ��λ
19     Up         ����
20     Down       ����
21     UnSel      ��ѡ
22     Special    ר��
23     Balance    ���
24     Hurry      �߿�
25     UnSelAll   ȫ��
26     SelAll     ȫѡ
27     DelRow     ɾ��
28     Voucher    ƾ֤
29     AddRow     ����
30     ChkRgt     ����
31     ChkLgr     ����
32     Ledger     ����
33     Way        ����
34     Detail     ��ϸ
35     Check      ���
36     TryCount   ����
37     Trans      ת��
38     Revert     ��ԭ
39     OutPut     ���
40     Setup      ����
41     Convert    ת��
42     Assistant  ����
43     Filter     ����
44     Select     ѡ��
45     Cashier    ǩ��
46     Audit      ���
47     Flag       ���
48     Yesterday  ����
49     btnBack    �ϲ�
50     btnNext    �²�
51     Low        �¼�
52     Assistant1 ����1
53     Assistant2 �����ʱ�����
54     SubCode    �¼���Ŀ����
55     Detail1    ��ϸ
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
    {װ��16��16��ͼ����Դ}
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
    //Index 0  ����
    HsResOpr.GetDllIcoRes(Icon, 'New',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 1  �޸�
    HsResOpr.GetDllIcoRes(Icon, 'Edit',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 2  ɾ��
    HsResOpr.GetDllIcoRes(Icon, 'Delete',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 3  ����
    HsResOpr.GetDllIcoRes(Icon, 'Define',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 4  ����
    HsResOpr.GetDllIcoRes(Icon, 'Export',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 5  ��һ��
    HsResOpr.GetDllIcoRes(Icon, 'First',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 6  ����
    HsResOpr.GetDllIcoRes(Icon, 'Help',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 7  ���һ��
    HsResOpr.GetDllIcoRes(Icon, 'Last',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 8  ��һ��
    HsResOpr.GetDllIcoRes(Icon, 'Next',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 9  Ԥ��
    HsResOpr.GetDllIcoRes(Icon, 'Preview',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 10  ��ӡ
    HsResOpr.GetDllIcoRes(Icon, 'Print',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 11  ǰһ��
    HsResOpr.GetDllIcoRes(Icon, 'Prior',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 12  ����
    HsResOpr.GetDllIcoRes(Icon, 'Search',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 13  �˳�
    HsResOpr.GetDllIcoRes(Icon, 'Exit',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 14  ����
    HsResOpr.GetDllIcoRes(Icon, 'Save',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 15  ȡ��
    HsResOpr.GetDllIcoRes(Icon, 'Cancel',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 16  �ύ
    HsResOpr.GetDllIcoRes(Icon, 'Commit',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 17  ˢ��
    HsResOpr.GetDllIcoRes(Icon, 'Refresh',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 18  ��λ
    HsResOpr.GetDllIcoRes(Icon, 'Locate',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 19  ����
    HsResOpr.GetDllIcoRes(Icon, 'Up',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 20  ����
    HsResOpr.GetDllIcoRes(Icon, 'Down',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 21  ��ѡ
    HsResOpr.GetDllIcoRes(Icon, 'UnSel',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 22  ר��
    HsResOpr.GetDllIcoRes(Icon, 'Special',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 23  ���
    HsResOpr.GetDllIcoRes(Icon, 'Balance',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 24  �߿�
    HsResOpr.GetDllIcoRes(Icon, 'Hurry',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 25  ȫ��
    HsResOpr.GetDllIcoRes(Icon, 'UnSelAll',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 26  ȫѡ
    HsResOpr.GetDllIcoRes(Icon, 'SelAll',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 27  ɾ��
    HsResOpr.GetDllIcoRes(Icon, 'DelRow',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 28  ƾ֤
    HsResOpr.GetDllIcoRes(Icon, 'Voucher',sDllName);
    imgLst16.AddIcon(Icon);


    //Index 29  ����
    HsResOpr.GetDllIcoRes(Icon, 'AddRow',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 30  ����
    HsResOpr.GetDllIcoRes(Icon, 'ChkRgt',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 31  ����
    HsResOpr.GetDllIcoRes(Icon, 'ChkLgr',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 32  ����
    HsResOpr.GetDllIcoRes(Icon, 'Ledger',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 33  ����
    HsResOpr.GetDllIcoRes(Icon, 'Way',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 34  ��ϸ
    HsResOpr.GetDllIcoRes(Icon, 'Detail',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 35  ���
    HsResOpr.GetDllIcoRes(Icon, 'Check',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 36  ����
    HsResOpr.GetDllIcoRes(Icon, 'TryCount',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 37  ת��
    HsResOpr.GetDllIcoRes(Icon, 'Trans',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 38  ��ԭ
    HsResOpr.GetDllIcoRes(Icon, 'Revert',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 39  ���
    HsResOpr.GetDllIcoRes(Icon, 'OutPut',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 40  ����
    HsResOpr.GetDllIcoRes(Icon, 'Setup',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 41  ת��
    HsResOpr.GetDllIcoRes(Icon, 'Convert',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 42  ����
    HsResOpr.GetDllIcoRes(Icon, 'Assistant',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 43  ����
    HsResOpr.GetDllIcoRes(Icon, 'Filter',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 44  ѡ��
    HsResOpr.GetDllIcoRes(Icon, 'Select',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 45   ǩ��
    HsResOpr.GetDllIcoRes(Icon, 'Cashier',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 46   ���
    HsResOpr.GetDllIcoRes(Icon, 'Audit',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 47   ���
    HsResOpr.GetDllIcoRes(Icon, 'Flag',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 48   ����
    HsResOpr.GetDllIcoRes(Icon, 'Yesterday',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 49   �ϲ�
    HsResOpr.GetDllIcoRes(Icon, 'btnBack',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 50   �²�
    HsResOpr.GetDllIcoRes(Icon, 'btnNext',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 51   �¼�
    HsResOpr.GetDllIcoRes(Icon, 'Low',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 52   ����1
    HsResOpr.GetDllIcoRes(Icon, 'assistant1',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 53   �����ʱ�����
    HsResOpr.GetDllIcoRes(Icon, 'assistant2',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 54   �¼���Ŀ����
    HsResOpr.GetDllIcoRes(Icon, 'SubCode',sDllName);
    imgLst16.AddIcon(Icon);

    //Index 55   ��ϸ
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
