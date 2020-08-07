object frmConvert: TfrmConvert
  Left = 418
  Top = 237
  Caption = 'Print2Flash Document Conversion Server'
  ClientHeight = 180
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label3: TLabel
    Left = 10
    Top = 84
    Width = 67
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Converting:'
  end
  object Label1: TLabel
    Left = 10
    Top = 135
    Width = 65
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Converted:'
  end
  object Label2: TLabel
    Left = 10
    Top = 161
    Width = 39
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Errors:'
  end
  object lbConverting: TLabel
    Left = 97
    Top = 84
    Width = 75
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'lbConverting'
  end
  object lbConverted: TLabel
    Left = 97
    Top = 135
    Width = 73
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'lbConverted'
  end
  object lbErrors: TLabel
    Left = 97
    Top = 161
    Width = 47
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'lbErrors'
  end
  object Label4: TLabel
    Left = 9
    Top = 109
    Width = 65
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Doc format'
  end
  object lbDocFormat: TLabel
    Left = 97
    Top = 109
    Width = 78
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'lbDocFormat'
  end
  object Label6: TLabel
    Left = 10
    Top = 33
    Width = 22
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'DB:'
  end
  object lbDBStatus: TLabel
    Left = 97
    Top = 33
    Width = 67
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'lbDBStatus'
  end
  object Label7: TLabel
    Left = 10
    Top = 58
    Width = 70
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'FileSystem:'
  end
  object lbFSStatus: TLabel
    Left = 97
    Top = 58
    Width = 65
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'lbFSStatus'
  end
  object Label8: TLabel
    Left = 10
    Top = 7
    Width = 27
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'P2F:'
  end
  object lbP2FStatus: TLabel
    Left = 97
    Top = 7
    Width = 67
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'lbDBStatus'
  end
end
