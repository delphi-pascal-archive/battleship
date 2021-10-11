object Form1: TForm1
  Left = 217
  Top = 134
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1052#1086#1088#1089#1082#1086#1081' '#1073#1086#1081
  ClientHeight = 419
  ClientWidth = 977
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 39
    Top = 374
    Width = 196
    Height = 26
    Caption = #1052#1080#1089#1089#1080#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 276
    Top = 345
    Width = 380
    Height = 26
    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1072' '#1082#1086#1088#1072#1073#1083#1077#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label2Click
    OnMouseMove = Label2MouseMove
    OnMouseLeave = Label2MouseLeave
  end
  object Label3: TLabel
    Left = 443
    Top = 384
    Width = 70
    Height = 26
    Caption = #1043#1086#1090#1086#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label3Click
    OnMouseMove = Label3MouseMove
    OnMouseLeave = Label3MouseLeave
  end
  object Label4: TLabel
    Left = 650
    Top = 10
    Width = 116
    Height = 26
    Caption = #1053#1086#1074#1072#1103' '#1080#1075#1088#1072
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label4Click
  end
  object Label5: TLabel
    Left = 650
    Top = 89
    Width = 6
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 69
    Top = 345
    Width = 99
    Height = 25
    Caption = #1054#1089#1090#1072#1083#1086#1089#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 384
    Top = 345
    Width = 99
    Height = 25
    Caption = #1054#1089#1090#1072#1083#1086#1089#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 10
    Top = 10
    Width = 631
    Height = 326
    TabOrder = 0
    object Image1: TImage
      Left = 10
      Top = 10
      Width = 612
      Height = 306
      OnMouseDown = Image1MouseDown
      OnMouseMove = Image1MouseMove
    end
  end
  object MediaPlayer1: TMediaPlayer
    Left = 601
    Top = 394
    Width = 307
    Height = 37
    Visible = False
    TabOrder = 1
  end
  object RadioGroup1: TRadioGroup
    Left = 699
    Top = 286
    Width = 267
    Height = 89
    Caption = #1042#1072#1088#1080#1072#1085#1090' '#1080#1075#1088#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      #1055#1086#1087#1072#1083' - '#1087#1088#1086#1084#1072#1079#1072#1083
      #1055#1086#1087#1072#1083' - '#1087#1088#1086#1084#1072#1079#1072#1083' - '#1091#1073#1080#1083)
    ParentFont = False
    TabOrder = 2
  end
  object Timer1: TTimer
    Interval = 110
    OnTimer = Timer1Timer
    Left = 240
    Top = 320
  end
  object Timer2: TTimer
    Interval = 1600
    OnTimer = Timer2Timer
    Left = 272
    Top = 320
  end
  object Timer3: TTimer
    Interval = 1980
    OnTimer = Timer3Timer
    Left = 312
    Top = 320
  end
end
