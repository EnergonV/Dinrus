module sys.inc.user32;
import sys.DConsts, sys.DStructs, std.string, std.utf;


/+
; --------------------------------------------------------------------------------------------------
;                           user32.inc Copyright The MASM32 SDK 1998-2010
; --------------------------------------------------------------------------------------------------

IFNDEF USER32_INC
USER32_INC equ <1>

ActivateKeyboardLayout PROTO STDCALL :DWORD,:DWORD
AdjustWindowRect PROTO STDCALL :DWORD,:DWORD,:DWORD
AdjustWindowRectEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
AllowSetForegroundWindow PROTO STDCALL :DWORD
AnimateWindow PROTO STDCALL :DWORD,:DWORD,:DWORD
AnyPopup PROTO STDCALL

AppendMenuA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  AppendMenu equ <AppendMenuA>
ENDIF

AppendMenuW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  AppendMenu equ <AppendMenuW>
ENDIF

ArrangeIconicWindows PROTO STDCALL :DWORD
AttachThreadInput PROTO STDCALL :DWORD,:DWORD,:DWORD
BeginDeferWindowPos PROTO STDCALL :DWORD
BeginPaint PROTO STDCALL :DWORD,:DWORD
BlockInput PROTO STDCALL :DWORD
BringWindowToTop PROTO STDCALL :DWORD

BroadcastSystemMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  BroadcastSystemMessage equ <BroadcastSystemMessageA>
ENDIF

BroadcastSystemMessageExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  BroadcastSystemMessageEx equ <BroadcastSystemMessageExA>
ENDIF

BroadcastSystemMessageExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  BroadcastSystemMessageEx equ <BroadcastSystemMessageExW>
ENDIF

BroadcastSystemMessageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  BroadcastSystemMessage equ <BroadcastSystemMessageW>
ENDIF


CallMsgFilterA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  CallMsgFilter equ <CallMsgFilterA>
ENDIF

CallMsgFilterW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  CallMsgFilter equ <CallMsgFilterW>
ENDIF

CallNextHookEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

CallWindowProcA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CallWindowProc equ <CallWindowProcA>
ENDIF

CallWindowProcW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CallWindowProc equ <CallWindowProcW>
ENDIF

CascadeChildWindows PROTO STDCALL :DWORD,:DWORD
CascadeWindows PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ChangeClipboardChain PROTO STDCALL :DWORD,:DWORD

ChangeDisplaySettingsA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  ChangeDisplaySettings equ <ChangeDisplaySettingsA>
ENDIF

ChangeDisplaySettingsExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  ChangeDisplaySettingsEx equ <ChangeDisplaySettingsExA>
ENDIF

ChangeDisplaySettingsExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  ChangeDisplaySettingsEx equ <ChangeDisplaySettingsExW>
ENDIF

ChangeDisplaySettingsW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  ChangeDisplaySettings equ <ChangeDisplaySettingsW>
ENDIF

ChangeMenuA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  ChangeMenu equ <ChangeMenuA>
ENDIF

ChangeMenuW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  ChangeMenu equ <ChangeMenuW>
ENDIF

CharLowerA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  CharLower equ <CharLowerA>
ENDIF

CharLowerBuffA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  CharLowerBuff equ <CharLowerBuffA>
ENDIF

CharLowerBuffW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  CharLowerBuff equ <CharLowerBuffW>
ENDIF

CharLowerW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  CharLower equ <CharLowerW>
ENDIF

CharNextA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  CharNext equ <CharNextA>
ENDIF

CharNextExA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CharNextEx equ <CharNextExA>
ENDIF

CharNextW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  CharNext equ <CharNextW>
ENDIF

CharPrevA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  CharPrev equ <CharPrevA>
ENDIF

CharPrevExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CharPrevEx equ <CharPrevExA>
ENDIF

CharPrevW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  CharPrev equ <CharPrevW>
ENDIF

CharToOemA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  CharToOem equ <CharToOemA>
ENDIF

CharToOemBuffA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CharToOemBuff equ <CharToOemBuffA>
ENDIF

CharToOemBuffW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CharToOemBuff equ <CharToOemBuffW>
ENDIF

CharToOemW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  CharToOem equ <CharToOemW>
ENDIF

CharUpperA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  CharUpper equ <CharUpperA>
ENDIF

CharUpperBuffA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  CharUpperBuff equ <CharUpperBuffA>
ENDIF

CharUpperBuffW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  CharUpperBuff equ <CharUpperBuffW>
ENDIF

CharUpperW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  CharUpper equ <CharUpperW>
ENDIF

CheckDlgButton PROTO STDCALL :DWORD,:DWORD,:DWORD
CheckMenuItem PROTO STDCALL :DWORD,:DWORD,:DWORD
CheckMenuRadioItem PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
CheckRadioButton PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
ChildWindowFromPoint PROTO STDCALL :DWORD,:DWORD,:DWORD
ChildWindowFromPointEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
ClientToScreen PROTO STDCALL :DWORD,:DWORD
ClipCursor PROTO STDCALL :DWORD
CloseClipboard PROTO STDCALL
CloseDesktop PROTO STDCALL :DWORD
CloseWindow PROTO STDCALL :DWORD
CloseWindowStation PROTO STDCALL :DWORD

CopyAcceleratorTableA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CopyAcceleratorTable equ <CopyAcceleratorTableA>
ENDIF

CopyAcceleratorTableW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CopyAcceleratorTable equ <CopyAcceleratorTableW>
ENDIF

CopyIcon PROTO STDCALL :DWORD
CopyImage PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
CopyRect PROTO STDCALL :DWORD,:DWORD
CountClipboardFormats PROTO STDCALL

CreateAcceleratorTableA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  CreateAcceleratorTable equ <CreateAcceleratorTableA>
ENDIF

CreateAcceleratorTableW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  CreateAcceleratorTable equ <CreateAcceleratorTableW>
ENDIF

CreateCaret PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
CreateCursor PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

CreateDesktopA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CreateDesktop equ <CreateDesktopA>
ENDIF

CreateDesktopW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CreateDesktop equ <CreateDesktopW>
ENDIF

CreateDialogIndirectParamA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CreateDialogIndirectParam equ <CreateDialogIndirectParamA>
ENDIF

CreateDialogIndirectParamW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CreateDialogIndirectParam equ <CreateDialogIndirectParamW>
ENDIF

CreateDialogParamA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CreateDialogParam equ <CreateDialogParamA>
ENDIF

CreateDialogParamW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CreateDialogParam equ <CreateDialogParamW>
ENDIF

CreateIcon PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
CreateIconFromResource PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
CreateIconFromResourceEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
CreateIconIndirect PROTO STDCALL :DWORD

CreateMDIWindowA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CreateMDIWindow equ <CreateMDIWindowA>
ENDIF

CreateMDIWindowW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CreateMDIWindow equ <CreateMDIWindowW>
ENDIF

CreateMenu PROTO STDCALL
CreatePopupMenu PROTO STDCALL

CreateWindowExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CreateWindowEx equ <CreateWindowExA>
ENDIF

CreateWindowExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CreateWindowEx equ <CreateWindowExW>
ENDIF

CreateWindowStationA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  CreateWindowStation equ <CreateWindowStationA>
ENDIF

CreateWindowStationW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  CreateWindowStation equ <CreateWindowStationW>
ENDIF

DbgWin32HeapFail PROTO STDCALL :DWORD,:DWORD
DbgWin32HeapStat PROTO STDCALL :DWORD,:DWORD,:DWORD
DdeAbandonTransaction PROTO STDCALL :DWORD,:DWORD,:DWORD
DdeAccessData PROTO STDCALL :DWORD,:DWORD
DdeAddData PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DdeClientTransaction PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
DdeCmpStringHandles PROTO STDCALL :DWORD,:DWORD
DdeConnect PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DdeConnectList PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
DdeCreateDataHandle PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

DdeCreateStringHandleA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DdeCreateStringHandle equ <DdeCreateStringHandleA>
ENDIF

DdeCreateStringHandleW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DdeCreateStringHandle equ <DdeCreateStringHandleW>
ENDIF

DdeDisconnect PROTO STDCALL :DWORD
DdeDisconnectList PROTO STDCALL :DWORD
DdeEnableCallback PROTO STDCALL :DWORD,:DWORD,:DWORD
DdeFreeDataHandle PROTO STDCALL :DWORD
DdeFreeStringHandle PROTO STDCALL :DWORD,:DWORD
DdeGetData PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DdeGetLastError PROTO STDCALL :DWORD
DdeImpersonateClient PROTO STDCALL :DWORD

DdeInitializeA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DdeInitialize equ <DdeInitializeA>
ENDIF

DdeInitializeW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DdeInitialize equ <DdeInitializeW>
ENDIF

DdeKeepStringHandle PROTO STDCALL :DWORD,:DWORD
DdeNameService PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DdePostAdvise PROTO STDCALL :DWORD,:DWORD,:DWORD
DdeQueryConvInfo PROTO STDCALL :DWORD,:DWORD,:DWORD
DdeQueryNextServer PROTO STDCALL :DWORD,:DWORD

DdeQueryStringA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DdeQueryString equ <DdeQueryStringA>
ENDIF

DdeQueryStringW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DdeQueryString equ <DdeQueryStringW>
ENDIF

DdeReconnect PROTO STDCALL :DWORD
DdeSetQualityOfService PROTO STDCALL :DWORD,:DWORD,:DWORD
DdeSetUserHandle PROTO STDCALL :DWORD,:DWORD,:DWORD
DdeUnaccessData PROTO STDCALL :DWORD
DdeUninitialize PROTO STDCALL :DWORD

DefDlgProcA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DefDlgProc equ <DefDlgProcA>
ENDIF

DefDlgProcW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DefDlgProc equ <DefDlgProcW>
ENDIF

DefFrameProcA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DefFrameProc equ <DefFrameProcA>
ENDIF

DefFrameProcW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DefFrameProc equ <DefFrameProcW>
ENDIF

DefMDIChildProcA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DefMDIChildProc equ <DefMDIChildProcA>
ENDIF

DefMDIChildProcW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DefMDIChildProc equ <DefMDIChildProcW>
ENDIF

DefRawInputProc PROTO STDCALL :DWORD,:DWORD,:DWORD

DefWindowProcA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DefWindowProc equ <DefWindowProcA>
ENDIF

DefWindowProcW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DefWindowProc equ <DefWindowProcW>
ENDIF

DeferWindowPos PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
DeleteMenu PROTO STDCALL :DWORD,:DWORD,:DWORD
DeregisterShellHookWindow PROTO STDCALL :DWORD
DestroyAcceleratorTable PROTO STDCALL :DWORD
DestroyCaret PROTO STDCALL
DestroyCursor PROTO STDCALL :DWORD
DestroyIcon PROTO STDCALL :DWORD
DestroyMenu PROTO STDCALL :DWORD
DestroyWindow PROTO STDCALL :DWORD

DialogBoxIndirectParamA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DialogBoxIndirectParam equ <DialogBoxIndirectParamA>
ENDIF

DialogBoxIndirectParamW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DialogBoxIndirectParam equ <DialogBoxIndirectParamW>
ENDIF

DialogBoxParamA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DialogBoxParam equ <DialogBoxParamA>
ENDIF

DialogBoxParamW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DialogBoxParam equ <DialogBoxParamW>
ENDIF

DisableProcessWindowsGhosting PROTO STDCALL

DispatchMessageA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  DispatchMessage equ <DispatchMessageA>
ENDIF

DispatchMessageW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  DispatchMessage equ <DispatchMessageW>
ENDIF

DlgDirListA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DlgDirList equ <DlgDirListA>
ENDIF

DlgDirListComboBoxA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DlgDirListComboBox equ <DlgDirListComboBoxA>
ENDIF

DlgDirListComboBoxW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DlgDirListComboBox equ <DlgDirListComboBoxW>
ENDIF

DlgDirListW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DlgDirList equ <DlgDirListW>
ENDIF

DlgDirSelectComboBoxExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DlgDirSelectComboBoxEx equ <DlgDirSelectComboBoxExA>
ENDIF

DlgDirSelectComboBoxExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DlgDirSelectComboBoxEx equ <DlgDirSelectComboBoxExW>
ENDIF

DlgDirSelectExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DlgDirSelectEx equ <DlgDirSelectExA>
ENDIF

DlgDirSelectExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DlgDirSelectEx equ <DlgDirSelectExW>
ENDIF

DragDetect PROTO STDCALL :DWORD,:DWORD,:DWORD
DragObject PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
DrawAnimatedRects PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DrawCaption PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DrawEdge PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DrawFocusRect PROTO STDCALL :DWORD,:DWORD
DrawFrame PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DrawFrameControl PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DrawIcon PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
DrawIconEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
DrawMenuBar PROTO STDCALL :DWORD

DrawStateA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DrawState equ <DrawStateA>
ENDIF

DrawStateW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DrawState equ <DrawStateW>
ENDIF

DrawTextA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DrawText equ <DrawTextA>
ENDIF

DrawTextExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  DrawTextEx equ <DrawTextExA>
ENDIF

DrawTextExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DrawTextEx equ <DrawTextExW>
ENDIF

DrawTextW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  DrawText equ <DrawTextW>
ENDIF

EditWndProc PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
EmptyClipboard PROTO STDCALL
EnableMenuItem PROTO STDCALL :DWORD,:DWORD,:DWORD
EnableScrollBar PROTO STDCALL :DWORD,:DWORD,:DWORD
EnableWindow PROTO STDCALL :DWORD,:DWORD
EndDeferWindowPos PROTO STDCALL :DWORD
EndDialog PROTO STDCALL :DWORD,:DWORD
EndMenu PROTO STDCALL
EndPaint PROTO STDCALL :DWORD,:DWORD
EndTask PROTO STDCALL :DWORD,:DWORD,:DWORD
EnumChildWindows PROTO STDCALL :DWORD,:DWORD,:DWORD
EnumClipboardFormats PROTO STDCALL :DWORD
EnumDesktopWindows PROTO STDCALL :DWORD,:DWORD,:DWORD

EnumDesktopsA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  EnumDesktops equ <EnumDesktopsA>
ENDIF

EnumDesktopsW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  EnumDesktops equ <EnumDesktopsW>
ENDIF

EnumDisplayDevicesA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  EnumDisplayDevices equ <EnumDisplayDevicesA>
ENDIF

EnumDisplayDevicesW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  EnumDisplayDevices equ <EnumDisplayDevicesW>
ENDIF

EnumDisplayMonitors PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

EnumDisplaySettingsA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  EnumDisplaySettings equ <EnumDisplaySettingsA>
ENDIF

EnumDisplaySettingsExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  EnumDisplaySettingsEx equ <EnumDisplaySettingsExA>
ENDIF

EnumDisplaySettingsExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  EnumDisplaySettingsEx equ <EnumDisplaySettingsExW>
ENDIF

EnumDisplaySettingsW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  EnumDisplaySettings equ <EnumDisplaySettingsW>
ENDIF

EnumPropsA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  EnumProps equ <EnumPropsA>
ENDIF

EnumPropsExA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  EnumPropsEx equ <EnumPropsExA>
ENDIF

EnumPropsExW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  EnumPropsEx equ <EnumPropsExW>
ENDIF

EnumPropsW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  EnumProps equ <EnumPropsW>
ENDIF

EnumThreadWindows PROTO STDCALL :DWORD,:DWORD,:DWORD

EnumWindowStationsA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  EnumWindowStations equ <EnumWindowStationsA>
ENDIF

EnumWindowStationsW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  EnumWindowStations equ <EnumWindowStationsW>
ENDIF

EnumWindows PROTO STDCALL :DWORD,:DWORD
EqualRect PROTO STDCALL :DWORD,:DWORD
ExcludeUpdateRgn PROTO STDCALL :DWORD,:DWORD
ExitWindowsEx PROTO STDCALL :DWORD,:DWORD
FillRect PROTO STDCALL :DWORD,:DWORD,:DWORD

FindWindowA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  FindWindow equ <FindWindowA>
ENDIF

FindWindowExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  FindWindowEx equ <FindWindowExA>
ENDIF

FindWindowExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  FindWindowEx equ <FindWindowExW>
ENDIF

FindWindowW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  FindWindow equ <FindWindowW>
ENDIF

FlashWindow PROTO STDCALL :DWORD,:DWORD
FlashWindowEx PROTO STDCALL :DWORD
FrameRect PROTO STDCALL :DWORD,:DWORD,:DWORD
FreeDDElParam PROTO STDCALL :DWORD,:DWORD
GetActiveWindow PROTO STDCALL

GetAltTabInfoA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetAltTabInfo equ <GetAltTabInfoA>
ENDIF

GetAltTabInfoW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetAltTabInfo equ <GetAltTabInfoW>
ENDIF

GetAncestor PROTO STDCALL :DWORD,:DWORD
GetAsyncKeyState PROTO STDCALL :DWORD
GetCapture PROTO STDCALL
GetCaretBlinkTime PROTO STDCALL
GetCaretPos PROTO STDCALL :DWORD

GetClassInfoA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetClassInfo equ <GetClassInfoA>
ENDIF

GetClassInfoExA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetClassInfoEx equ <GetClassInfoExA>
ENDIF

GetClassInfoExW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetClassInfoEx equ <GetClassInfoExW>
ENDIF

GetClassInfoW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetClassInfo equ <GetClassInfoW>
ENDIF

GetClassLongA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  GetClassLong equ <GetClassLongA>
ENDIF

GetClassLongW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  GetClassLong equ <GetClassLongW>
ENDIF

GetClassNameA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetClassName equ <GetClassNameA>
ENDIF

GetClassNameW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetClassName equ <GetClassNameW>
ENDIF

GetClassWord PROTO STDCALL :DWORD,:DWORD
GetClientRect PROTO STDCALL :DWORD,:DWORD
GetClipCursor PROTO STDCALL :DWORD
GetClipboardData PROTO STDCALL :DWORD

GetClipboardFormatNameA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetClipboardFormatName equ <GetClipboardFormatNameA>
ENDIF

GetClipboardFormatNameW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetClipboardFormatName equ <GetClipboardFormatNameW>
ENDIF

GetClipboardOwner PROTO STDCALL
GetClipboardSequenceNumber PROTO STDCALL
GetClipboardViewer PROTO STDCALL
GetComboBoxInfo PROTO STDCALL :DWORD,:DWORD
GetCursor PROTO STDCALL
GetCursorInfo PROTO STDCALL :DWORD
GetCursorPos PROTO STDCALL :DWORD
GetDC PROTO STDCALL :DWORD
GetDCEx PROTO STDCALL :DWORD,:DWORD,:DWORD
GetDesktopWindow PROTO STDCALL
GetDialogBaseUnits PROTO STDCALL
GetDlgCtrlID PROTO STDCALL :DWORD
GetDlgItem PROTO STDCALL :DWORD,:DWORD
GetDlgItemInt PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

GetDlgItemTextA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetDlgItemText equ <GetDlgItemTextA>
ENDIF

GetDlgItemTextW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetDlgItemText equ <GetDlgItemTextW>
ENDIF

GetDoubleClickTime PROTO STDCALL
GetFocus PROTO STDCALL
GetForegroundWindow PROTO STDCALL
GetGUIThreadInfo PROTO STDCALL :DWORD,:DWORD
GetGuiResources PROTO STDCALL :DWORD,:DWORD
GetIconInfo PROTO STDCALL :DWORD,:DWORD
GetInputDesktop PROTO STDCALL
GetInputState PROTO STDCALL
GetKBCodePage PROTO STDCALL

GetKeyNameTextA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetKeyNameText equ <GetKeyNameTextA>
ENDIF

GetKeyNameTextW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetKeyNameText equ <GetKeyNameTextW>
ENDIF

GetKeyState PROTO STDCALL :DWORD
GetKeyboardLayout PROTO STDCALL :DWORD
GetKeyboardLayoutList PROTO STDCALL :DWORD,:DWORD

GetKeyboardLayoutNameA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  GetKeyboardLayoutName equ <GetKeyboardLayoutNameA>
ENDIF

GetKeyboardLayoutNameW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  GetKeyboardLayoutName equ <GetKeyboardLayoutNameW>
ENDIF

GetKeyboardState PROTO STDCALL :DWORD
GetKeyboardType PROTO STDCALL :DWORD
GetLastActivePopup PROTO STDCALL :DWORD
GetLastInputInfo PROTO STDCALL :DWORD
GetLayeredWindowAttributes PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
GetListBoxInfo PROTO STDCALL :DWORD
GetMenu PROTO STDCALL :DWORD
GetMenuBarInfo PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
GetMenuCheckMarkDimensions PROTO STDCALL
GetMenuContextHelpId PROTO STDCALL :DWORD
GetMenuDefaultItem PROTO STDCALL :DWORD,:DWORD,:DWORD
GetMenuInfo PROTO STDCALL :DWORD,:DWORD
GetMenuItemCount PROTO STDCALL :DWORD
GetMenuItemID PROTO STDCALL :DWORD,:DWORD

GetMenuItemInfoA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetMenuItemInfo equ <GetMenuItemInfoA>
ENDIF

GetMenuItemInfoW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetMenuItemInfo equ <GetMenuItemInfoW>
ENDIF

GetMenuItemRect PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
GetMenuState PROTO STDCALL :DWORD,:DWORD,:DWORD

GetMenuStringA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetMenuString equ <GetMenuStringA>
ENDIF

GetMenuStringW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetMenuString equ <GetMenuStringW>
ENDIF

GetMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetMessage equ <GetMessageA>
ENDIF

GetMessageExtraInfo PROTO STDCALL
GetMessagePos PROTO STDCALL
GetMessageTime PROTO STDCALL

GetMessageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetMessage equ <GetMessageW>
ENDIF

GetMonitorInfoA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  GetMonitorInfo equ <GetMonitorInfoA>
ENDIF

GetMonitorInfoW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  GetMonitorInfo equ <GetMonitorInfoW>
ENDIF

GetMouseMovePointsEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetNextDlgGroupItem PROTO STDCALL :DWORD,:DWORD,:DWORD
GetNextDlgTabItem PROTO STDCALL :DWORD,:DWORD,:DWORD
GetOpenClipboardWindow PROTO STDCALL
GetParent PROTO STDCALL :DWORD
GetPriorityClipboardFormat PROTO STDCALL :DWORD,:DWORD
GetProcessDefaultLayout PROTO STDCALL :DWORD
GetProcessWindowStation PROTO STDCALL

GetPropA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  GetProp equ <GetPropA>
ENDIF

GetPropW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  GetProp equ <GetPropW>
ENDIF

GetQueueStatus PROTO STDCALL :DWORD
GetRawInputBuffer PROTO STDCALL :DWORD,:DWORD,:DWORD
GetRawInputData PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD

GetRawInputDeviceInfoA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetRawInputDeviceInfo equ <GetRawInputDeviceInfoA>
ENDIF

GetRawInputDeviceInfoW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetRawInputDeviceInfo equ <GetRawInputDeviceInfoW>
ENDIF

GetRawInputDeviceList PROTO STDCALL :DWORD,:DWORD,:DWORD
GetRegisteredRawInputDevices PROTO STDCALL :DWORD,:DWORD,:DWORD
GetScrollBarInfo PROTO STDCALL :DWORD,:DWORD,:DWORD
GetScrollInfo PROTO STDCALL :DWORD,:DWORD,:DWORD
GetScrollPos PROTO STDCALL :DWORD,:DWORD
GetScrollRange PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
GetShellWindow PROTO STDCALL
GetSubMenu PROTO STDCALL :DWORD,:DWORD
GetSysColor PROTO STDCALL :DWORD
GetSysColorBrush PROTO STDCALL :DWORD
GetSystemMenu PROTO STDCALL :DWORD,:DWORD
GetSystemMetrics PROTO STDCALL :DWORD

GetTabbedTextExtentA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetTabbedTextExtent equ <GetTabbedTextExtentA>
ENDIF

GetTabbedTextExtentW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetTabbedTextExtent equ <GetTabbedTextExtentW>
ENDIF

GetThreadDesktop PROTO STDCALL :DWORD
GetTitleBarInfo PROTO STDCALL :DWORD,:DWORD
GetTopWindow PROTO STDCALL :DWORD
GetUpdateRect PROTO STDCALL :DWORD,:DWORD,:DWORD
GetUpdateRgn PROTO STDCALL :DWORD,:DWORD,:DWORD

GetUserObjectInformationA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetUserObjectInformation equ <GetUserObjectInformationA>
ENDIF

GetUserObjectInformationW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetUserObjectInformation equ <GetUserObjectInformationW>
ENDIF

GetUserObjectSecurity PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetWindow PROTO STDCALL :DWORD,:DWORD
GetWindowContextHelpId PROTO STDCALL :DWORD
GetWindowDC PROTO STDCALL :DWORD
GetWindowInfo PROTO STDCALL :DWORD,:DWORD

GetWindowLongA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  GetWindowLong equ <GetWindowLongA>
ENDIF

GetWindowLongW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  GetWindowLong equ <GetWindowLongW>
ENDIF


GetWindowModuleFileNameA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetWindowModuleFileName equ <GetWindowModuleFileNameA>
ENDIF

GetWindowModuleFileNameW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetWindowModuleFileName equ <GetWindowModuleFileNameW>
ENDIF

GetWindowPlacement PROTO STDCALL :DWORD,:DWORD
GetWindowRect PROTO STDCALL :DWORD,:DWORD
GetWindowRgn PROTO STDCALL :DWORD,:DWORD
GetWindowRgnBox PROTO STDCALL :DWORD,:DWORD

GetWindowTextA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GetWindowText equ <GetWindowTextA>
ENDIF

GetWindowTextLengthA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  GetWindowTextLength equ <GetWindowTextLengthA>
ENDIF

GetWindowTextLengthW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  GetWindowTextLength equ <GetWindowTextLengthW>
ENDIF

GetWindowTextW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GetWindowText equ <GetWindowTextW>
ENDIF

GetWindowThreadProcessId PROTO STDCALL :DWORD,:DWORD
GetWindowWord PROTO STDCALL :DWORD,:DWORD

GrayStringA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  GrayString equ <GrayStringA>
ENDIF

GrayStringW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  GrayString equ <GrayStringW>
ENDIF

HideCaret PROTO STDCALL :DWORD
HiliteMenuItem PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

IMPGetIMEA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  IMPGetIME equ <IMPGetIMEA>
ENDIF

IMPGetIMEW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  IMPGetIME equ <IMPGetIMEW>
ENDIF

IMPQueryIMEA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  IMPQueryIME equ <IMPQueryIMEA>
ENDIF

IMPQueryIMEW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  IMPQueryIME equ <IMPQueryIMEW>
ENDIF

IMPSetIMEA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  IMPSetIME equ <IMPSetIMEA>
ENDIF

IMPSetIMEW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  IMPSetIME equ <IMPSetIMEW>
ENDIF

ImpersonateDdeClientWindow PROTO STDCALL :DWORD,:DWORD
InSendMessage PROTO STDCALL
InSendMessageEx PROTO STDCALL :DWORD
InflateRect PROTO STDCALL :DWORD,:DWORD,:DWORD

InsertMenuA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  InsertMenu equ <InsertMenuA>
ENDIF

InsertMenuItemA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  InsertMenuItem equ <InsertMenuItemA>
ENDIF

InsertMenuItemW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  InsertMenuItem equ <InsertMenuItemW>
ENDIF

InsertMenuW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  InsertMenu equ <InsertMenuW>
ENDIF

InternalGetWindowText PROTO STDCALL :DWORD,:DWORD,:DWORD
IntersectRect PROTO STDCALL :DWORD,:DWORD,:DWORD
InvalidateRect PROTO STDCALL :DWORD,:DWORD,:DWORD
InvalidateRgn PROTO STDCALL :DWORD,:DWORD,:DWORD
InvertRect PROTO STDCALL :DWORD,:DWORD

IsCharAlphaA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  IsCharAlpha equ <IsCharAlphaA>
ENDIF

IsCharAlphaNumericA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  IsCharAlphaNumeric equ <IsCharAlphaNumericA>
ENDIF

IsCharAlphaNumericW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  IsCharAlphaNumeric equ <IsCharAlphaNumericW>
ENDIF

IsCharAlphaW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  IsCharAlpha equ <IsCharAlphaW>
ENDIF

IsCharLowerA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  IsCharLower equ <IsCharLowerA>
ENDIF

IsCharLowerW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  IsCharLower equ <IsCharLowerW>
ENDIF

IsCharUpperA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  IsCharUpper equ <IsCharUpperA>
ENDIF

IsCharUpperW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  IsCharUpper equ <IsCharUpperW>
ENDIF

IsChild PROTO STDCALL :DWORD,:DWORD
IsClipboardFormatAvailable PROTO STDCALL :DWORD

IsDialogMessageA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  IsDialogMessage equ <IsDialogMessageA>
ENDIF

IsDialogMessageW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  IsDialogMessage equ <IsDialogMessageW>
ENDIF

IsDlgButtonChecked PROTO STDCALL :DWORD,:DWORD
IsGUIThread PROTO STDCALL :DWORD
IsHungAppWindow PROTO STDCALL :DWORD
IsIconic PROTO STDCALL :DWORD
IsMenu PROTO STDCALL :DWORD
IsRectEmpty PROTO STDCALL :DWORD
IsWinEventHookInstalled PROTO STDCALL :DWORD
IsWindow PROTO STDCALL :DWORD
IsWindowEnabled PROTO STDCALL :DWORD
IsWindowUnicode PROTO STDCALL :DWORD
IsWindowVisible PROTO STDCALL :DWORD
IsZoomed PROTO STDCALL :DWORD
KillTimer PROTO STDCALL :DWORD,:DWORD

LoadAcceleratorsA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  LoadAccelerators equ <LoadAcceleratorsA>
ENDIF

LoadAcceleratorsW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  LoadAccelerators equ <LoadAcceleratorsW>
ENDIF

LoadBitmapA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  LoadBitmap equ <LoadBitmapA>
ENDIF

LoadBitmapW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  LoadBitmap equ <LoadBitmapW>
ENDIF

LoadCursorA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  LoadCursor equ <LoadCursorA>
ENDIF

LoadCursorFromFileA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  LoadCursorFromFile equ <LoadCursorFromFileA>
ENDIF

LoadCursorFromFileW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  LoadCursorFromFile equ <LoadCursorFromFileW>
ENDIF

LoadCursorW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  LoadCursor equ <LoadCursorW>
ENDIF

LoadIconA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  LoadIcon equ <LoadIconA>
ENDIF

LoadIconW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  LoadIcon equ <LoadIconW>
ENDIF

LoadImageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  LoadImage equ <LoadImageA>
ENDIF

LoadImageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  LoadImage equ <LoadImageW>
ENDIF

LoadKeyboardLayoutA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  LoadKeyboardLayout equ <LoadKeyboardLayoutA>
ENDIF

LoadKeyboardLayoutW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  LoadKeyboardLayout equ <LoadKeyboardLayoutW>
ENDIF

LoadMenuA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  LoadMenu equ <LoadMenuA>
ENDIF

LoadMenuIndirectA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  LoadMenuIndirect equ <LoadMenuIndirectA>
ENDIF

LoadMenuIndirectW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  LoadMenuIndirect equ <LoadMenuIndirectW>
ENDIF

LoadMenuW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  LoadMenu equ <LoadMenuW>
ENDIF

LoadStringA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  LoadString equ <LoadStringA>
ENDIF

LoadStringW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  LoadString equ <LoadStringW>
ENDIF

LockSetForegroundWindow PROTO STDCALL :DWORD
LockWindowUpdate PROTO STDCALL :DWORD
LockWorkStation PROTO STDCALL
LookupIconIdFromDirectory PROTO STDCALL :DWORD,:DWORD
LookupIconIdFromDirectoryEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
MapDialogRect PROTO STDCALL :DWORD,:DWORD

MapVirtualKeyA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  MapVirtualKey equ <MapVirtualKeyA>
ENDIF

MapVirtualKeyExA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  MapVirtualKeyEx equ <MapVirtualKeyExA>
ENDIF

MapVirtualKeyExW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  MapVirtualKeyEx equ <MapVirtualKeyExW>
ENDIF

MapVirtualKeyW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  MapVirtualKey equ <MapVirtualKeyW>
ENDIF

MapWindowPoints PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
MenuItemFromPoint PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
MessageBeep PROTO STDCALL :DWORD

MessageBoxA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  MessageBox equ <MessageBoxA>
ENDIF

MessageBoxExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  MessageBoxEx equ <MessageBoxExA>
ENDIF

MessageBoxExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  MessageBoxEx equ <MessageBoxExW>
ENDIF

MessageBoxIndirectA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  MessageBoxIndirect equ <MessageBoxIndirectA>
ENDIF

MessageBoxIndirectW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  MessageBoxIndirect equ <MessageBoxIndirectW>
ENDIF

MessageBoxTimeoutA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  MessageBoxTimeout equ <MessageBoxTimeoutA>
ENDIF

MessageBoxTimeoutW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  MessageBoxTimeout equ <MessageBoxTimeoutW>
ENDIF

MessageBoxW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  MessageBox equ <MessageBoxW>
ENDIF

ModifyMenuA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  ModifyMenu equ <ModifyMenuA>
ENDIF

ModifyMenuW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  ModifyMenu equ <ModifyMenuW>
ENDIF

MonitorFromPoint PROTO STDCALL :DWORD,:DWORD,:DWORD
MonitorFromRect PROTO STDCALL :DWORD,:DWORD
MonitorFromWindow PROTO STDCALL :DWORD,:DWORD
MoveWindow PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
MsgWaitForMultipleObjects PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
MsgWaitForMultipleObjectsEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
NotifyWinEvent PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
OemKeyScan PROTO STDCALL :DWORD

OemToCharA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  OemToChar equ <OemToCharA>
ENDIF

OemToCharBuffA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  OemToCharBuff equ <OemToCharBuffA>
ENDIF

OemToCharBuffW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  OemToCharBuff equ <OemToCharBuffW>
ENDIF

OemToCharW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  OemToChar equ <OemToCharW>
ENDIF

OffsetRect PROTO STDCALL :DWORD,:DWORD,:DWORD
OpenClipboard PROTO STDCALL :DWORD

OpenDesktopA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  OpenDesktop equ <OpenDesktopA>
ENDIF

OpenDesktopW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  OpenDesktop equ <OpenDesktopW>
ENDIF

OpenIcon PROTO STDCALL :DWORD
OpenInputDesktop PROTO STDCALL :DWORD,:DWORD,:DWORD

OpenWindowStationA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  OpenWindowStation equ <OpenWindowStationA>
ENDIF

OpenWindowStationW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  OpenWindowStation equ <OpenWindowStationW>
ENDIF

PackDDElParam PROTO STDCALL :DWORD,:DWORD,:DWORD
PaintDesktop PROTO STDCALL :DWORD

PeekMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  PeekMessage equ <PeekMessageA>
ENDIF

PeekMessageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  PeekMessage equ <PeekMessageW>
ENDIF

PostMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  PostMessage equ <PostMessageA>
ENDIF

PostMessageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  PostMessage equ <PostMessageW>
ENDIF

PostQuitMessage PROTO STDCALL :DWORD

PostThreadMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  PostThreadMessage equ <PostThreadMessageA>
ENDIF

PostThreadMessageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  PostThreadMessage equ <PostThreadMessageW>
ENDIF

PrintWindow PROTO STDCALL :DWORD,:DWORD,:DWORD

PrivateExtractIconsA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  PrivateExtractIcons equ <PrivateExtractIconsA>
ENDIF

PrivateExtractIconsW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  PrivateExtractIcons equ <PrivateExtractIconsW>
ENDIF

PtInRect PROTO STDCALL :DWORD,:DWORD,:DWORD
RealChildWindowFromPoint PROTO STDCALL :DWORD,:DWORD,:DWORD

RealGetWindowClassA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  RealGetWindowClass equ <RealGetWindowClassA>
ENDIF

RealGetWindowClassW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  RealGetWindowClass equ <RealGetWindowClassW>
ENDIF

RedrawWindow PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

RegisterClassA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  RegisterClass equ <RegisterClassA>
ENDIF

RegisterClassExA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  RegisterClassEx equ <RegisterClassExA>
ENDIF

RegisterClassExW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  RegisterClassEx equ <RegisterClassExW>
ENDIF

RegisterClassW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  RegisterClass equ <RegisterClassW>
ENDIF

RegisterClipboardFormatA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  RegisterClipboardFormat equ <RegisterClipboardFormatA>
ENDIF

RegisterClipboardFormatW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  RegisterClipboardFormat equ <RegisterClipboardFormatW>
ENDIF

RegisterDeviceNotificationA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  RegisterDeviceNotification equ <RegisterDeviceNotificationA>
ENDIF

RegisterDeviceNotificationW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  RegisterDeviceNotification equ <RegisterDeviceNotificationW>
ENDIF

RegisterHotKey PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
RegisterRawInputDevices PROTO STDCALL :DWORD,:DWORD,:DWORD
RegisterShellHookWindow PROTO STDCALL :DWORD

RegisterWindowMessageA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  RegisterWindowMessage equ <RegisterWindowMessageA>
ENDIF

RegisterWindowMessageW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  RegisterWindowMessage equ <RegisterWindowMessageW>
ENDIF

ReleaseCapture PROTO STDCALL
ReleaseDC PROTO STDCALL :DWORD,:DWORD
RemoveMenu PROTO STDCALL :DWORD,:DWORD,:DWORD

RemovePropA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  RemoveProp equ <RemovePropA>
ENDIF

RemovePropW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  RemoveProp equ <RemovePropW>
ENDIF

ReplyMessage PROTO STDCALL :DWORD
ReuseDDElParam PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ScreenToClient PROTO STDCALL :DWORD,:DWORD
ScrollDC PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ScrollWindow PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ScrollWindowEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

SendDlgItemMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SendDlgItemMessage equ <SendDlgItemMessageA>
ENDIF

SendDlgItemMessageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SendDlgItemMessage equ <SendDlgItemMessageW>
ENDIF

SendIMEMessageExA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  SendIMEMessageEx equ <SendIMEMessageExA>
ENDIF

SendIMEMessageExW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  SendIMEMessageEx equ <SendIMEMessageExW>
ENDIF

SendInput PROTO STDCALL :DWORD,:DWORD,:DWORD

SendMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SendMessage equ <SendMessageA>
ENDIF

SendMessageCallbackA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SendMessageCallback equ <SendMessageCallbackA>
ENDIF

SendMessageCallbackW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SendMessageCallback equ <SendMessageCallbackW>
ENDIF

SendMessageTimeoutA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SendMessageTimeout equ <SendMessageTimeoutA>
ENDIF

SendMessageTimeoutW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SendMessageTimeout equ <SendMessageTimeoutW>
ENDIF

SendMessageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SendMessage equ <SendMessageW>
ENDIF

SendNotifyMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SendNotifyMessage equ <SendNotifyMessageA>
ENDIF

SendNotifyMessageW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SendNotifyMessage equ <SendNotifyMessageW>
ENDIF

SetActiveWindow PROTO STDCALL :DWORD
SetCapture PROTO STDCALL :DWORD
SetCaretBlinkTime PROTO STDCALL :DWORD
SetCaretPos PROTO STDCALL :DWORD,:DWORD

SetClassLongA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SetClassLong equ <SetClassLongA>
ENDIF

SetClassLongW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SetClassLong equ <SetClassLongW>
ENDIF

SetClassWord PROTO STDCALL :DWORD,:DWORD,:DWORD
SetClipboardData PROTO STDCALL :DWORD,:DWORD
SetClipboardViewer PROTO STDCALL :DWORD
SetCursor PROTO STDCALL :DWORD
SetCursorPos PROTO STDCALL :DWORD,:DWORD
SetDebugErrorLevel PROTO STDCALL :DWORD
SetDeskWallpaper PROTO STDCALL :DWORD
SetDlgItemInt PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

SetDlgItemTextA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SetDlgItemText equ <SetDlgItemTextA>
ENDIF

SetDlgItemTextW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SetDlgItemText equ <SetDlgItemTextW>
ENDIF

SetDoubleClickTime PROTO STDCALL :DWORD
SetFocus PROTO STDCALL :DWORD
SetForegroundWindow PROTO STDCALL :DWORD
SetKeyboardState PROTO STDCALL :DWORD
SetLastErrorEx PROTO STDCALL :DWORD,:DWORD
SetLayeredWindowAttributes PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
SetMenu PROTO STDCALL :DWORD,:DWORD
SetMenuContextHelpId PROTO STDCALL :DWORD,:DWORD
SetMenuDefaultItem PROTO STDCALL :DWORD,:DWORD,:DWORD
SetMenuInfo PROTO STDCALL :DWORD,:DWORD
SetMenuItemBitmaps PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD

SetMenuItemInfoA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SetMenuItemInfo equ <SetMenuItemInfoA>
ENDIF

SetMenuItemInfoW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SetMenuItemInfo equ <SetMenuItemInfoW>
ENDIF

SetMessageExtraInfo PROTO STDCALL :DWORD
SetMessageQueue PROTO STDCALL :DWORD
SetParent PROTO STDCALL :DWORD,:DWORD
SetProcessDefaultLayout PROTO STDCALL :DWORD
SetProcessWindowStation PROTO STDCALL :DWORD

SetPropA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SetProp equ <SetPropA>
ENDIF

SetPropW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SetProp equ <SetPropW>
ENDIF

SetRect PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SetRectEmpty PROTO STDCALL :DWORD
SetScrollInfo PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
SetScrollPos PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
SetScrollRange PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SetShellWindow PROTO STDCALL :DWORD
SetSysColors PROTO STDCALL :DWORD,:DWORD,:DWORD
SetSystemCursor PROTO STDCALL :DWORD,:DWORD
SetThreadDesktop PROTO STDCALL :DWORD
SetTimer PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

SetUserObjectInformationA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SetUserObjectInformation equ <SetUserObjectInformationA>
ENDIF

SetUserObjectInformationW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SetUserObjectInformation equ <SetUserObjectInformationW>
ENDIF

SetUserObjectSecurity PROTO STDCALL :DWORD,:DWORD,:DWORD
SetWinEventHook PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SetWindowContextHelpId PROTO STDCALL :DWORD,:DWORD

SetWindowLongA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SetWindowLong equ <SetWindowLongA>
ENDIF

SetWindowLongW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SetWindowLong equ <SetWindowLongW>
ENDIF

SetWindowPlacement PROTO STDCALL :DWORD,:DWORD
SetWindowPos PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SetWindowRgn PROTO STDCALL :DWORD,:DWORD,:DWORD

SetWindowTextA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  SetWindowText equ <SetWindowTextA>
ENDIF

SetWindowTextW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  SetWindowText equ <SetWindowTextW>
ENDIF

SetWindowWord PROTO STDCALL :DWORD,:DWORD,:DWORD

SetWindowsHookA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  SetWindowsHook equ <SetWindowsHookA>
ENDIF

SetWindowsHookExA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SetWindowsHookEx equ <SetWindowsHookExA>
ENDIF

SetWindowsHookExW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SetWindowsHookEx equ <SetWindowsHookExW>
ENDIF

SetWindowsHookW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  SetWindowsHook equ <SetWindowsHookW>
ENDIF

ShowCaret PROTO STDCALL :DWORD
ShowCursor PROTO STDCALL :DWORD
ShowOwnedPopups PROTO STDCALL :DWORD,:DWORD
ShowScrollBar PROTO STDCALL :DWORD,:DWORD,:DWORD
ShowWindow PROTO STDCALL :DWORD,:DWORD
ShowWindowAsync PROTO STDCALL :DWORD,:DWORD
SubtractRect PROTO STDCALL :DWORD,:DWORD,:DWORD
SwapMouseButton PROTO STDCALL :DWORD
SwitchDesktop PROTO STDCALL :DWORD
SwitchToThisWindow PROTO STDCALL :DWORD,:DWORD

SystemParametersInfoA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  SystemParametersInfo equ <SystemParametersInfoA>
ENDIF

SystemParametersInfoW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  SystemParametersInfo equ <SystemParametersInfoW>
ENDIF

TabbedTextOutA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  TabbedTextOut equ <TabbedTextOutA>
ENDIF

TabbedTextOutW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  TabbedTextOut equ <TabbedTextOutW>
ENDIF

TileChildWindows PROTO STDCALL :DWORD,:DWORD
TileWindows PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ToAscii PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ToAsciiEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ToUnicode PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ToUnicodeEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
TrackMouseEvent PROTO STDCALL :DWORD
TrackPopupMenu PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
TrackPopupMenuEx PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

TranslateAcceleratorA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  TranslateAccelerator equ <TranslateAcceleratorA>
ENDIF

TranslateAcceleratorW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  TranslateAccelerator equ <TranslateAcceleratorW>
ENDIF

TranslateMDISysAccel PROTO STDCALL :DWORD,:DWORD
TranslateMessage PROTO STDCALL :DWORD
UnhookWinEvent PROTO STDCALL :DWORD
UnhookWindowsHook PROTO STDCALL :DWORD,:DWORD
UnhookWindowsHookEx PROTO STDCALL :DWORD
UnionRect PROTO STDCALL :DWORD,:DWORD,:DWORD
UnloadKeyboardLayout PROTO STDCALL :DWORD
UnpackDDElParam PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD

UnregisterClassA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  UnregisterClass equ <UnregisterClassA>
ENDIF

UnregisterClassW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  UnregisterClass equ <UnregisterClassW>
ENDIF

UnregisterDeviceNotification PROTO STDCALL :DWORD
UnregisterHotKey PROTO STDCALL :DWORD,:DWORD
UpdateLayeredWindow PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
UpdateWindow PROTO STDCALL :DWORD
UserHandleGrantAccess PROTO STDCALL :DWORD,:DWORD,:DWORD
ValidateRect PROTO STDCALL :DWORD,:DWORD
ValidateRgn PROTO STDCALL :DWORD,:DWORD

VkKeyScanA PROTO STDCALL :DWORD
IFNDEF __UNICODE__
  VkKeyScan equ <VkKeyScanA>
ENDIF

VkKeyScanExA PROTO STDCALL :DWORD,:DWORD
IFNDEF __UNICODE__
  VkKeyScanEx equ <VkKeyScanExA>
ENDIF

VkKeyScanExW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  VkKeyScanEx equ <VkKeyScanExW>
ENDIF

VkKeyScanW PROTO STDCALL :DWORD
IFDEF __UNICODE__
  VkKeyScan equ <VkKeyScanW>
ENDIF

WINNLSEnableIME PROTO STDCALL :DWORD,:DWORD
WINNLSGetEnableStatus PROTO STDCALL :DWORD
WINNLSGetIMEHotkey PROTO STDCALL :DWORD
WaitForInputIdle PROTO STDCALL :DWORD,:DWORD
WaitMessage PROTO STDCALL

WinHelpA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  WinHelp equ <WinHelpA>
ENDIF

WinHelpW PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  WinHelp equ <WinHelpW>
ENDIF

WindowFromDC PROTO STDCALL :DWORD
WindowFromPoint PROTO STDCALL :DWORD,:DWORD
keybd_event PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
mouse_event PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD

wsprintfA PROTO C :VARARG
IFNDEF __UNICODE__
  wsprintf equ <wsprintfA>
ENDIF

wsprintfW PROTO C :VARARG
IFDEF __UNICODE__
  wsprintf equ <wsprintfW>
ENDIF

wvsprintfA PROTO STDCALL :DWORD,:DWORD,:DWORD
IFNDEF __UNICODE__
  wvsprintf equ <wvsprintfA>
ENDIF

wvsprintfW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  wvsprintf equ <wvsprintfW>
ENDIF

ELSE
  echo -----------------------------------------
  echo WARNING duplicate include file user32.inc
  echo -----------------------------------------
ENDIF
+/