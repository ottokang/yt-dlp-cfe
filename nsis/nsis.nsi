; Text encoding with UTF-8 BOM

; Set test mode
!define TEST_MODE

; Basic definitions
!define APP_NAME "yt-dlp-cfe"
!define APP_EXE  "yt-dlp-cfe.cmd"
!define APP_VERSION "1.0.0"
!define APP_PUBLISHER "yt-dlp-cfe Developers"
!define APP_UNINSTKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
!define APP_ICON "icon.ico"

; Compression settings
!ifdef TEST_MODE
    SetCompress off
!else
    SetCompressor lzma
!endif

; Installer settings
Name "${APP_NAME}"

!ifdef TEST_MODE
    OutFile "..\release\${APP_NAME} ${APP_VERSION}-test.exe"
!else
    OutFile "..\release\${APP_NAME} ${APP_VERSION}.exe"
!endif

InstallDir "$PROGRAMFILES64\${APP_NAME}"
RequestExecutionLevel admin

; Include Modern UI 2
!include "MUI2.nsh"
!define MUI_ICON "${APP_ICON}"
!define MUI_UNICON "${APP_ICON}"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

Var CreateDesktopShortcut
!define MUI_PAGE_CUSTOMFUNCTION_PRE DesktopShortcutPre
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "TradChinese"

; Installation section
Section "MainSection"
    ; Set output path and install files
    SetOutPath "$INSTDIR"
    File /r "..\bin\*.*"
    File /r "..\functions\*.*"
    File /r "..\locales\*.*"
    File "..\${APP_EXE}"
    File "${APP_ICON}"

    ; Uninstall registry entries
    WriteRegStr HKLM "${APP_UNINSTKEY}" "DisplayName" "${APP_NAME}"
    WriteRegStr HKLM "${APP_UNINSTKEY}" "DisplayVersion" "${APP_VERSION}"
    WriteRegStr HKLM "${APP_UNINSTKEY}" "Publisher" "${APP_PUBLISHER}"
    WriteRegStr HKLM "${APP_UNINSTKEY}" "DisplayIcon" "$INSTDIR\${APP_ICON}"
    WriteRegStr HKLM "${APP_UNINSTKEY}" "UninstallString" '"$INSTDIR\uninstall.exe"'
    WriteRegStr HKLM "${APP_UNINSTKEY}" "InstallLocation" "$INSTDIR"
    WriteRegDWORD HKLM "${APP_UNINSTKEY}" "NoModify" 1
    WriteRegDWORD HKLM "${APP_UNINSTKEY}" "NoRepair" 1

    ; Calculate installed size

    ; Uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"

    ; Create Start Menu shortcuts
    CreateDirectory "$SMPROGRAMS\${APP_NAME}"
    CreateShortcut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\${APP_ICON}"
    CreateShortcut "$SMPROGRAMS\${APP_NAME}\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\${APP_ICON}"

    ; Desktop shortcut (if selected)
    ${If} $CreateDesktopShortcut == 1
        CreateShortcut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\${APP_ICON}"
    ${EndIf}
SectionEnd

; Desktop shortcut pre-function
Function DesktopShortcutPre
    StrCpy $CreateDesktopShortcut 1
FunctionEnd

LangString FINISH_DESKTOP ${LANG_TRADCHINESE} "建立桌面捷徑"
!define MUI_FINISHPAGE_SHOWREADME_CHECKBOXES
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT $(FINISH_DESKTOP)
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreateDesktopShortcutChecked
Function CreateDesktopShortcutChecked
  StrCpy $CreateDesktopShortcut ${BST_CHECKED}
FunctionEnd

; Uninstallation section
Section "Uninstall"
  ; Remove files and shortcuts
    RMDir /r "$INSTDIR"
    RMDir /r "$SMPROGRAMS\${APP_NAME}"
    Delete "$DESKTOP\${APP_NAME}.lnk"

    ; Remove registry entries
    DeleteRegKey HKLM "${APP_UNINSTKEY}"
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
SectionEnd