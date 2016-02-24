object MainForm: TMainForm
  Left = 192
  Top = 111
  Width = 928
  Height = 494
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox: TPaintBox
    Left = 97
    Top = 0
    Width = 815
    Height = 435
    Align = alClient
    OnMouseDown = PaintBoxMouseDown
    OnMouseMove = PaintBoxMouseMove
    OnMouseUp = PaintBoxMouseUp
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 97
    Height = 435
    Align = alLeft
    TabOrder = 0
    object SB_OR: TSpeedButton
      Tag = 6
      Left = 0
      Top = 32
      Width = 97
      Height = 33
      GroupIndex = 1
      Caption = 'Or'
      OnClick = SB_Click
    end
    object SB_AND: TSpeedButton
      Tag = 5
      Left = 0
      Top = 64
      Width = 97
      Height = 33
      GroupIndex = 1
      Caption = 'And'
      OnClick = SB_Click
    end
    object SB_NOT: TSpeedButton
      Tag = 9
      Left = 0
      Top = 96
      Width = 97
      Height = 33
      GroupIndex = 1
      Caption = 'Not'
      OnClick = SB_Click
    end
    object SB_SwitchInput: TSpeedButton
      Tag = 2
      Left = 0
      Top = 128
      Width = 97
      Height = 33
      GroupIndex = 1
      Down = True
      Caption = 'Input'
      OnClick = SB_Click
    end
    object SB_Output: TSpeedButton
      Tag = 4
      Left = 0
      Top = 160
      Width = 97
      Height = 33
      GroupIndex = 1
      Caption = 'Output'
      OnClick = SB_Click
    end
    object SB_Rubber: TSpeedButton
      Left = 0
      Top = 0
      Width = 97
      Height = 33
      GroupIndex = 1
      Caption = 'Rubber'
      OnClick = SB_Click
    end
    object SbTurn: TSpeedButton
      Tag = 17
      Left = 0
      Top = 192
      Width = 97
      Height = 33
      GroupIndex = 1
      Caption = 'Turn'
      OnClick = SbTurnClick
    end
    object SbLine: TSpeedButton
      Tag = 35
      Left = 0
      Top = 224
      Width = 97
      Height = 33
      GroupIndex = 1
      Caption = 'Line'
      OnClick = SbLineClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 104
    Top = 8
    object File1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'New'
        OnClick = ClearAll1Click
      end
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Check1: TMenuItem
        Caption = 'Check scheme'
        OnClick = Check1Click
      end
      object Editscheme1: TMenuItem
        Caption = 'Edit scheme'
        OnClick = Editscheme1Click
      end
      object ClearAll1: TMenuItem
        Caption = 'Clear All'
        OnClick = ClearAll1Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'logic(*.ls)|*.ls'
    Title = 'Save As'
    OnCanClose = SaveDialog1CanClose
    Left = 136
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Filter = 'logic(*.ls)|*.ls'
    Title = 'Open'
    OnCanClose = OpenDialog1CanClose
    Left = 168
    Top = 8
  end
end
