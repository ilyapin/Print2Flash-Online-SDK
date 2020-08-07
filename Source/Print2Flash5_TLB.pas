unit Print2Flash5_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 45604 $
// File generated on 06.03.2018 19:59:25 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\H\lithesoft\print2flash\delphi\p2f (1)
// LIBID: {F032CC6E-C508-40E1-8AD0-344FEA0197FB}
// LCID: 0
// Helpfile:
// HelpString: Print2Flash 5.0 Library
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  Print2Flash5MajorVersion = 5;
  Print2Flash5MinorVersion = 0;

  LIBID_Print2Flash5: TGUID = '{F032CC6E-C508-40E1-8AD0-344FEA0197FB}';

  IID_IProfile: TGUID = '{85586141-D013-44D6-B771-090A201463C6}';
  IID_IBatchProcessingOptions: TGUID = '{B5D31A0C-B37A-45B0-B855-52E9A8319839}';
  IID_IPrintingPreferences: TGUID = '{C6556430-49E6-4E5E-913D-5B0A2A973B95}';
  IID_IServer: TGUID = '{B6FF280B-7540-45B4-B527-44945D9D2234}';
  CLASS_Server: TGUID = '{62B34AF6-7949-43C1-9825-31CEB3AAE85B}';
  CLASS_Profile: TGUID = '{3C89303E-AED4-4CF2-BEA3-D24A55EB461B}';
  CLASS_BatchProcessingOptions: TGUID = '{6A14D94E-35AA-4D66-BBEF-A26BEE498B9B}';
  CLASS_PrintingPreferences: TGUID = '{C82766EF-73F6-4A38-92C1-C0E2ECCDC1CB}';
  CLASS_Server2: TGUID = '{466FAC17-24D2-4B37-A2C4-E2CFA0D3E1EB}';
  CLASS_Profile2: TGUID = '{3AF2BD76-043E-442B-A34D-5DD8239C8A1B}';
  CLASS_BatchProcessingOptions2: TGUID = '{185DCF25-B5F5-412D-883A-41B62BDBC03B}';
  CLASS_PrintingPreferences2: TGUID = '{B913F8C1-473A-4963-BE48-B6FE1181085B}';
  IID_IP2FApp: TGUID = '{CC994315-F509-407E-BF86-ACB391428640}';
  CLASS_P2FApp: TGUID = '{BC7C2AD0-10AC-4D9A-9DDC-573D34987AAB}';
  IID_ISkinCollection: TGUID = '{44B39C5D-9B7A-4715-8052-ED653D36F1BA}';
  IID_IExcelOptions: TGUID = '{76F313A0-D328-44CE-B680-31896F2CC56E}';
  IID_IPowerPointOptions: TGUID = '{7A3E353C-B57D-42CF-BE25-400444E85A6B}';
  CLASS_SkinCollection: TGUID = '{27376BF0-84EF-4A7E-B1E8-ED03D99527FB}';
  CLASS_ExcelOptions: TGUID = '{B320BFC0-2D5C-457F-AF02-47F7E0B7F4BB}';
  CLASS_PowerPointOptions: TGUID = '{A1D2FAD1-A450-44A1-B9A8-21E7C77EC29B}';
  IID_ISkin: TGUID = '{7C0BBF6C-4E9F-438F-A4FE-92BB705EE1A1}';
  CLASS_Skin: TGUID = '{BFA7C6D9-B701-466E-8F79-AAA61981C67B}';
  CLASS_SkinCollection2: TGUID = '{59FB2BAA-F8A4-486F-B206-C04C52467F6B}';
  CLASS_ExcelOptions2: TGUID = '{8BBA0E11-7670-4866-81E6-6A173C49D54B}';
  CLASS_PowerPointOptions2: TGUID = '{C3AD97D1-FF33-4C51-B3D4-256DF543980B}';
  CLASS_Skin2: TGUID = '{8E45F671-B29D-460A-928A-522D5164704B}';
  IID_IHTML5Options: TGUID = '{00BDBB8E-1669-432C-AB0E-75F323118129}';
  CLASS_HTML5Options: TGUID = '{581A7B7C-BC4C-427C-826F-D2D44F14FB4B}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum ThreeStateFlag
type
  ThreeStateFlag = TOleEnum;
const
  TSF_NO = $00000000;
  TSF_YES = $00000001;
  TSF_AUTO = $00000002;

// Constants for enum INTERFACE_OPTION
type
  INTERFACE_OPTION = TOleEnum;
const
  INTLOGO = $00000001;
  INTDRAG = $00000002;
  INTSELTEXT = $00000004;
  INTZOOMSLIDER = $00000008;
  INTZOOMBOX = $00000010;
  INTFITWIDTH = $00000020;
  INTFITPAGE = $00000040;
  INTPREVPAGE = $00000080;
  INTGOTOPAGE = $00000100;
  INTNEXTPAGE = $00000200;
  INTSEARCHBOX = $00000400;
  INTSEARCHBUT = $00000800;
  INTROTATE = $00001000;
  INTPRINT = $00002000;
  INTNEWWIND = $00004000;
  INTHELP = $00008000;
  INTBACKBUTTON = $00030000;
  INTBACKBUTTONAUTO = $00010000;
  INTFORWARDBUTTON = $000C0000;
  INTFORWARDBUTTONAUTO = $00040000;
  INTFULLSCREEN = $00300000;
  INTFULLSCREENAUTO = $00100000;
  INTPRINTAUTO = $00402000;

// Constants for enum PROTECTION_OPTION
type
  PROTECTION_OPTION = TOleEnum;
const
  PROTDISPRINT = $00000001;
  PROTDISTEXTCOPY = $00000002;
  PROTENAPI = $00000004;
  PROTDISTEXTCOPYAPI = $00000008;

// Constants for enum PAPER_ORIENTATION
type
  PAPER_ORIENTATION = TOleEnum;
const
  ORIENT_PORTRAIT = $00000001;
  ORIENT_LANDSCAPE = $00000002;

// Constants for enum P2F_PROGRESS
type
  P2F_PROGRESS = TOleEnum;
const
  P2F_PROGRESS_START_PAGE = $00000000;
  P2F_PROGRESS_SEND_PAGE = $00000001;
  P2F_PROGRESS_COMPRESSING = $00000002;
  P2F_PROGRESS_RENDERING = $00000003;

// Constants for enum APPLICATIONTYPE
type
  APPLICATIONTYPE = TOleEnum;
const
  MSEXCEL = $00000001;
  MSWORD = $00000002;
  MSPOWERPOINT = $00000004;
  ACROBAT_PRO = $00000008;
  AUTOCAD = $00000010;
  MSOUTLOOK = $00000020;
  MSPROJECT = $00000040;
  ALL = $7FFFFFFF;
  ADOBEINDESIGN = $00000080;
  OPENOFFICEWRITER = $00000100;
  OPENOFFICECALC = $00000200;
  OPENOFFICEIMPRESS = $00000400;
  OPENOFFICEDRAW = $00000800;
  OPENOFFICEMATH = $00001000;
  MSWORDVIEWER = $00002000;
  MSEXCELVIEWER = $00004000;
  MSPOWERPOINTVIEWER = $00008000;

// Constants for enum OUTPUT_FORMAT
type
  OUTPUT_FORMAT = TOleEnum;
const
  SINGLEFILE = $00000001;
  SEPARATEFILEPERPAGENOTEMPLATE = $00000002;
  EXTVIEWER = $00000004;

// Constants for enum IMAGE_FORMAT
type
  IMAGE_FORMAT = TOleEnum;
const
  IMAGE_FORMAT_JPEG = $00000001;
  IMAGE_FORMAT_PNG = $00000002;

// Constants for enum IMGBEHAVIOR
type
  IMGBEHAVIOR = TOleEnum;
const
  IMGBEHAVIOR_STRETCH = $00000001;
  IMGBEHAVIOR_TILE = $00000002;

// Constants for enum TOOLBAR_IMAGE
type
  TOOLBAR_IMAGE = TOleEnum;
const
  IMGLOGO = $00000001;
  IMGDRAG = $00000002;
  IMGSELTEXT = $00000003;
  IMGZOOMRULER = $00000004;
  IMGZOOMFOCUSNADLE = $00000005;
  IMGZOOMNADLE = $00000006;
  IMGFITWIDTH = $00000007;
  IMGFITPAGE = $00000008;
  IMGPREVPAGE = $00000009;
  IMGNEXTPAGE = $0000000A;
  IMGSEARCHBUT = $0000000B;
  IMGROTATE = $0000000C;
  IMGPRINT = $0000000D;
  IMGNEWWIND = $0000000E;
  IMGHELP = $0000000F;
  IMGMORE = $00000010;
  IMGTOOLBARBGR = $00000011;
  IMGBACK = $00000012;
  IMGFORWARD = $00000013;
  IMGFULLSCREEN = $00000014;
  IMGEXITFULLSCREEN = $00000015;
  IMGLOGOHTML5 = $00000016;

// Constants for enum METADATAFORMAT
type
  METADATAFORMAT = TOleEnum;
const
  METADATAFORMAT_XML = $00000001;
  METADATAFORMAT_TXT = $00000002;

// Constants for enum TEMPLATETYPE
type
  TEMPLATETYPE = TOleEnum;
const
  TEMPLATE_ACTIONSCRIPT2 = $00000002;
  TEMPLATE_ACTIONSCRIPT3 = $00000003;
  TEMPLATE_CUSTOM = $00000001;

// Constants for enum WATERMARKANCHOR
type
  WATERMARKANCHOR = TOleEnum;
const
  CENTER = $00000000;
  LEFTCENTER = $00000001;
  RIGHTCENTER = $00000002;
  TOPCENTER = $00000010;
  BOTTOMCENTER = $00000020;
  LEFTTOP = $00000011;
  RIGHTTOP = $00000012;
  LEFTBOTTOM = $00000021;
  RIGHTBOTTOM = $00000022;

// Constants for enum COMPRESSION_METHOD
type
  COMPRESSION_METHOD = TOleEnum;
const
  COMPRESSION_METHOD_LZMA = $00000001;
  COMPRESSION_METHOD_ZLIB = $00000000;

// Constants for enum POWERPOINT_PRINTOUTPUT
type
  POWERPOINT_PRINTOUTPUT = TOleEnum;
const
  POWERPOINT_PRINTOUTPUT_AUTO = $00000000;
  POWERPOINT_PRINTOUTPUT_Slides = $00000001;
  POWERPOINT_PRINTOUTPUT_TwoSlideHandouts = $00000002;
  POWERPOINT_PRINTOUTPUT_ThreeSlideHandouts = $00000003;
  POWERPOINT_PRINTOUTPUT_SixSlideHandouts = $00000004;
  POWERPOINT_PRINTOUTPUT_NotesPages = $00000005;
  POWERPOINT_PRINTOUTPUT_Outline = $00000006;
  POWERPOINT_PRINTOUTPUT_BuildSlides = $00000007;
  POWERPOINT_PRINTOUTPUT_FourSlideHandouts = $00000008;
  POWERPOINT_PRINTOUTPUT_NineSlideHandouts = $00000009;
  POWERPOINT_PRINTOUTPUT_OneSlideHandouts = $0000000A;

// Constants for enum DOCUMENT_TYPE
type
  DOCUMENT_TYPE = TOleEnum;
const
  FLASH = $00000001;
  HTML5 = $00000002;

// Constants for enum BROWSER_TYPE
type
  BROWSER_TYPE = TOleEnum;
const
  INTERNET_EXPLORER = $00000001;
  FIREFOX = $00000002;
  CHROME = $00000004;
  OPERA = $00000008;
  SAFARI = $00000010;

// Constants for enum VIEW_MODE
type
  VIEW_MODE = TOleEnum;
const
  SINGLEPAGEVIEW = $00000001;
  MULTIPLEPAGEVIEW = $00000002;
  AUTOVIEW = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IProfile = interface;
  IProfileDisp = dispinterface;
  IBatchProcessingOptions = interface;
  IBatchProcessingOptionsDisp = dispinterface;
  IPrintingPreferences = interface;
  IPrintingPreferencesDisp = dispinterface;
  IServer = interface;
  IServerDisp = dispinterface;
  IP2FApp = interface;
  IP2FAppDisp = dispinterface;
  ISkinCollection = interface;
  ISkinCollectionDisp = dispinterface;
  IExcelOptions = interface;
  IExcelOptionsDisp = dispinterface;
  IPowerPointOptions = interface;
  IPowerPointOptionsDisp = dispinterface;
  ISkin = interface;
  ISkinDisp = dispinterface;
  IHTML5Options = interface;
  IHTML5OptionsDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  Server = IServer;
  Profile = IProfile;
  BatchProcessingOptions = IBatchProcessingOptions;
  PrintingPreferences = IPrintingPreferences;
  Server2 = IServer;
  Profile2 = IProfile;
  BatchProcessingOptions2 = IBatchProcessingOptions;
  PrintingPreferences2 = IPrintingPreferences;
  P2FApp = IP2FApp;
  SkinCollection = ISkinCollection;
  ExcelOptions = IExcelOptions;
  PowerPointOptions = IPowerPointOptions;
  Skin = ISkin;
  SkinCollection2 = ISkinCollection;
  ExcelOptions2 = IExcelOptions;
  PowerPointOptions2 = IPowerPointOptions;
  Skin2 = ISkin;
  HTML5Options = IHTML5Options;


// *********************************************************************//
// Interface: IProfile
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {85586141-D013-44D6-B771-090A201463C6}
// *********************************************************************//
  IProfile = interface(IDispatch)
    ['{85586141-D013-44D6-B771-090A201463C6}']
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_InterfaceOptions: Integer; safecall;
    procedure Set_InterfaceOptions(Value: Integer); safecall;
    function Get_ProtectionOptions: Integer; safecall;
    procedure Set_ProtectionOptions(Value: Integer); safecall;
    function Get_FlashVersion: OleVariant; safecall;
    procedure Set_FlashVersion(Value: OleVariant); safecall;
    function Get_UseJpeg: WordBool; safecall;
    procedure Set_UseJpeg(Value: WordBool); safecall;
    function Get_JpegQuality: Integer; safecall;
    procedure Set_JpegQuality(Value: Integer); safecall;
    procedure ApplyChanges; safecall;
    function Get_Language: WideString; safecall;
    procedure Set_Language(const Value: WideString); safecall;
    function Get_ColorAdjustment: WideString; safecall;
    procedure Set_ColorAdjustment(const Value: WideString); safecall;
    function Get_ThumbnailPageRange: WideString; safecall;
    procedure Set_ThumbnailPageRange(const Value: WideString); safecall;
    function Get_ThumbnailImageWidth: Integer; safecall;
    procedure Set_ThumbnailImageWidth(Value: Integer); safecall;
    function Get_ThumbnailImageHeight: Integer; safecall;
    procedure Set_ThumbnailImageHeight(Value: Integer); safecall;
    function Get_ThumbnailFormat: IMAGE_FORMAT; safecall;
    procedure Set_ThumbnailFormat(Value: IMAGE_FORMAT); safecall;
    function Get_ThumbnailJpegQuality: Integer; safecall;
    procedure Set_ThumbnailJpegQuality(Value: Integer); safecall;
    function Get_ThumbnailFileName: WideString; safecall;
    procedure Set_ThumbnailFileName(const Value: WideString); safecall;
    function Get_WatermarkImage: OleVariant; safecall;
    procedure Set_WatermarkImage(Value: OleVariant); safecall;
    function Get_WatermarkScale: Integer; safecall;
    procedure Set_WatermarkScale(Value: Integer); safecall;
    function Get_WatermarkTransparency: Integer; safecall;
    procedure Set_WatermarkTransparency(Value: Integer); safecall;
    function Get_Skin: OleVariant; safecall;
    procedure Set_Skin(Value: OleVariant); safecall;
    function Get_DocTemplate: OleVariant; safecall;
    procedure Set_DocTemplate(Value: OleVariant); safecall;
    function Get_DocTemplateASVersion: Integer; safecall;
    function Get_DocTemplateMaxTagID: Integer; safecall;
    function Get_DocTemplateFlashVersion: Integer; safecall;
    function Get_DocTemplateFrameCount: Integer; safecall;
    function Get_CreateMetadataFile: WordBool; safecall;
    procedure Set_CreateMetadataFile(Value: WordBool); safecall;
    function Get_MetadataFileName: WideString; safecall;
    procedure Set_MetadataFileName(const Value: WideString); safecall;
    function Get_MetaDataFileFormat: METADATAFORMAT; safecall;
    procedure Set_MetaDataFileFormat(Value: METADATAFORMAT); safecall;
    function Get_OutputFormat: OUTPUT_FORMAT; safecall;
    procedure Set_OutputFormat(Value: OUTPUT_FORMAT); safecall;
    function Get_OutputResolution: Integer; safecall;
    procedure Set_OutputResolution(Value: Integer); safecall;
    function Get_PageFileName: WideString; safecall;
    procedure Set_PageFileName(const Value: WideString); safecall;
    procedure SaveToFile(const FileName: WideString); safecall;
    procedure LoadFromFile(const FileName: WideString); safecall;
    function SaveToStr: WideString; safecall;
    function Get_RestrictionDomains: WideString; safecall;
    procedure Set_RestrictionDomains(const Value: WideString); safecall;
    function Get_ParseLinks: WordBool; safecall;
    procedure Set_ParseLinks(Value: WordBool); safecall;
    function Get_LinkTarget: WideString; safecall;
    procedure Set_LinkTarget(const Value: WideString); safecall;
    function Get_LinkTargetAuto: WordBool; safecall;
    procedure Set_LinkTargetAuto(Value: WordBool); safecall;
    function Get_ExtractLinks: Integer; safecall;
    procedure Set_ExtractLinks(Value: Integer); safecall;
    function Get_TemplateType: TEMPLATETYPE; safecall;
    procedure Set_TemplateType(Value: TEMPLATETYPE); safecall;
    function Get_ASVersion: Integer; safecall;
    procedure Set_ASVersion(Value: Integer); safecall;
    function Get_WatermarkAnchor: Integer; safecall;
    procedure Set_WatermarkAnchor(Value: Integer); safecall;
    function Get_WatermarkXOffset: WideString; safecall;
    procedure Set_WatermarkXOffset(const Value: WideString); safecall;
    function Get_WatermarkYOffset: WideString; safecall;
    procedure Set_WatermarkYOffset(const Value: WideString); safecall;
    function Get_CompressionMethod: COMPRESSION_METHOD; safecall;
    procedure Set_CompressionMethod(Value: COMPRESSION_METHOD); safecall;
    function Get_DocTemplateHeaderSize: SYSUINT; safecall;
    function Get_DocTemplateWidth: SYSUINT; safecall;
    function Get_DocTemplateHeight: SYSUINT; safecall;
    function Get_HTML5Options: IHTML5Options; safecall;
    function Get_DocumentType: DOCUMENT_TYPE; safecall;
    procedure Set_DocumentType(Value: DOCUMENT_TYPE); safecall;
    function Get_FrameWidth: Integer; safecall;
    procedure Set_FrameWidth(Value: Integer); safecall;
    function Get_FrameHeight: Integer; safecall;
    procedure Set_FrameHeight(Value: Integer); safecall;
    property Name: WideString read Get_Name write Set_Name;
    property InterfaceOptions: Integer read Get_InterfaceOptions write Set_InterfaceOptions;
    property ProtectionOptions: Integer read Get_ProtectionOptions write Set_ProtectionOptions;
    property FlashVersion: OleVariant read Get_FlashVersion write Set_FlashVersion;
    property UseJpeg: WordBool read Get_UseJpeg write Set_UseJpeg;
    property JpegQuality: Integer read Get_JpegQuality write Set_JpegQuality;
    property Language: WideString read Get_Language write Set_Language;
    property ColorAdjustment: WideString read Get_ColorAdjustment write Set_ColorAdjustment;
    property ThumbnailPageRange: WideString read Get_ThumbnailPageRange write Set_ThumbnailPageRange;
    property ThumbnailImageWidth: Integer read Get_ThumbnailImageWidth write Set_ThumbnailImageWidth;
    property ThumbnailImageHeight: Integer read Get_ThumbnailImageHeight write Set_ThumbnailImageHeight;
    property ThumbnailFormat: IMAGE_FORMAT read Get_ThumbnailFormat write Set_ThumbnailFormat;
    property ThumbnailJpegQuality: Integer read Get_ThumbnailJpegQuality write Set_ThumbnailJpegQuality;
    property ThumbnailFileName: WideString read Get_ThumbnailFileName write Set_ThumbnailFileName;
    property WatermarkImage: OleVariant read Get_WatermarkImage write Set_WatermarkImage;
    property WatermarkScale: Integer read Get_WatermarkScale write Set_WatermarkScale;
    property WatermarkTransparency: Integer read Get_WatermarkTransparency write Set_WatermarkTransparency;
    property Skin: OleVariant read Get_Skin write Set_Skin;
    property DocTemplate: OleVariant read Get_DocTemplate write Set_DocTemplate;
    property DocTemplateASVersion: Integer read Get_DocTemplateASVersion;
    property DocTemplateMaxTagID: Integer read Get_DocTemplateMaxTagID;
    property DocTemplateFlashVersion: Integer read Get_DocTemplateFlashVersion;
    property DocTemplateFrameCount: Integer read Get_DocTemplateFrameCount;
    property CreateMetadataFile: WordBool read Get_CreateMetadataFile write Set_CreateMetadataFile;
    property MetadataFileName: WideString read Get_MetadataFileName write Set_MetadataFileName;
    property MetaDataFileFormat: METADATAFORMAT read Get_MetaDataFileFormat write Set_MetaDataFileFormat;
    property OutputFormat: OUTPUT_FORMAT read Get_OutputFormat write Set_OutputFormat;
    property OutputResolution: Integer read Get_OutputResolution write Set_OutputResolution;
    property PageFileName: WideString read Get_PageFileName write Set_PageFileName;
    property RestrictionDomains: WideString read Get_RestrictionDomains write Set_RestrictionDomains;
    property ParseLinks: WordBool read Get_ParseLinks write Set_ParseLinks;
    property LinkTarget: WideString read Get_LinkTarget write Set_LinkTarget;
    property LinkTargetAuto: WordBool read Get_LinkTargetAuto write Set_LinkTargetAuto;
    property ExtractLinks: Integer read Get_ExtractLinks write Set_ExtractLinks;
    property TemplateType: TEMPLATETYPE read Get_TemplateType write Set_TemplateType;
    property ASVersion: Integer read Get_ASVersion write Set_ASVersion;
    property WatermarkAnchor: Integer read Get_WatermarkAnchor write Set_WatermarkAnchor;
    property WatermarkXOffset: WideString read Get_WatermarkXOffset write Set_WatermarkXOffset;
    property WatermarkYOffset: WideString read Get_WatermarkYOffset write Set_WatermarkYOffset;
    property CompressionMethod: COMPRESSION_METHOD read Get_CompressionMethod write Set_CompressionMethod;
    property DocTemplateHeaderSize: SYSUINT read Get_DocTemplateHeaderSize;
    property DocTemplateWidth: SYSUINT read Get_DocTemplateWidth;
    property DocTemplateHeight: SYSUINT read Get_DocTemplateHeight;
    property HTML5Options: IHTML5Options read Get_HTML5Options;
    property DocumentType: DOCUMENT_TYPE read Get_DocumentType write Set_DocumentType;
    property FrameWidth: Integer read Get_FrameWidth write Set_FrameWidth;
    property FrameHeight: Integer read Get_FrameHeight write Set_FrameHeight;
  end;

// *********************************************************************//
// DispIntf:  IProfileDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {85586141-D013-44D6-B771-090A201463C6}
// *********************************************************************//
  IProfileDisp = dispinterface
    ['{85586141-D013-44D6-B771-090A201463C6}']
    property Name: WideString dispid 201;
    property InterfaceOptions: Integer dispid 202;
    property ProtectionOptions: Integer dispid 203;
    property FlashVersion: OleVariant dispid 204;
    property UseJpeg: WordBool dispid 205;
    property JpegQuality: Integer dispid 206;
    procedure ApplyChanges; dispid 207;
    property Language: WideString dispid 208;
    property ColorAdjustment: WideString dispid 209;
    property ThumbnailPageRange: WideString dispid 210;
    property ThumbnailImageWidth: Integer dispid 211;
    property ThumbnailImageHeight: Integer dispid 212;
    property ThumbnailFormat: IMAGE_FORMAT dispid 213;
    property ThumbnailJpegQuality: Integer dispid 214;
    property ThumbnailFileName: WideString dispid 215;
    property WatermarkImage: OleVariant dispid 219;
    property WatermarkScale: Integer dispid 220;
    property WatermarkTransparency: Integer dispid 221;
    property Skin: OleVariant dispid 222;
    property DocTemplate: OleVariant dispid 223;
    property DocTemplateASVersion: Integer readonly dispid 224;
    property DocTemplateMaxTagID: Integer readonly dispid 226;
    property DocTemplateFlashVersion: Integer readonly dispid 227;
    property DocTemplateFrameCount: Integer readonly dispid 228;
    property CreateMetadataFile: WordBool dispid 229;
    property MetadataFileName: WideString dispid 230;
    property MetaDataFileFormat: METADATAFORMAT dispid 231;
    property OutputFormat: OUTPUT_FORMAT dispid 232;
    property OutputResolution: Integer dispid 233;
    property PageFileName: WideString dispid 234;
    procedure SaveToFile(const FileName: WideString); dispid 256;
    procedure LoadFromFile(const FileName: WideString); dispid 257;
    function SaveToStr: WideString; dispid 258;
    property RestrictionDomains: WideString dispid 216;
    property ParseLinks: WordBool dispid 217;
    property LinkTarget: WideString dispid 218;
    property LinkTargetAuto: WordBool dispid 225;
    property ExtractLinks: Integer dispid 235;
    property TemplateType: TEMPLATETYPE dispid 236;
    property ASVersion: Integer dispid 237;
    property WatermarkAnchor: Integer dispid 238;
    property WatermarkXOffset: WideString dispid 239;
    property WatermarkYOffset: WideString dispid 240;
    property CompressionMethod: COMPRESSION_METHOD dispid 241;
    property DocTemplateHeaderSize: SYSUINT readonly dispid 242;
    property DocTemplateWidth: SYSUINT readonly dispid 243;
    property DocTemplateHeight: SYSUINT readonly dispid 244;
    property HTML5Options: IHTML5Options readonly dispid 247;
    property DocumentType: DOCUMENT_TYPE dispid 248;
    property FrameWidth: Integer dispid 245;
    property FrameHeight: Integer dispid 246;
  end;

// *********************************************************************//
// Interface: IBatchProcessingOptions
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B5D31A0C-B37A-45B0-B855-52E9A8319839}
// *********************************************************************//
  IBatchProcessingOptions = interface(IDispatch)
    ['{B5D31A0C-B37A-45B0-B855-52E9A8319839}']
    function Get_BeforePrintingTimeout: Integer; safecall;
    procedure Set_BeforePrintingTimeout(Value: Integer); safecall;
    function Get_PrintingTimeout: Integer; safecall;
    procedure Set_PrintingTimeout(Value: Integer); safecall;
    function Get_AfterPrintingTimeout: Integer; safecall;
    procedure Set_AfterPrintingTimeout(Value: Integer); safecall;
    function Get_PressPrintButton: ThreeStateFlag; safecall;
    procedure Set_PressPrintButton(Value: ThreeStateFlag); safecall;
    function Get_KillProcessIfTimeout: ThreeStateFlag; safecall;
    procedure Set_KillProcessIfTimeout(Value: ThreeStateFlag); safecall;
    function Get_CreateLogFile: WordBool; safecall;
    procedure Set_CreateLogFile(Value: WordBool); safecall;
    function Get_LogFileName: WideString; safecall;
    procedure Set_LogFileName(const Value: WideString); safecall;
    procedure ApplyChanges; safecall;
    function Get_LoggingLevel: Integer; safecall;
    procedure Set_LoggingLevel(Value: Integer); safecall;
    function Get_PageRange: WideString; safecall;
    procedure Set_PageRange(const Value: WideString); safecall;
    function Get_ActivityTimeout: Integer; safecall;
    procedure Set_ActivityTimeout(Value: Integer); safecall;
    function Get_UseAutomation: Integer; safecall;
    procedure Set_UseAutomation(Value: Integer); safecall;
    function Get_KillAllAutomationProcesses: APPLICATIONTYPE; safecall;
    procedure Set_KillAllAutomationProcesses(Value: APPLICATIONTYPE); safecall;
    function Get_KeepAutomationAppRef: APPLICATIONTYPE; safecall;
    procedure Set_KeepAutomationAppRef(Value: APPLICATIONTYPE); safecall;
    function Get_ExcelOptions: IExcelOptions; safecall;
    function Get_PowerPointOptions: IPowerPointOptions; safecall;
    function Get_ExtractLinks: Integer; safecall;
    procedure Set_ExtractLinks(Value: Integer); safecall;
    procedure Assign_(const bpo: IBatchProcessingOptions); safecall;
    function Get_KillSplWOW64: ThreeStateFlag; safecall;
    procedure Set_KillSplWOW64(Value: ThreeStateFlag); safecall;
    function Get_GenerateExternalViewer: WordBool; safecall;
    procedure Set_GenerateExternalViewer(Value: WordBool); safecall;
    function Get_SpecialProcessing: WideString; safecall;
    procedure Set_SpecialProcessing(const Value: WideString); safecall;
    function Get_KeepAutoAppRefStr: WideString; safecall;
    procedure Set_KeepAutoAppRefStr(const Value: WideString); safecall;
    function Get_CheckPDFEncryption: ThreeStateFlag; safecall;
    procedure Set_CheckPDFEncryption(Value: ThreeStateFlag); safecall;
    function Get_KillAutoProcessBeforeConversion: APPLICATIONTYPE; safecall;
    procedure Set_KillAutoProcessBeforeConversion(Value: APPLICATIONTYPE); safecall;
    function Get_AccProvider: WideString; safecall;
    procedure Set_AccProvider(const Value: WideString); safecall;
    property BeforePrintingTimeout: Integer read Get_BeforePrintingTimeout write Set_BeforePrintingTimeout;
    property PrintingTimeout: Integer read Get_PrintingTimeout write Set_PrintingTimeout;
    property AfterPrintingTimeout: Integer read Get_AfterPrintingTimeout write Set_AfterPrintingTimeout;
    property PressPrintButton: ThreeStateFlag read Get_PressPrintButton write Set_PressPrintButton;
    property KillProcessIfTimeout: ThreeStateFlag read Get_KillProcessIfTimeout write Set_KillProcessIfTimeout;
    property CreateLogFile: WordBool read Get_CreateLogFile write Set_CreateLogFile;
    property LogFileName: WideString read Get_LogFileName write Set_LogFileName;
    property LoggingLevel: Integer read Get_LoggingLevel write Set_LoggingLevel;
    property PageRange: WideString read Get_PageRange write Set_PageRange;
    property ActivityTimeout: Integer read Get_ActivityTimeout write Set_ActivityTimeout;
    property UseAutomation: Integer read Get_UseAutomation write Set_UseAutomation;
    property KillAllAutomationProcesses: APPLICATIONTYPE read Get_KillAllAutomationProcesses write Set_KillAllAutomationProcesses;
    property KeepAutomationAppRef: APPLICATIONTYPE read Get_KeepAutomationAppRef write Set_KeepAutomationAppRef;
    property ExcelOptions: IExcelOptions read Get_ExcelOptions;
    property PowerPointOptions: IPowerPointOptions read Get_PowerPointOptions;
    property ExtractLinks: Integer read Get_ExtractLinks write Set_ExtractLinks;
    property KillSplWOW64: ThreeStateFlag read Get_KillSplWOW64 write Set_KillSplWOW64;
    property GenerateExternalViewer: WordBool read Get_GenerateExternalViewer write Set_GenerateExternalViewer;
    property SpecialProcessing: WideString read Get_SpecialProcessing write Set_SpecialProcessing;
    property KeepAutoAppRefStr: WideString read Get_KeepAutoAppRefStr write Set_KeepAutoAppRefStr;
    property CheckPDFEncryption: ThreeStateFlag read Get_CheckPDFEncryption write Set_CheckPDFEncryption;
    property KillAutoProcessBeforeConversion: APPLICATIONTYPE read Get_KillAutoProcessBeforeConversion write Set_KillAutoProcessBeforeConversion;
    property AccProvider: WideString read Get_AccProvider write Set_AccProvider;
  end;

// *********************************************************************//
// DispIntf:  IBatchProcessingOptionsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B5D31A0C-B37A-45B0-B855-52E9A8319839}
// *********************************************************************//
  IBatchProcessingOptionsDisp = dispinterface
    ['{B5D31A0C-B37A-45B0-B855-52E9A8319839}']
    property BeforePrintingTimeout: Integer dispid 201;
    property PrintingTimeout: Integer dispid 202;
    property AfterPrintingTimeout: Integer dispid 203;
    property PressPrintButton: ThreeStateFlag dispid 204;
    property KillProcessIfTimeout: ThreeStateFlag dispid 205;
    property CreateLogFile: WordBool dispid 206;
    property LogFileName: WideString dispid 207;
    procedure ApplyChanges; dispid 208;
    property LoggingLevel: Integer dispid 209;
    property PageRange: WideString dispid 210;
    property ActivityTimeout: Integer dispid 211;
    property UseAutomation: Integer dispid 212;
    property KillAllAutomationProcesses: APPLICATIONTYPE dispid 213;
    property KeepAutomationAppRef: APPLICATIONTYPE dispid 214;
    property ExcelOptions: IExcelOptions readonly dispid 215;
    property PowerPointOptions: IPowerPointOptions readonly dispid 216;
    property ExtractLinks: Integer dispid 217;
    procedure Assign_(const bpo: IBatchProcessingOptions); dispid 218;
    property KillSplWOW64: ThreeStateFlag dispid 219;
    property GenerateExternalViewer: WordBool dispid 220;
    property SpecialProcessing: WideString dispid 221;
    property KeepAutoAppRefStr: WideString dispid 222;
    property CheckPDFEncryption: ThreeStateFlag dispid 223;
    property KillAutoProcessBeforeConversion: APPLICATIONTYPE dispid 224;
    property AccProvider: WideString dispid 225;
  end;

// *********************************************************************//
// Interface: IPrintingPreferences
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C6556430-49E6-4E5E-913D-5B0A2A973B95}
// *********************************************************************//
  IPrintingPreferences = interface(IDispatch)
    ['{C6556430-49E6-4E5E-913D-5B0A2A973B95}']
    function Get_FormName: WideString; safecall;
    function Get_PaperWidth: Integer; safecall;
    function Get_PaperLength: Integer; safecall;
    function Get_Resolution: Integer; safecall;
    procedure Set_Resolution(Value: Integer); safecall;
    function Get_Orientation: PAPER_ORIENTATION; safecall;
    procedure Set_Orientation(Value: PAPER_ORIENTATION); safecall;
    procedure SetFormName(const sFormName: WideString); safecall;
    procedure SetCustomPaperSize(Width: Integer; Length: Integer); safecall;
    procedure ApplyChanges; safecall;
    function Get_Actual: WordBool; safecall;
    property FormName: WideString read Get_FormName;
    property PaperWidth: Integer read Get_PaperWidth;
    property PaperLength: Integer read Get_PaperLength;
    property Resolution: Integer read Get_Resolution write Set_Resolution;
    property Orientation: PAPER_ORIENTATION read Get_Orientation write Set_Orientation;
    property Actual: WordBool read Get_Actual;
  end;

// *********************************************************************//
// DispIntf:  IPrintingPreferencesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C6556430-49E6-4E5E-913D-5B0A2A973B95}
// *********************************************************************//
  IPrintingPreferencesDisp = dispinterface
    ['{C6556430-49E6-4E5E-913D-5B0A2A973B95}']
    property FormName: WideString readonly dispid 201;
    property PaperWidth: Integer readonly dispid 202;
    property PaperLength: Integer readonly dispid 203;
    property Resolution: Integer dispid 204;
    property Orientation: PAPER_ORIENTATION dispid 205;
    procedure SetFormName(const sFormName: WideString); dispid 206;
    procedure SetCustomPaperSize(Width: Integer; Length: Integer); dispid 207;
    procedure ApplyChanges; dispid 208;
    property Actual: WordBool readonly dispid 209;
  end;

// *********************************************************************//
// Interface: IServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B6FF280B-7540-45B4-B527-44945D9D2234}
// *********************************************************************//
  IServer = interface(IDispatch)
    ['{B6FF280B-7540-45B4-B527-44945D9D2234}']
    function Get_Version: WideString; safecall;
    procedure ConvertFile(const SourceFileName: WideString; const OutputFileName: WideString;
                          Profile: OleVariant; BatchProcessingOptions: OleVariant;
                          PrintingPreferences: OleVariant); safecall;
    function Get_DefaultProfile: IProfile; safecall;
    function Get_DefaultBatchProcessingOptions: IBatchProcessingOptions; safecall;
    function Get_DefaultPrintingPreferences: IPrintingPreferences; safecall;
    procedure ConvertDir(const SourceDirName: WideString; const SourceFileMask: WideString;
                         const OutputDirName: WideString; bIncludeSubDirs: OleVariant;
                         Profile: OleVariant; BatchProcessingOptions: OleVariant;
                         PrintingPreferences: OleVariant); safecall;
    function Get_FilesConverted: Integer; safecall;
    function Get_DirsScanned: Integer; safecall;
    function Get_ErrorCount: Integer; safecall;
    function Get_Skins: ISkinCollection; safecall;
    function Get_ConvertedPages: Integer; safecall;
    function Get_TotalPages: Integer; safecall;
    function Get_FlashFileCount: Integer; safecall;
    function Get_ThumbnailFileCount: Integer; safecall;
    function Get_MetadataFileCount: Integer; safecall;
    procedure StartJob(const outputFileName: WideString; Profile: OleVariant;
                       BatchProcessingOptions: OleVariant; PrintingPreferences: OleVariant); safecall;
    procedure EndJob; safecall;
    procedure CancelJob; safecall;
    function Get_SkippedPages: Integer; safecall;
    procedure SetP2FPrinterAsDefault; safecall;
    function Get_SVGFileCount: Integer; safecall;
    property Version: WideString read Get_Version;
    property DefaultProfile: IProfile read Get_DefaultProfile;
    property DefaultBatchProcessingOptions: IBatchProcessingOptions read Get_DefaultBatchProcessingOptions;
    property DefaultPrintingPreferences: IPrintingPreferences read Get_DefaultPrintingPreferences;
    property FilesConverted: Integer read Get_FilesConverted;
    property DirsScanned: Integer read Get_DirsScanned;
    property ErrorCount: Integer read Get_ErrorCount;
    property Skins: ISkinCollection read Get_Skins;
    property ConvertedPages: Integer read Get_ConvertedPages;
    property TotalPages: Integer read Get_TotalPages;
    property FlashFileCount: Integer read Get_FlashFileCount;
    property ThumbnailFileCount: Integer read Get_ThumbnailFileCount;
    property MetadataFileCount: Integer read Get_MetadataFileCount;
    property SkippedPages: Integer read Get_SkippedPages;
    property SVGFileCount: Integer read Get_SVGFileCount;
  end;

// *********************************************************************//
// DispIntf:  IServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B6FF280B-7540-45B4-B527-44945D9D2234}
// *********************************************************************//
  IServerDisp = dispinterface
    ['{B6FF280B-7540-45B4-B527-44945D9D2234}']
    property Version: WideString readonly dispid 201;
    procedure ConvertFile(const SourceFileName: WideString; const OutputFileName: WideString;
                          Profile: OleVariant; BatchProcessingOptions: OleVariant;
                          PrintingPreferences: OleVariant); dispid 205;
    property DefaultProfile: IProfile readonly dispid 202;
    property DefaultBatchProcessingOptions: IBatchProcessingOptions readonly dispid 203;
    property DefaultPrintingPreferences: IPrintingPreferences readonly dispid 204;
    procedure ConvertDir(const SourceDirName: WideString; const SourceFileMask: WideString;
                         const OutputDirName: WideString; bIncludeSubDirs: OleVariant;
                         Profile: OleVariant; BatchProcessingOptions: OleVariant;
                         PrintingPreferences: OleVariant); dispid 206;
    property FilesConverted: Integer readonly dispid 207;
    property DirsScanned: Integer readonly dispid 208;
    property ErrorCount: Integer readonly dispid 209;
    property Skins: ISkinCollection readonly dispid 210;
    property ConvertedPages: Integer readonly dispid 211;
    property TotalPages: Integer readonly dispid 212;
    property FlashFileCount: Integer readonly dispid 213;
    property ThumbnailFileCount: Integer readonly dispid 214;
    property MetadataFileCount: Integer readonly dispid 215;
    procedure StartJob(const outputFileName: WideString; Profile: OleVariant;
                       BatchProcessingOptions: OleVariant; PrintingPreferences: OleVariant); dispid 216;
    procedure EndJob; dispid 217;
    procedure CancelJob; dispid 218;
    property SkippedPages: Integer readonly dispid 219;
    procedure SetP2FPrinterAsDefault; dispid 220;
    property SVGFileCount: Integer readonly dispid 221;
  end;

// *********************************************************************//
// Interface: IP2FApp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CC994315-F509-407E-BF86-ACB391428640}
// *********************************************************************//
  IP2FApp = interface(IDispatch)
    ['{CC994315-F509-407E-BF86-ACB391428640}']
    function StartDoc(const DocName: WideString; JobID: Integer): WordBool; stdcall;
    function OnProgress(PageNumber: Integer; TotalPages: Integer; Flag: P2F_PROGRESS): WordBool; stdcall;
    function EndDoc(bCancelled: Integer; const szDocName: WideString): WordBool; stdcall;
    function ShowDialog: WordBool; stdcall;
    function GetProfileStr: WideString; safecall;
    function GetSkinStr: WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IP2FAppDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CC994315-F509-407E-BF86-ACB391428640}
// *********************************************************************//
  IP2FAppDisp = dispinterface
    ['{CC994315-F509-407E-BF86-ACB391428640}']
    function StartDoc(const DocName: WideString; JobID: Integer): WordBool; dispid 101;
    function OnProgress(PageNumber: Integer; TotalPages: Integer; Flag: P2F_PROGRESS): WordBool; dispid 102;
    function EndDoc(bCancelled: Integer; const szDocName: WideString): WordBool; dispid 103;
    function ShowDialog: WordBool; dispid 104;
    function GetProfileStr: WideString; dispid 201;
    function GetSkinStr: WideString; dispid 202;
  end;

// *********************************************************************//
// Interface: ISkinCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {44B39C5D-9B7A-4715-8052-ED653D36F1BA}
// *********************************************************************//
  ISkinCollection = interface(IDispatch)
    ['{44B39C5D-9B7A-4715-8052-ED653D36F1BA}']
    function Get_item(Index: OleVariant): OleVariant; safecall;
    function Get__newEnum: IEnumVARIANT; safecall;
    function Add(const Name: WideString): ISkin; safecall;
    procedure Delete(index: OleVariant); safecall;
    function Get_Count: Integer; safecall;
    procedure RenameSkin(const skin: ISkin; const NewName: WideString); safecall;
    property item[Index: OleVariant]: OleVariant read Get_item; default;
    property _newEnum: IEnumVARIANT read Get__newEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ISkinCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {44B39C5D-9B7A-4715-8052-ED653D36F1BA}
// *********************************************************************//
  ISkinCollectionDisp = dispinterface
    ['{44B39C5D-9B7A-4715-8052-ED653D36F1BA}']
    property item[Index: OleVariant]: OleVariant readonly dispid 0; default;
    property _newEnum: IEnumVARIANT readonly dispid -4;
    function Add(const Name: WideString): ISkin; dispid 203;
    procedure Delete(index: OleVariant); dispid 204;
    property Count: Integer readonly dispid 205;
    procedure RenameSkin(const skin: ISkin; const NewName: WideString); dispid 201;
  end;

// *********************************************************************//
// Interface: IExcelOptions
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {76F313A0-D328-44CE-B680-31896F2CC56E}
// *********************************************************************//
  IExcelOptions = interface(IDispatch)
    ['{76F313A0-D328-44CE-B680-31896F2CC56E}']
    function Get_SheetRange: WideString; safecall;
    procedure Set_SheetRange(const Value: WideString); safecall;
    function Get_OverridePrintQuality: WordBool; safecall;
    procedure Set_OverridePrintQuality(Value: WordBool); safecall;
    function Get_SkipEmptySheets: WordBool; safecall;
    procedure Set_SkipEmptySheets(Value: WordBool); safecall;
    property SheetRange: WideString read Get_SheetRange write Set_SheetRange;
    property OverridePrintQuality: WordBool read Get_OverridePrintQuality write Set_OverridePrintQuality;
    property SkipEmptySheets: WordBool read Get_SkipEmptySheets write Set_SkipEmptySheets;
  end;

// *********************************************************************//
// DispIntf:  IExcelOptionsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {76F313A0-D328-44CE-B680-31896F2CC56E}
// *********************************************************************//
  IExcelOptionsDisp = dispinterface
    ['{76F313A0-D328-44CE-B680-31896F2CC56E}']
    property SheetRange: WideString dispid 201;
    property OverridePrintQuality: WordBool dispid 202;
    property SkipEmptySheets: WordBool dispid 203;
  end;

// *********************************************************************//
// Interface: IPowerPointOptions
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7A3E353C-B57D-42CF-BE25-400444E85A6B}
// *********************************************************************//
  IPowerPointOptions = interface(IDispatch)
    ['{7A3E353C-B57D-42CF-BE25-400444E85A6B}']
    function Get_FitToPage: OleVariant; safecall;
    procedure Set_FitToPage(Value: OleVariant); safecall;
    function Get_PrintHiddenSlides: ThreeStateFlag; safecall;
    procedure Set_PrintHiddenSlides(Value: ThreeStateFlag); safecall;
    function Get_OutputType: OleVariant; safecall;
    procedure Set_OutputType(Value: OleVariant); safecall;
    function Get_FrameSlides: OleVariant; safecall;
    procedure Set_FrameSlides(Value: OleVariant); safecall;
    property FitToPage: OleVariant read Get_FitToPage write Set_FitToPage;
    property PrintHiddenSlides: ThreeStateFlag read Get_PrintHiddenSlides write Set_PrintHiddenSlides;
    property OutputType: OleVariant read Get_OutputType write Set_OutputType;
    property FrameSlides: OleVariant read Get_FrameSlides write Set_FrameSlides;
  end;

// *********************************************************************//
// DispIntf:  IPowerPointOptionsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7A3E353C-B57D-42CF-BE25-400444E85A6B}
// *********************************************************************//
  IPowerPointOptionsDisp = dispinterface
    ['{7A3E353C-B57D-42CF-BE25-400444E85A6B}']
    property FitToPage: OleVariant dispid 201;
    property PrintHiddenSlides: ThreeStateFlag dispid 202;
    property OutputType: OleVariant dispid 203;
    property FrameSlides: OleVariant dispid 204;
  end;

// *********************************************************************//
// Interface: ISkin
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7C0BBF6C-4E9F-438F-A4FE-92BB705EE1A1}
// *********************************************************************//
  ISkin = interface(IDispatch)
    ['{7C0BBF6C-4E9F-438F-A4FE-92BB705EE1A1}']
    function Get_Name: WideString; safecall;
    function Get_ToolbarBgrColor: Integer; safecall;
    procedure Set_ToolbarBgrColor(Value: Integer); safecall;
    function Get_OverButColor: Integer; safecall;
    procedure Set_OverButColor(Value: Integer); safecall;
    function Get_OverRectColor: Integer; safecall;
    procedure Set_OverRectColor(Value: Integer); safecall;
    function Get_DownButColor: Integer; safecall;
    procedure Set_DownButColor(Value: Integer); safecall;
    function Get_DownRectColor: Integer; safecall;
    procedure Set_DownRectColor(Value: Integer); safecall;
    function Get_DocBgrColor: Integer; safecall;
    procedure Set_DocBgrColor(Value: Integer); safecall;
    function Get_ScrollBarColor: Integer; safecall;
    procedure Set_ScrollBarColor(Value: Integer); safecall;
    function Get_ColorAdjustment: WideString; safecall;
    procedure Set_ColorAdjustment(const Value: WideString); safecall;
    function Get_ZoomHandleOffset: Integer; safecall;
    procedure Set_ZoomHandleOffset(Value: Integer); safecall;
    function Get_LogoURL: WideString; safecall;
    procedure Set_LogoURL(const Value: WideString); safecall;
    function Get_HelpButtonURL: WideString; safecall;
    procedure Set_HelpButtonURL(const Value: WideString); safecall;
    function Get_TBBgrImgBehavior: IMGBEHAVIOR; safecall;
    procedure Set_TBBgrImgBehavior(Value: IMGBEHAVIOR); safecall;
    procedure SetToolbarImage(Img: TOOLBAR_IMAGE; sFileName: OleVariant); safecall;
    function GetToolbarImage(Image: TOOLBAR_IMAGE): OleVariant; safecall;
    procedure ApplyChanges; safecall;
    procedure LoadFromFile(const FileName: WideString); safecall;
    procedure SaveToFile(const FileName: WideString); safecall;
    function Get_FileName: WideString; safecall;
    function Get_ID: TGUID; safecall;
    function SaveToStr: WideString; safecall;
    procedure Assign_(const _skin: ISkin); safecall;
    function Get_btnColorAdj: WordBool; safecall;
    procedure Set_btnColorAdj(Value: WordBool); safecall;
    function Get_TextHighlightColor: Integer; safecall;
    procedure Set_TextHighlightColor(Value: Integer); safecall;
    property Name: WideString read Get_Name;
    property ToolbarBgrColor: Integer read Get_ToolbarBgrColor write Set_ToolbarBgrColor;
    property OverButColor: Integer read Get_OverButColor write Set_OverButColor;
    property OverRectColor: Integer read Get_OverRectColor write Set_OverRectColor;
    property DownButColor: Integer read Get_DownButColor write Set_DownButColor;
    property DownRectColor: Integer read Get_DownRectColor write Set_DownRectColor;
    property DocBgrColor: Integer read Get_DocBgrColor write Set_DocBgrColor;
    property ScrollBarColor: Integer read Get_ScrollBarColor write Set_ScrollBarColor;
    property ColorAdjustment: WideString read Get_ColorAdjustment write Set_ColorAdjustment;
    property ZoomHandleOffset: Integer read Get_ZoomHandleOffset write Set_ZoomHandleOffset;
    property LogoURL: WideString read Get_LogoURL write Set_LogoURL;
    property HelpButtonURL: WideString read Get_HelpButtonURL write Set_HelpButtonURL;
    property TBBgrImgBehavior: IMGBEHAVIOR read Get_TBBgrImgBehavior write Set_TBBgrImgBehavior;
    property FileName: WideString read Get_FileName;
    property ID: TGUID read Get_ID;
    property btnColorAdj: WordBool read Get_btnColorAdj write Set_btnColorAdj;
    property TextHighlightColor: Integer read Get_TextHighlightColor write Set_TextHighlightColor;
  end;

// *********************************************************************//
// DispIntf:  ISkinDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7C0BBF6C-4E9F-438F-A4FE-92BB705EE1A1}
// *********************************************************************//
  ISkinDisp = dispinterface
    ['{7C0BBF6C-4E9F-438F-A4FE-92BB705EE1A1}']
    property Name: WideString readonly dispid 201;
    property ToolbarBgrColor: Integer dispid 202;
    property OverButColor: Integer dispid 203;
    property OverRectColor: Integer dispid 204;
    property DownButColor: Integer dispid 205;
    property DownRectColor: Integer dispid 206;
    property DocBgrColor: Integer dispid 207;
    property ScrollBarColor: Integer dispid 208;
    property ColorAdjustment: WideString dispid 209;
    property ZoomHandleOffset: Integer dispid 210;
    property LogoURL: WideString dispid 211;
    property HelpButtonURL: WideString dispid 212;
    property TBBgrImgBehavior: IMGBEHAVIOR dispid 213;
    procedure SetToolbarImage(Img: TOOLBAR_IMAGE; sFileName: OleVariant); dispid 214;
    function GetToolbarImage(Image: TOOLBAR_IMAGE): OleVariant; dispid 215;
    procedure ApplyChanges; dispid 216;
    procedure LoadFromFile(const FileName: WideString); dispid 217;
    procedure SaveToFile(const FileName: WideString); dispid 218;
    property FileName: WideString readonly dispid 219;
    property ID: {NOT_OLEAUTO(TGUID)}OleVariant readonly dispid 220;
    function SaveToStr: WideString; dispid 222;
    procedure Assign_(const _skin: ISkin); dispid 221;
    property btnColorAdj: WordBool dispid 223;
    property TextHighlightColor: Integer dispid 224;
  end;

// *********************************************************************//
// Interface: IHTML5Options
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {00BDBB8E-1669-432C-AB0E-75F323118129}
// *********************************************************************//
  IHTML5Options = interface(IDispatch)
    ['{00BDBB8E-1669-432C-AB0E-75F323118129}']
    function Get_Compression: WordBool; safecall;
    procedure Set_Compression(Value: WordBool); safecall;
    function Get_Compatibility: BROWSER_TYPE; safecall;
    procedure Set_Compatibility(Value: BROWSER_TYPE); safecall;
    function Get_VersionIE: WideString; safecall;
    procedure Set_VersionIE(const Value: WideString); safecall;
    function Get_VersionFireFox: WideString; safecall;
    procedure Set_VersionFireFox(const Value: WideString); safecall;
    function Get_VersionSafari: WideString; safecall;
    procedure Set_VersionSafari(const Value: WideString); safecall;
    function Get_VersionChrome: WideString; safecall;
    procedure Set_VersionChrome(const Value: WideString); safecall;
    function Get_VersionOpera: WideString; safecall;
    procedure Set_VersionOpera(const Value: WideString); safecall;
    function Get_ViewMode: VIEW_MODE; safecall;
    procedure Set_ViewMode(Value: VIEW_MODE); safecall;
    function Get_SinglePageModeThreshold: Integer; safecall;
    procedure Set_SinglePageModeThreshold(Value: Integer); safecall;
    function Get_DocTemplate: OleVariant; safecall;
    procedure Set_DocTemplate(Value: OleVariant); safecall;
    function Get_EmbedResources: WordBool; safecall;
    procedure Set_EmbedResources(Value: WordBool); safecall;
    function Get_SubsetFonts: WordBool; safecall;
    procedure Set_SubsetFonts(Value: WordBool); safecall;
    property Compression: WordBool read Get_Compression write Set_Compression;
    property Compatibility: BROWSER_TYPE read Get_Compatibility write Set_Compatibility;
    property VersionIE: WideString read Get_VersionIE write Set_VersionIE;
    property VersionFireFox: WideString read Get_VersionFireFox write Set_VersionFireFox;
    property VersionSafari: WideString read Get_VersionSafari write Set_VersionSafari;
    property VersionChrome: WideString read Get_VersionChrome write Set_VersionChrome;
    property VersionOpera: WideString read Get_VersionOpera write Set_VersionOpera;
    property ViewMode: VIEW_MODE read Get_ViewMode write Set_ViewMode;
    property SinglePageModeThreshold: Integer read Get_SinglePageModeThreshold write Set_SinglePageModeThreshold;
    property DocTemplate: OleVariant read Get_DocTemplate write Set_DocTemplate;
    property EmbedResources: WordBool read Get_EmbedResources write Set_EmbedResources;
    property SubsetFonts: WordBool read Get_SubsetFonts write Set_SubsetFonts;
  end;

// *********************************************************************//
// DispIntf:  IHTML5OptionsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {00BDBB8E-1669-432C-AB0E-75F323118129}
// *********************************************************************//
  IHTML5OptionsDisp = dispinterface
    ['{00BDBB8E-1669-432C-AB0E-75F323118129}']
    property Compression: WordBool dispid 201;
    property Compatibility: BROWSER_TYPE dispid 202;
    property VersionIE: WideString dispid 203;
    property VersionFireFox: WideString dispid 204;
    property VersionSafari: WideString dispid 205;
    property VersionChrome: WideString dispid 206;
    property VersionOpera: WideString dispid 207;
    property ViewMode: VIEW_MODE dispid 208;
    property SinglePageModeThreshold: Integer dispid 209;
    property DocTemplate: OleVariant dispid 210;
    property EmbedResources: WordBool dispid 211;
    property SubsetFonts: WordBool dispid 212;
  end;

// *********************************************************************//
// The Class CoServer provides a Create and CreateRemote method to
// create instances of the default interface IServer exposed by
// the CoClass Server. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoServer = class
    class function Create: IServer;
    class function CreateRemote(const MachineName: string): IServer;
  end;

// *********************************************************************//
// The Class CoProfile provides a Create and CreateRemote method to
// create instances of the default interface IProfile exposed by
// the CoClass Profile. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoProfile = class
    class function Create: IProfile;
    class function CreateRemote(const MachineName: string): IProfile;
  end;

// *********************************************************************//
// The Class CoBatchProcessingOptions provides a Create and CreateRemote method to
// create instances of the default interface IBatchProcessingOptions exposed by
// the CoClass BatchProcessingOptions. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBatchProcessingOptions = class
    class function Create: IBatchProcessingOptions;
    class function CreateRemote(const MachineName: string): IBatchProcessingOptions;
  end;

// *********************************************************************//
// The Class CoPrintingPreferences provides a Create and CreateRemote method to
// create instances of the default interface IPrintingPreferences exposed by
// the CoClass PrintingPreferences. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoPrintingPreferences = class
    class function Create: IPrintingPreferences;
    class function CreateRemote(const MachineName: string): IPrintingPreferences;
  end;

// *********************************************************************//
// The Class CoServer2 provides a Create and CreateRemote method to
// create instances of the default interface IServer exposed by
// the CoClass Server2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoServer2 = class
    class function Create: IServer;
    class function CreateRemote(const MachineName: string): IServer;
  end;

// *********************************************************************//
// The Class CoProfile2 provides a Create and CreateRemote method to
// create instances of the default interface IProfile exposed by
// the CoClass Profile2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoProfile2 = class
    class function Create: IProfile;
    class function CreateRemote(const MachineName: string): IProfile;
  end;

// *********************************************************************//
// The Class CoBatchProcessingOptions2 provides a Create and CreateRemote method to
// create instances of the default interface IBatchProcessingOptions exposed by
// the CoClass BatchProcessingOptions2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBatchProcessingOptions2 = class
    class function Create: IBatchProcessingOptions;
    class function CreateRemote(const MachineName: string): IBatchProcessingOptions;
  end;

// *********************************************************************//
// The Class CoPrintingPreferences2 provides a Create and CreateRemote method to
// create instances of the default interface IPrintingPreferences exposed by
// the CoClass PrintingPreferences2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoPrintingPreferences2 = class
    class function Create: IPrintingPreferences;
    class function CreateRemote(const MachineName: string): IPrintingPreferences;
  end;

// *********************************************************************//
// The Class CoP2FApp provides a Create and CreateRemote method to
// create instances of the default interface IP2FApp exposed by
// the CoClass P2FApp. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoP2FApp = class
    class function Create: IP2FApp;
    class function CreateRemote(const MachineName: string): IP2FApp;
  end;

// *********************************************************************//
// The Class CoSkinCollection provides a Create and CreateRemote method to
// create instances of the default interface ISkinCollection exposed by
// the CoClass SkinCollection. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSkinCollection = class
    class function Create: ISkinCollection;
    class function CreateRemote(const MachineName: string): ISkinCollection;
  end;

// *********************************************************************//
// The Class CoExcelOptions provides a Create and CreateRemote method to
// create instances of the default interface IExcelOptions exposed by
// the CoClass ExcelOptions. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoExcelOptions = class
    class function Create: IExcelOptions;
    class function CreateRemote(const MachineName: string): IExcelOptions;
  end;

// *********************************************************************//
// The Class CoPowerPointOptions provides a Create and CreateRemote method to
// create instances of the default interface IPowerPointOptions exposed by
// the CoClass PowerPointOptions. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoPowerPointOptions = class
    class function Create: IPowerPointOptions;
    class function CreateRemote(const MachineName: string): IPowerPointOptions;
  end;

// *********************************************************************//
// The Class CoSkin provides a Create and CreateRemote method to
// create instances of the default interface ISkin exposed by
// the CoClass Skin. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSkin = class
    class function Create: ISkin;
    class function CreateRemote(const MachineName: string): ISkin;
  end;

// *********************************************************************//
// The Class CoSkinCollection2 provides a Create and CreateRemote method to
// create instances of the default interface ISkinCollection exposed by
// the CoClass SkinCollection2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSkinCollection2 = class
    class function Create: ISkinCollection;
    class function CreateRemote(const MachineName: string): ISkinCollection;
  end;

// *********************************************************************//
// The Class CoExcelOptions2 provides a Create and CreateRemote method to
// create instances of the default interface IExcelOptions exposed by
// the CoClass ExcelOptions2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoExcelOptions2 = class
    class function Create: IExcelOptions;
    class function CreateRemote(const MachineName: string): IExcelOptions;
  end;

// *********************************************************************//
// The Class CoPowerPointOptions2 provides a Create and CreateRemote method to
// create instances of the default interface IPowerPointOptions exposed by
// the CoClass PowerPointOptions2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoPowerPointOptions2 = class
    class function Create: IPowerPointOptions;
    class function CreateRemote(const MachineName: string): IPowerPointOptions;
  end;

// *********************************************************************//
// The Class CoSkin2 provides a Create and CreateRemote method to
// create instances of the default interface ISkin exposed by
// the CoClass Skin2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSkin2 = class
    class function Create: ISkin;
    class function CreateRemote(const MachineName: string): ISkin;
  end;

// *********************************************************************//
// The Class CoHTML5Options provides a Create and CreateRemote method to
// create instances of the default interface IHTML5Options exposed by
// the CoClass HTML5Options. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoHTML5Options = class
    class function Create: IHTML5Options;
    class function CreateRemote(const MachineName: string): IHTML5Options;
  end;

implementation

uses System.Win.ComObj;

class function CoServer.Create: IServer;
begin
  Result := CreateComObject(CLASS_Server) as IServer;
end;

class function CoServer.CreateRemote(const MachineName: string): IServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Server) as IServer;
end;

class function CoProfile.Create: IProfile;
begin
  Result := CreateComObject(CLASS_Profile) as IProfile;
end;

class function CoProfile.CreateRemote(const MachineName: string): IProfile;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Profile) as IProfile;
end;

class function CoBatchProcessingOptions.Create: IBatchProcessingOptions;
begin
  Result := CreateComObject(CLASS_BatchProcessingOptions) as IBatchProcessingOptions;
end;

class function CoBatchProcessingOptions.CreateRemote(const MachineName: string): IBatchProcessingOptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BatchProcessingOptions) as IBatchProcessingOptions;
end;

class function CoPrintingPreferences.Create: IPrintingPreferences;
begin
  Result := CreateComObject(CLASS_PrintingPreferences) as IPrintingPreferences;
end;

class function CoPrintingPreferences.CreateRemote(const MachineName: string): IPrintingPreferences;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PrintingPreferences) as IPrintingPreferences;
end;

class function CoServer2.Create: IServer;
begin
  Result := CreateComObject(CLASS_Server2) as IServer;
end;

class function CoServer2.CreateRemote(const MachineName: string): IServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Server2) as IServer;
end;

class function CoProfile2.Create: IProfile;
begin
  Result := CreateComObject(CLASS_Profile2) as IProfile;
end;

class function CoProfile2.CreateRemote(const MachineName: string): IProfile;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Profile2) as IProfile;
end;

class function CoBatchProcessingOptions2.Create: IBatchProcessingOptions;
begin
  Result := CreateComObject(CLASS_BatchProcessingOptions2) as IBatchProcessingOptions;
end;

class function CoBatchProcessingOptions2.CreateRemote(const MachineName: string): IBatchProcessingOptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BatchProcessingOptions2) as IBatchProcessingOptions;
end;

class function CoPrintingPreferences2.Create: IPrintingPreferences;
begin
  Result := CreateComObject(CLASS_PrintingPreferences2) as IPrintingPreferences;
end;

class function CoPrintingPreferences2.CreateRemote(const MachineName: string): IPrintingPreferences;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PrintingPreferences2) as IPrintingPreferences;
end;

class function CoP2FApp.Create: IP2FApp;
begin
  Result := CreateComObject(CLASS_P2FApp) as IP2FApp;
end;

class function CoP2FApp.CreateRemote(const MachineName: string): IP2FApp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_P2FApp) as IP2FApp;
end;

class function CoSkinCollection.Create: ISkinCollection;
begin
  Result := CreateComObject(CLASS_SkinCollection) as ISkinCollection;
end;

class function CoSkinCollection.CreateRemote(const MachineName: string): ISkinCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SkinCollection) as ISkinCollection;
end;

class function CoExcelOptions.Create: IExcelOptions;
begin
  Result := CreateComObject(CLASS_ExcelOptions) as IExcelOptions;
end;

class function CoExcelOptions.CreateRemote(const MachineName: string): IExcelOptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExcelOptions) as IExcelOptions;
end;

class function CoPowerPointOptions.Create: IPowerPointOptions;
begin
  Result := CreateComObject(CLASS_PowerPointOptions) as IPowerPointOptions;
end;

class function CoPowerPointOptions.CreateRemote(const MachineName: string): IPowerPointOptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PowerPointOptions) as IPowerPointOptions;
end;

class function CoSkin.Create: ISkin;
begin
  Result := CreateComObject(CLASS_Skin) as ISkin;
end;

class function CoSkin.CreateRemote(const MachineName: string): ISkin;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Skin) as ISkin;
end;

class function CoSkinCollection2.Create: ISkinCollection;
begin
  Result := CreateComObject(CLASS_SkinCollection2) as ISkinCollection;
end;

class function CoSkinCollection2.CreateRemote(const MachineName: string): ISkinCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SkinCollection2) as ISkinCollection;
end;

class function CoExcelOptions2.Create: IExcelOptions;
begin
  Result := CreateComObject(CLASS_ExcelOptions2) as IExcelOptions;
end;

class function CoExcelOptions2.CreateRemote(const MachineName: string): IExcelOptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExcelOptions2) as IExcelOptions;
end;

class function CoPowerPointOptions2.Create: IPowerPointOptions;
begin
  Result := CreateComObject(CLASS_PowerPointOptions2) as IPowerPointOptions;
end;

class function CoPowerPointOptions2.CreateRemote(const MachineName: string): IPowerPointOptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PowerPointOptions2) as IPowerPointOptions;
end;

class function CoSkin2.Create: ISkin;
begin
  Result := CreateComObject(CLASS_Skin2) as ISkin;
end;

class function CoSkin2.CreateRemote(const MachineName: string): ISkin;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Skin2) as ISkin;
end;

class function CoHTML5Options.Create: IHTML5Options;
begin
  Result := CreateComObject(CLASS_HTML5Options) as IHTML5Options;
end;

class function CoHTML5Options.CreateRemote(const MachineName: string): IHTML5Options;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HTML5Options) as IHTML5Options;
end;

end.

