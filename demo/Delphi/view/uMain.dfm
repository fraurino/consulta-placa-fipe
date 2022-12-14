object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consulta Placa por API'
  ClientHeight = 436
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 19
    Width = 93
    Height = 13
    Caption = 'Servi'#231'o da consulta'
  end
  object Label2: TLabel
    Left = 0
    Top = 423
    Width = 498
    Height = 13
    Cursor = crHandPoint
    Align = alBottom
    Alignment = taCenter
    Caption = 
      'Desenvolvido por Francisco Aurino | API fornecida por https://ap' +
      'igratis.com.br'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label2Click
    ExplicitWidth = 445
  end
  object edtPlaca: TLabeledEdit
    Left = 196
    Top = 38
    Width = 121
    Height = 21
    EditLabel.Width = 76
    EditLabel.Height = 13
    EditLabel.Caption = 'Placa do Ve'#237'culo'
    TabOrder = 0
    Text = 'FMR7534'
    TextHint = 'digite a placa'
  end
  object log: TMemo
    Left = 196
    Top = 112
    Width = 281
    Height = 297
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object cbbServico: TComboBox
    Left = 8
    Top = 38
    Width = 182
    Height = 21
    Cursor = crHandPoint
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'Placa - FIPE'
    TextHint = 'escolha o servico'
    OnChange = cbbServicoChange
    OnClick = cbbServicoClick
    Items.Strings = (
      'Placa - FIPE'
      'Placa - Dados')
  end
  object btnConsultar: TButton
    Left = 196
    Top = 65
    Width = 283
    Height = 25
    Cursor = crHandPoint
    Caption = 'Consultar Placa'
    TabOrder = 3
    OnClick = btnConsultarClick
  end
  object Marca: TLabeledEdit
    Left = 10
    Top = 80
    Width = 180
    Height = 24
    TabStop = False
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'Marca'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object Municipio: TLabeledEdit
    Left = 10
    Top = 128
    Width = 180
    Height = 24
    TabStop = False
    EditLabel.Width = 43
    EditLabel.Height = 13
    EditLabel.Caption = 'Municipio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object Renavam: TLabeledEdit
    Left = 10
    Top = 171
    Width = 180
    Height = 24
    TabStop = False
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Renavam'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object Ano: TLabeledEdit
    Left = 10
    Top = 216
    Width = 180
    Height = 21
    TabStop = False
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'Ano'
    TabOrder = 7
  end
  object Modelo: TLabeledEdit
    Left = 10
    Top = 256
    Width = 180
    Height = 21
    TabStop = False
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Modelo'
    TabOrder = 8
  end
  object Chassi: TLabeledEdit
    Left = 10
    Top = 296
    Width = 180
    Height = 21
    TabStop = False
    EditLabel.Width = 31
    EditLabel.Height = 13
    EditLabel.Caption = 'Chassi'
    TabOrder = 9
  end
  object Token: TLabeledEdit
    Left = 323
    Top = 38
    Width = 156
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'Token'
    TabOrder = 10
    TextHint = 'use chavedemo'
  end
  object CodigoFipe: TLabeledEdit
    Left = 8
    Top = 336
    Width = 180
    Height = 21
    TabStop = False
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Codigo Fipe'
    TabOrder = 11
  end
end
