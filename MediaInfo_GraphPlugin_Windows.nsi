#NSIS: encoding=UTF-8

!ifdef PORTABLE
  RequestExecutionLevel user
!else
  RequestExecutionLevel admin
!endif

!ifndef ARCH
  !define ARCH "i386"
  !ifdef PORTABLE
    !define SUFFIX "_Portable"
  !else
    !define SUFFIX ""
  !endif
!else
  !ifdef PORTABLE
    !define SUFFIX "_Portable_${ARCH}"
  !else
    !define SUFFIX "_${ARCH}"
  !endif
!endif

; Some defines
!define PRODUCT_NAME "MediaInfo Graph Plugin"
!define PRODUCT_PUBLISHER "MediaArea.net"
!define PRODUCT_VERSION "24.11"
!define PRODUCT_VERSION4 "${PRODUCT_VERSION}.0.0"
!define PRODUCT_WEB_SITE "http://MediaArea.net/MediaInfo"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; Compression
SetCompressor /FINAL /SOLID lzma

; x64 stuff
!include "x64.nsh"

; File size
!include FileFunc.nsh
!include WinVer.nsh

; Modern UI
!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "MediaInfo.ico"

; Installer pages
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

; Uninstaller pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Info
VIProductVersion "${PRODUCT_VERSION4}"
VIAddVersionKey "CompanyName"      "${PRODUCT_PUBLISHER}"
VIAddVersionKey "ProductName"      "${PRODUCT_NAME}"
VIAddVersionKey "ProductVersion"   "${PRODUCT_VERSION4}"
VIAddVersionKey "FileDescription"  "Graph visualisation support for MediaInfo"
VIAddVersionKey "FileVersion"      "${PRODUCT_VERSION4}"
VIAddVersionKey "LegalCopyright"   "${PRODUCT_PUBLISHER}"
VIAddVersionKey "OriginalFilename" "MediaInfo_GraphPlugin_${PRODUCT_VERSION}_Windows${SUFFIX}.exe"
BrandingText " "

; Modern UI end

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "MediaInfo_GraphPlugin_${PRODUCT_VERSION}_Windows${SUFFIX}.exe"
InstallDir "$PROGRAMFILES64\MediaInfo"
ShowInstDetails nevershow
ShowUnInstDetails nevershow

Function .onInit
  ${If} ${RunningX64}
    SetRegView 64
  ${EndIf}
FunctionEnd

Section "SectionPrincipale" SEC01
  SetOverwrite on
  SetOutPath "$INSTDIR"
  File "${ARCH}\config6"
  File "${ARCH}\ANN.dll"
  File "${ARCH}\brotlicommon.dll"
  File "${ARCH}\brotlidec.dll"
  File "${ARCH}\bz2.dll"
  File "${ARCH}\cairo-2.dll"
  File "${ARCH}\cdt.dll"
  File "${ARCH}\cgraph++.dll"
  File "${ARCH}\cgraph.dll"
  File "${ARCH}\ffi-8.dll"
  File "${ARCH}\fontconfig-1.dll"
  File "${ARCH}\freetype.dll"
  File "${ARCH}\fribidi-0.dll"
  File "${ARCH}\gdtclft.dll"
  File "${ARCH}\getopt.dll"
  File "${ARCH}\gio-2.0-0.dll"
  File "${ARCH}\glib-2.0-0.dll"
  File "${ARCH}\gmodule-2.0-0.dll"
  File "${ARCH}\gobject-2.0-0.dll"
  File "${ARCH}\gts.dll"
  File "${ARCH}\gvc++.dll"
  File "${ARCH}\gvc.dll"
  File "${ARCH}\gvplugin_core.dll"
  File "${ARCH}\gvplugin_dot_layout.dll"
  File "${ARCH}\gvplugin_gd.dll"
  File "${ARCH}\gvplugin_gdiplus.dll"
  File "${ARCH}\gvplugin_kitty.dll"
  File "${ARCH}\gvplugin_neato_layout.dll"
  File "${ARCH}\gvplugin_pango.dll"
  File "${ARCH}\gvplugin_vt.dll"
  File "${ARCH}\gvplugin_webp.dll"
  File "${ARCH}\harfbuzz.dll"
  File "${ARCH}\iconv-2.dll"
  File "${ARCH}\intl-8.dll"
  File "${ARCH}\jpeg62.dll"
  File "${ARCH}\libexpat.dll"
  File "${ARCH}\libgd.dll"
  File "${ARCH}\liblzma.dll"
  File "${ARCH}\libpng16.dll"
  File "${ARCH}\libsharpyuv.dll"
  File "${ARCH}\libwebp.dll"
  File "${ARCH}\pango-1.0-0.dll"
  File "${ARCH}\pangocairo-1.0-0.dll"
  File "${ARCH}\pangoft2-1.0-0.dll"
  File "${ARCH}\pangowin32-1.0-0.dll"
  File "${ARCH}\pathplan.dll"
  File "${ARCH}\pcre2-8.dll"
  File "${ARCH}\pixman-1-0.dll"
  File "${ARCH}\tcl86t.dll"
  File "${ARCH}\tcldot_builtin.dll"
  File "${ARCH}\tcldot.dll"
  File "${ARCH}\tclplan.dll"
  File "${ARCH}\tiff.dll"
  File "${ARCH}\xdot.dll"
  File "${ARCH}\zlib1.dll"
  File "${ARCH}\vcruntime140.dll"
  File "${ARCH}\concrt140.dll"
  File "${ARCH}\msvcp140.dll"
  File "${ARCH}\msvcp140_1.dll"
  File "${ARCH}\msvcp140_2.dll"
  File "${ARCH}\msvcp140_atomic_wait.dll"
  File "${ARCH}\msvcp140_codecvt_ids.dll"
  SetOverwrite try
  SetOutPath "$INSTDIR\Plugin\Graph"
  File "Plugin\Graph\Template.html"
  File "version.txt"
SectionEnd

Section -Post
  !ifndef PORTABLE
    WriteUninstaller "$INSTDIR\graph_plugin_uninst.exe"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName"     "$(^Name)"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon"     "$INSTDIR\MediaInfo.exe"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher"       "${PRODUCT_PUBLISHER}"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\graph_plugin_uninst.exe"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion"  "${PRODUCT_VERSION}"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout"    "${PRODUCT_WEB_SITE}"
    ${If} ${AtLeastWin7}
      WriteRegDWORD ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "EstimatedSize" "0x00000928" ; Create/Write the reg key with the dword value
    ${EndIf}
  !endif
SectionEnd


Section Uninstall
  ${If} ${RunningX64}
    SetRegView 64
  ${EndIf}

  Delete "$INSTDIR\expat.dll" ; Old versions
  Delete "$INSTDIR\graph_plugin_uninst.exe"
  Delete "$INSTDIR\config6"
  Delete "$INSTDIR\ANN.dll"
  Delete "$INSTDIR\brotlicommon.dll"
  Delete "$INSTDIR\brotlidec.dll"
  Delete "$INSTDIR\bz2.dll"
  Delete "$INSTDIR\cairo-2.dll"
  Delete "$INSTDIR\cdt.dll"
  Delete "$INSTDIR\cgraph++.dll"
  Delete "$INSTDIR\cgraph.dll"
  Delete "$INSTDIR\ffi-8.dll"
  Delete "$INSTDIR\fontconfig-1.dll"
  Delete "$INSTDIR\freetype.dll"
  Delete "$INSTDIR\fribidi-0.dll"
  Delete "$INSTDIR\gdtclft.dll"
  Delete "$INSTDIR\getopt.dll"
  Delete "$INSTDIR\gio-2.0-0.dll"
  Delete "$INSTDIR\glib-2.0-0.dll"
  Delete "$INSTDIR\gmodule-2.0-0.dll"
  Delete "$INSTDIR\gobject-2.0-0.dll"
  Delete "$INSTDIR\gts.dll"
  Delete "$INSTDIR\gvc++.dll"
  Delete "$INSTDIR\gvc.dll"
  Delete "$INSTDIR\gvplugin_core.dll"
  Delete "$INSTDIR\gvplugin_dot_layout.dll"
  Delete "$INSTDIR\gvplugin_gd.dll"
  Delete "$INSTDIR\gvplugin_gdiplus.dll"
  Delete "$INSTDIR\gvplugin_kitty.dll"
  Delete "$INSTDIR\gvplugin_neato_layout.dll"
  Delete "$INSTDIR\gvplugin_pango.dll"
  Delete "$INSTDIR\gvplugin_vt.dll"
  Delete "$INSTDIR\gvplugin_webp.dll"
  Delete "$INSTDIR\harfbuzz.dll"
  Delete "$INSTDIR\iconv-2.dll"
  Delete "$INSTDIR\intl-8.dll"
  Delete "$INSTDIR\jpeg62.dll"
  Delete "$INSTDIR\libexpat.dll"
  Delete "$INSTDIR\libgd.dll"
  Delete "$INSTDIR\liblzma.dll"
  Delete "$INSTDIR\libpng16.dll"
  Delete "$INSTDIR\libsharpyuv.dll"
  Delete "$INSTDIR\libwebp.dll"
  Delete "$INSTDIR\pango-1.0-0.dll"
  Delete "$INSTDIR\pangocairo-1.0-0.dll"
  Delete "$INSTDIR\pangoft2-1.0-0.dll"
  Delete "$INSTDIR\pangowin32-1.0-0.dll"
  Delete "$INSTDIR\pathplan.dll"
  Delete "$INSTDIR\pcre2-8.dll"
  Delete "$INSTDIR\pixman-1-0.dll"
  Delete "$INSTDIR\tcl86t.dll"
  Delete "$INSTDIR\tcldot_builtin.dll"
  Delete "$INSTDIR\tcldot.dll"
  Delete "$INSTDIR\tclplan.dll"
  Delete "$INSTDIR\tiff.dll"
  Delete "$INSTDIR\xdot.dll"
  Delete "$INSTDIR\zlib1.dll"
  Delete "$INSTDIR\vcruntime140.dll"
  Delete "$INSTDIR\vcruntime140_1.dll"
  Delete "$INSTDIR\concrt140.dll"
  Delete "$INSTDIR\msvcp140.dll"
  Delete "$INSTDIR\msvcp140_1.dll"
  Delete "$INSTDIR\msvcp140_2.dll"
  Delete "$INSTDIR\msvcp140_atomic_wait.dll"
  Delete "$INSTDIR\msvcp140_codecvt_ids.dll"
  Delete "$INSTDIR\Plugin\Graph\Template.html"
  Delete "$INSTDIR\Plugin\Graph\version.txt"
  RMDir "$INSTDIR\Plugin\Graph"
  RMDir "$INSTDIR\Plugin"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd
