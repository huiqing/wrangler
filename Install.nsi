
!define PRODUCT_NAME "Wrangler"
!define PRODUCT_VERSION "0.9.4"
!define PRODUCT_PUBLISHER "Huiqing Li and Simon Thompson"
!define PRODUCT_WEB_SITE "www.cs.kent.ac.uk/projects/wrangler"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_NAME}.exe"

!include "MUI.nsh"
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}_Setup.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""

!define MUI_ABORTWARNING
!define MUI_ICON "wrangler_logo.ico"
!define MUI_UNICON "wrangler_logo.ico"
!insertmacro MUI_PAGE_WELCOME
!define MUI_LICENSEPAGE
!insertmacro MUI_PAGE_LICENSE "LICENCE.txt"
!insertmacro MUI_PAGE_DIRECTORY
Page instfiles
;;UninstPage uninstconfirm
;;UninstPage instfiles
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "${PRODUCT_NAME}"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_NAME}"
;;!insertmacro MUI_PAGE_STARTMENU
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.txt"
!define MUI_FINISHPAGE_LINK "www.cs.kent.ac.uk/projects/wrangler"
!define MUI_FINISHPAGE_LINK_LOCATION "${PRODUCT_WEB_SITE}"
!insertmacro MUI_PAGE_FINISH
!define MUI_UNABORTWARNING
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"
LicenseText " "
;LicenseData "${NSISDIR}\License.txt" 
DirText " "
ShowInstDetails show
ShowUnInstDetails show


;=============================================
; Variables
 var varErlangDir
 var varWranglerDir
 var varWranglerEBinDir
 var varWranglerSrcFiles
 var varWranglerSrcFiles0
 var varWranglerSrcFiles1
 var varWranglerSrcFiles2
 var varWranglerSrcFiles3
 var varRequireWrangler
 var varRequireErlang
 var varErlangEmacsDir
 var varErlangEmacsDir1
 var varErlangDir1
 var varINSTDIR
 var varHOME
;=============================================

Section "Install"
SetOutPath "$INSTDIR"

CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
;;CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_NAME}.exe"
;CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_NAME}.exe""
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\README.lnk" "$INSTDIR\README.txt"
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\LICENCE.lnk" "$INSTDIR\LICENCE.txt"
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\User Manual.lnk" "file:///$INSTDIR/doc/index.html"
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall Wrangler.lnk" "$INSTDIR\${PRODUCT_NAME}_Uninst.exe" "" "$INSTDIR\wrangler_logo.ico"


 ClearErrors
 Push $INSTDIR
 Call ConvertSlash
 pop $varINSTDIR

 File /r "c_src"
 File /r "doc"
 File /r "elisp"
 File /r "include"
 File /r "src"
 File /r "ebin"
 File /r "priv"
 File "README.txt"
 File "LICENCE.txt"
 File "wrangler_logo.ico"
 StrCpy $varWranglerDir "$\"$varINSTDIR$\""
 StrCpy $varWranglerEBinDir "$\"$varINSTDIR/ebin$\""
 StrCpy $varWranglerSrcFiles ".\src\wrangler_parse.erl \
	                          .\src\wrangler_expand_rule.erl \
							  .\src\api_refac.erl \
							  .\src\wrangler_scan.erl \
							  .\src\wrangler_epp_dodger.erl \
							  .\src\wrangler_syntax.erl \
							  .\src\wrangler_syntax_lib.erl \
							  .\src\wrangler_misc.erl \
						      .\src\api_ast_traverse.erl \
                             .\src\api_wrangler.erl \
                             .\src\distel.erl \
                             .\src\emacs_inspec.erl \
                             .\src\emacs_refac.erl \
                             .\src\gen_composite_refac.erl \
                             .\src\gen_refac.erl \
                             .\src\inspec_examples.erl \
                             .\src\inspec_lib.erl \
                             .\src\refac_add_a_tag.erl"
StrCpy $varWranglerSrcFiles0 ".\src\refac_gen.erl \
                             .\src\refac_inc_sim_code.erl \
                             .\src\refac_inline_var.erl \
                             .\src\refac_intro_import.erl \
                             .\src\refac_intro_new_var.erl \
                             .\src\refac_keysearch_to_keyfind.erl \
                             .\src\refac_list.erl \
                             .\src\refac_move_fun.erl \
                             .\src\refac_new_fun.erl \
                             .\src\refac_new_fun_rule_based.erl \
                             .\src\refac_new_let.erl \
                             .\src\refac_new_macro.erl \
                             .\src\refac_qc_gen.erl \
                             .\src\refac_register_pid.erl \
                             .\src\refac_remove_arg.erl \
                             .\src\refac_remove_import.erl \
                             .\src\refac_rename_fun.erl \
                             .\src\refac_rename_mod.erl \
                             .\src\refac_rename_process.erl \
                             .\src\refac_rename_var.erl \
                             .\src\refac_sim_code.erl"
StrCpy $varWranglerSrcFiles1  ".\src\refac_sim_expr_search.erl \
                             .\src\refac_specialise.erl \
                             .\src\refac_state_to_record.erl \
                             .\src\refac_swap_args.erl \
                             .\src\refac_tuple.erl \
                            .\src\refac_unfold_fun_app.erl \
                            .\src\wrangler.erl \
                            .\src\wrangler_annotate_ast.erl \
                            .\src\wrangler_annotate_pid.erl \
                            .\src\wrangler_anti_unification.erl \
                            .\src\wrangler_ast_server.erl \
                            .\src\wrangler_atom_annotation.erl \
                            .\src\wrangler_atom_utils.erl \
                            .\src\wrangler_callgraph.erl \
                            .\src\wrangler_callgraph_server.erl \
                            .\src\wrangler_code_inspector_lib.erl \
                            .\src\wrangler_code_search_utils.erl \
                            .\src\wrangler_comment_scan.erl \
                            .\src\wrangler_epp.erl \
                            .\src\wrangler_epp_dodger.erl"                          
StrCpy $varWranglerSrcFiles2 ".\src\wrangler_error_logger.erl \
                              .\src\wrangler_gen_refac_server.erl \
                             .\src\wrangler_generalised_unification.erl \
                             .\src\wrangler_io.erl \
                             .\src\wrangler_modularity_inspection.erl \
                             .\src\wrangler_module_graph.erl \
                             .\src\wrangler_modulegraph_server.erl \
                             .\src\wrangler_prettypr.erl \
                             .\src\wrangler_prettypr_0.erl \
                             .\src\wrangler_preview_server.erl \
                             .\src\wrangler_recomment.erl \
                             .\src\wrangler_refacs.erl \
                             .\src\wrangler_scan_with_layout.erl"
StrCpy $varWranglerSrcFiles3  ".\src\wrangler_side_effect.erl \
                             .\src\wrangler_slice.erl \
                             .\src\wrangler_suffix_tree.erl \
                             .\src\wrangler_sup.erl \
                             .\src\wrangler_type_annotation.erl \
                             .\src\wrangler_type_info.erl \
                             .\src\wrangler_undo_server.erl \
                             .\src\wrangler_unification.erl \
                             .\src\wrangler_write_file.erl \
							 .\src\refac_apply_to_remote_call.erl \
                             .\src\refac_batch_rename_fun.erl \
                             .\src\refac_clone_evolution.erl \
                             .\src\refac_comment_out_spec.erl \
                             .\src\refac_duplicated_code.erl \
                             .\src\refac_expr_search.erl \
                             .\src\refac_fold_against_macro.erl \
							 .\src\refac_fold_expression.erl \
                             .\src\refac_fun_to_process.erl"
    
  Push %WRANGLER_DIR%                        #text to be replaced
  Push $varWranglerDir                       #replace with
  Push all                                   #replace all occurrences
  Push all                                   #replace all occurrences
  Push $INSTDIR\elisp\wrangler.el.src        #file to replace in
  Call AdvReplaceInFile                      #call find and replace function
  Rename $INSTDIR\elisp\wrangler.el.src $INSTDIR\elisp\wrangler.el
  Delete $INSTDIR\elisp\wrangler.el.src
  
  CreateDirectory $INSTDIR\ebin
  ;;CopyFiles $INSTDIR\c_src\suffixtree.exe $INSTDIR\bin\suffixtree.exe
  RMDir /r $INSTDIR\c_src
  Call CheckErlang
  Call CheckErlangWranglerModeInEmacs
  Call CheckCookie


WriteUninstaller "$INSTDIR\${PRODUCT_NAME}_Uninst.exe"
WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "${PRODUCT_NAME}" "$INSTDIR\${PRODUCT_NAME}.exe"
WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\${PRODUCT_NAME}_Uninst.exe"
WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${PRODUCT_NAME}.exe"
WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

Section "Uninstall"
Delete "$INSTDIR\${PRODUCT_NAME}_Uninst.exe"
Delete "$INSTDIR\LICENCE.txt"
Delete "$INSTDIR\README.txt"
RMDir /r "$INSTDIR"
Delete "$SMPROGRAMS\${PRODUCT_NAME}\README.lnk"
Delete "$SMPROGRAMS\${PRODUCT_NAME}\LICENCE.lnk"
Delete "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall Wrangler.lnk"
RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
Call un.RemoveWranglerModeFromEmacs
DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
SetAutoClose true
SectionEnd


Function CheckErlang

  Push $R0
  Push $R1
  Push $R2
  Push $R3
  Push $R4
  Push $R5
  !define ERLCEXE "erlc.exe"

  ClearErrors
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.8.4" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.6.4\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.8.3" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.6.3\emacs"
  IfErrors 0 ErlangFound
  
    
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.8.2" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.6.2\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.8.1.1" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.6.1\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.8.1" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.6.1\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.8" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.6\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.7.5" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.5.1\emacs"
  IfErrors 0 ErlangFound
   
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.7.4" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.5\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.7.3" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.4\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.7.2" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.4\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.7.1" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.4\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.7" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.3\emacs"
  IfErrors 0 ErlangFound

  
  ClearErrors
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.6.5" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.2\emacs"
  IfErrors 0 ErlangFound

  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.6.4" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.2\emacs"
  IfErrors 0 ErlangFound
  
  ClearErrors
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.6.3" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.1\emacs"
  IfErrors 0 ErlangFound
  
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.6.2" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.1\emacs"
  IfErrors 0 ErlangFound

  ClearErrors
  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.6.1" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6.1\emacs"
  IfErrors 0 ErlangFound

  ReadRegStr $R0 HKLM "SOFTWARE\Ericsson\Erlang\5.6" ""
  StrCpy $varErlangDir $R0
  StrCpy $R1 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles"
  StrCpy $R2 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles0"
  StrCpy $R3 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles1"
  StrCpy $R4 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles2"
  StrCpy $R5 "$R0\bin\${ERLCEXE} -pa ebin -I include -o ebin $varWranglerSrcFiles3"
  StrCpy $varErlangEmacsDir "$R0\lib\tools-2.6\emacs"
  IfErrors 0 ErlangFound
  MessageBox MB_OK|MB_ICONINFORMATION "No Erlang installation was found on your system. \
  Please ensure that Erlang in installed on your computer before installing Wrangler."
  Delete "$INSTDIR\${PRODUCT_NAME}_Uninst.exe"
  RMDir "$INSTDIR"
  Abort
 ErlangFound:
  ;MessageBox MB_OK "Erlang installation found"
  
  ExecWait $R1
  ExecWait $R2
  ExecWait $R3
  ExecWait $R4
  ExecWait $R5
  
  pop $R5
  pop $R4
  pop $R3
  pop $R2
  pop $R1
  pop $R0
FunctionEnd

function un.RemoveWranglerModeFromEmacs

   Push $INSTDIR
   Call un.ConvertSlash
   Pop $varINSTDir
  ;; MessageBox MB_OK "$varINSTDIR"


   Push $R0
   
   ClearErrors
   ReadEnvStr $varHOME HOME
   IfErrors 0  +2
   StrCpy $varHOME "C:\"
   Push $varHOME
   Call un.ConvertForwardSlash
   Pop $varHOME
   StrCpy $R0 "$varHOME\.emacs"
   IfFileExists $R0 emacs_found
   ClearErrors
   StrCpy $R0 "$varHOME\.emacs.d\init.el"
   IfFileExists $R0 emacs_found
   ClearErrors
   StrCpy $R0 "$varHOME\.xemacs\init.el"
   IfFileExists emacs_found exit
   
   emacs_found:
   Push "(add-to-list 'load-path $\"$varINSTDIR/elisp$\")"
   Push ""                                    #replace with
   Push all                                   #replace all occurrences
   Push all                                   #replace all occurrences
   Push $R0                                   #file to replace in
   Call un.AdvReplaceInFile                      #call find and replace function
   Push "(setq exec-path (cons $\"$varINSTDIR/bin$\" exec-path))"
   Push ""                                    #replace with
   Push all                                   #replace all occurrences
   Push all                                   #replace all occurrences
   Push $R0                                   #file to replace in
   Call un.AdvReplaceInFile                      #call find and replace function
   Push "(require 'wrangler)"
   Push ""                                    #replace with
   Push all                                   #replace all occurrences
   Push all                                   #replace all occurrences
   Push $R0                                   #file to replace in
   Call un.AdvReplaceInFile                      #call find and replace function
   goto exit

   exit:
   Pop $R0
FunctionEnd

function CheckErlangWranglerModeInEmacs

   Push $0
   Push $1
   Push $2
   Push $3
   Push $4
   Push $5
   Push $6
   Push $7
   Push $R0
   Push $R1
   Push $R2
   Push $R3
   Push $R4

   ClearErrors
   Push $varErlangDir
   Call ConvertSlash
   Pop $varErlangDir1
   
   Push $varErlangEmacsDir
   Call ConvertSlash
   Pop $varErlangEmacsDir1
   
   ;;MessageBox MB_OK "$varErlangDir1"
   
   Push $INSTDIR
   Call ConvertSlash
   Pop $varINSTDir
  ;; MessageBox MB_OK "$varINSTDIR"
   
   ClearErrors
   ReadEnvStr $varHOME HOME
   ;;MessageBox MB_OK "HOME:$varHOME"
   IfErrors 0  +2
   StrCpy $varHOME "C:\"
   Push $varHOME
   Call ConvertForwardSlash
   Pop $varHOME
   StrCpy $R0 "$varHOME\.emacs"
   ;;MessageBox MB_OK "R0:$R0"
   IfFileExists $R0 emacs_found
   ClearErrors
   StrCpy $R0 "$varHOME\.emacs.d\init.el"
   IfFileExists $R0 emacs_found emacs_not_found
   
   emacs_not_found:
   StrCpy $R0 "$varHOME\.xemacs\init.el"
   IfFileExists $R0 emacs_found xemacs_not_found
   
   xemacs_not_found:
   MessageBox MB_OK|MB_ICONINFORMATION  "Wrangler could not locate the .emacs, .emacs.d\init.el nor .xemacs\init.el file; Please check README and modify manually."
   
   
   emacs_found:
   ;;MessageBox MB_OK "FileExist:$R0"
   ClearErrors
   ;MessageBox MB_OK "Emacs file:$R0"
   StrCpy $varRequireErlang "require 'erlang-start"
   StrLen $R2 $varRequireErlang
   FileOpen $1 $R0 r
   ;MessageBox MB_OK "Var:$varRequireErlang"
   ;MessageBox MB_OK "R2:$R2"
   erlang_loop_read:
   ClearErrors
   FileRead $1 $R3
   IfErrors erlang_mod_not_detected
   StrCpy $2 -1
   StrCpy $3 $R3
   erlang_loop_search:
   IntOp $2 $2 + 1
   StrCpy $6 $3 1 $2
   StrCmp $6 ";" erlang_loop_read
   StrCpy $4 $3 $R2 $2
   StrCmp $4 "" erlang_loop_read
   StrCmp $4 $varRequireErlang erlang_mod_detected erlang_loop_search

   erlang_mod_not_detected:
   FileClose $1
   ClearErrors
   ;MessageBox MB_OK "Erlang mode not detected"
   StrCpy $varRequireWrangler "require 'wrangler"
   StrLen $R2 $varRequireWrangler
   FileOpen $1 $R0 r
   wrangler_loop_read:
   ClearErrors
   FileRead $1 $R3
   IfErrors erlang_wrangler_mode_not_detected
   StrCpy $2 -1
   StrCpy $3 $R3
   wrangler_loop_search:
   IntOp $2 $2 + 1
   StrCpy $6 $3 1 $2
   StrCmp $6 ";" wrangler_loop_read
   StrCpy $4 $3 $R2 $2
   StrCmp $4 "" wrangler_loop_read
   StrCmp $4 $varRequireWrangler only_wrangler_mod_detected wrangler_loop_search

   erlang_wrangler_mode_not_detected:
   ;MessageBox MB_OK "Erlang and Wrangler mode not detected"
   FileClose $1

   Push "$R0"
   GetTempFileName $R6
   Push $R6
   Call unix2dos
   Delete "$R0"
   Rename $R6 "$R0"
   Delete $R6

   FileOpen $5 "$R0" a
   FileSeek $5 0 END
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(setq load-path (cons $\"$varErlangEmacsDir1$\" load-path))"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(setq erlang-root-dir $\"$varErlangDir1$\")"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(setq exec-path (cons $\"$varErlangDir1/bin$\" exec-path))"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(require 'erlang-start)"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(add-to-list 'load-path $\"$varINSTDIR/elisp$\")"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(setq exec-path (cons $\"$varINSTDIR/bin$\" exec-path))"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(require 'wrangler)"
   FileWrite $5 "$\r$\n"
   FileClose $5
   goto pop

   erlang_mod_detected:
   ;MessageBox MB_OK "Erlang mode detect"
   FileClose $1
   ClearErrors
   StrCpy $varRequireWrangler "(require 'wrangler)"
   StrLen $R2 $varRequireWrangler
   ;MessageBox MB_OK "$R0"
   FileOpen $1 "$R0" r
   wrangler_loop_read_1:
   ClearErrors
   FileRead $1 $R3
   IfErrors only_wrangler_mode_not_detected
   StrCpy $2 -1
   StrCpy $3 $R3
   wrangler_loop_search_1:
   IntOp $2 $2 + 1
   StrCpy $6 $3 1 $2
   StrCmp $6 ";" wrangler_loop_read_1
   StrCpy $4 $3 $R2 $2
   StrCmp $4 "" wrangler_loop_read_1
   StrCmp $4 $varRequireWrangler both_erlang_and_wrangler_mod_detected wrangler_loop_search_1

   only_wrangler_mode_not_detected:
  ; MessageBox MB_OK "Only Wranlger mode not detected"
   FileClose $1

   Push "$R0"
   GetTempFileName $R6
   Push $R6
   Call unix2dos
   Delete "$R0"
   Rename $R6 "$R0"
   Delete $R6

   FileOpen $5 "$R0" a
   FileSeek $5 0 END
   FileWrite $5 "(add-to-list 'load-path $\"$varINSTDIR/elisp$\")"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(setq exec-path (cons $\"$varINSTDIR/bin$\" exec-path))"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(require 'wrangler)"
   FileWrite $5 "$\r$\n"

   FileClose $5
   goto pop

   both_erlang_and_wrangler_mod_detected:
   ;MessageBox MB_OK "Wranlger mode detected"
   FileClose $1
   ClearErrors
   StrCpy $varRequireWrangler "(add-to-list 'load-path $\"$varINSTDIR/elisp$\")"
   StrLen $R2 $varRequireWrangler
   ;;messageBox MB_OK "Var1:$varRequireWrangler"
   ;MessageBox MB_OK "$R2"
   FileOpen $1 "$R0" r
   wrangler_loop_read_2:
   ClearErrors
   FileRead $1 $R3
   IfErrors wrangler_add_path_not_detected
   StrCpy $2 -1
   StrCpy $3 $R3
   wrangler_loop_search_2:
   IntOp $2 $2 + 1
   StrCpy $6 $3 1 $2
   StrCmp $6 ";" wrangler_loop_read_2
   StrCpy $4 $3 $R2 $2
   StrCmp $4 "" wrangler_loop_read_2
   StrCmp $4 $varRequireWrangler wrangler_add_path_detected wrangler_loop_search_2
   wrangler_add_path_not_detected:
   ;MessageBox MB_OK "Wrangler add_path not detected"
   MessageBox MB_OK "There seems to be an existing configuration for Wrangler \
   Emacs mode in your $R0 file. Please remove this configuration and try again."
   Delete "$INSTDIR\${PRODUCT_NAME}_Uninst.exe"
   ;;RMDir /r $INSTDIR
   Quit
   wrangler_add_path_detected:
   goto pop

   only_wrangler_mod_detected:
   ;MessageBox MB_OK "Only Wranlger mode etected"
   FileClose $1
   ClearErrors
   StrCpy $varRequireWrangler "(add-to-list 'load-path $\"$varINSTDIR/elisp$\")$\r$\n(setq exec-path (cons $\"$varINSTDIR/bin$\" exec-path))"
   StrLen $R2 $varRequireWrangler
  ;; MessageBox MB_OK "Var2:$varRequireWrangler"
   ;MessageBox MB_OK "$R2"
   FileOpen $1 "$R0" r
   wrangler_loop_read_3:
   ClearErrors
   FileRead $1 $R3
   IfErrors wrangler_add_path_not_detected
   StrCpy $2 -1
   StrCpy $3 $R3
   wrangler_loop_search_3:
   IntOp $2 $2 + 1
   StrCpy $6 $3 1 $2
   StrCmp $6 ";" wrangler_loop_read_3
   StrCpy $4 $3 $R2 $2
   StrCmp $4 "" wrangler_loop_read_3
   StrCmp $4 $varRequireWrangler 0 wrangler_loop_search_3
   FileClose $1
   Push "$R0"
   GetTempFileName $R6
   Push $R6
   Call unix2dos
   Delete "$R0"
   Rename $R6 "$R0"
   Delete $R6

   FileOpen $5 "$R0" a
   FileSeek $5 0 END
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(setq load-path (cons $\"$varErlangEmacsDir1$\" load-path))"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(setq erlang-root-dir $\"$varErlangDir1$\")"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(setq exec-path (cons $\"$varErlangDir1/bin$\" exec-path))"
   FileWrite $5 "$\r$\n"
   FileWrite $5 "(require 'erlang-start)"
   FileWrite $5 "$\r$\n"
   goto pop

   pop:
   Pop $R4
   Pop $R3
   Pop $R2
   Pop $R1
   Pop $R0
   Pop $7
   Pop $6
   Pop $5
   Pop $4
   Pop $3
   Pop $2
   Pop $1
   Pop $0

FunctionEnd
function AdvReplaceInFile

         ; call stack frame:
         ;   0 (Top Of Stack) file to replace in
         ;   1 number to replace after (all is valid)
         ;   2 replace and onwards (all is valid)
         ;   3 replace with
         ;   4 to replace

         ; save work registers and retrieve function parameters
         Exch $0 ;file to replace in
         Exch 4
         Exch $4 ;to replace
         Exch
         Exch $1 ;number to replace after
         Exch 3
         Exch $3 ;replace with
         Exch 2
         Exch $2 ;replace and onwards
         Exch 2
         Exch
         Push $5 ;minus count
         Push $6 ;universal
         Push $7 ;end string
         Push $8 ;left string
         Push $9 ;right string
         Push $R0 ;file1
         Push $R1 ;file2
         Push $R2 ;read
         Push $R3 ;universal
         Push $R4 ;count (onwards)
         Push $R5 ;count (after)
         Push $R6 ;temp file name
         GetTempFileName $R6
         FileOpen $R1 $0 r ;file to search in
         FileOpen $R0 $R6 w ;temp file
                  StrLen $R3 $4
                  StrCpy $R4 -1
                  StrCpy $R5 -1
        loop_read:
         ClearErrors
         FileRead $R1 $R2 ;read line
         IfErrors exit
         StrCpy $5 0
         StrCpy $7 $R2

        loop_filter:
         IntOp $5 $5 - 1
         StrCpy $6 $7 $R3 $5 ;search
         StrCmp $6 "" file_write2
         StrCmp $6 $4 0 loop_filter

         StrCpy $8 $7 $5 ;left part
         IntOp $6 $5 + $R3
         StrCpy $9 $7 "" $6 ;right part
         StrCpy $7 $8$3$9 ;re-join

         IntOp $R4 $R4 + 1
         StrCmp $2 all file_write1
         StrCmp $R4 $2 0 file_write2
         IntOp $R4 $R4 - 1

         IntOp $R5 $R5 + 1
         StrCmp $1 all file_write1
         StrCmp $R5 $1 0 file_write1
         IntOp $R5 $R5 - 1
         Goto file_write2

        file_write1:
         FileWrite $R0 $7 ;write modified line
         Goto loop_read

        file_write2:
         FileWrite $R0 $R2 ;write unmodified line
         Goto loop_read

        exit:
         FileClose $R0
         FileClose $R1

         SetDetailsPrint none
         Delete $0
         Rename $R6 $0
         Delete $R6
         SetDetailsPrint both

         Pop $R6
         Pop $R5
         Pop $R4
         Pop $R3
         Pop $R2
         Pop $R1
         Pop $R0
         Pop $9
         Pop $8
         Pop $7
         Pop $6
         Pop $5
         Pop $4
         Pop $3
         Pop $2
         Pop $1
         Pop $0
FunctionEnd


function un.AdvReplaceInFile

         ; call stack frame:
         ;   0 (Top Of Stack) file to replace in
         ;   1 number to replace after (all is valid)
         ;   2 replace and onwards (all is valid)
         ;   3 replace with
         ;   4 to replace

         ; save work registers and retrieve function parameters
         Exch $0 ;file to replace in
         Exch 4
         Exch $4 ;to replace
         Exch
         Exch $1 ;number to replace after
         Exch 3
         Exch $3 ;replace with
         Exch 2
         Exch $2 ;replace and onwards
         Exch 2
         Exch
         Push $5 ;minus count
         Push $6 ;universal
         Push $7 ;end string
         Push $8 ;left string
         Push $9 ;right string
         Push $R0 ;file1
         Push $R1 ;file2
         Push $R2 ;read
         Push $R3 ;universal
         Push $R4 ;count (onwards)
         Push $R5 ;count (after)
         Push $R6 ;temp file name
         GetTempFileName $R6
         FileOpen $R1 $0 r ;file to search in
         FileOpen $R0 $R6 w ;temp file
                  StrLen $R3 $4
                  StrCpy $R4 -1
                  StrCpy $R5 -1
        loop_read:
         ClearErrors
         FileRead $R1 $R2 ;read line
         IfErrors exit
         StrCpy $5 -1
         StrCpy $7 $R2
         filter_comments:
         IntOp $5 $5 + 1
         StrCpy $6 $7 1 $5
         StrCmp  $6 ";" file_write1
         StrCmp $6 "" 0 filter_comments
         StrCpy $5 0
         loop_filter:
         IntOp $5 $5 - 1
         StrCpy $6 $7 $R3 $5 ;search
         StrCmp $6 "" file_write2
         StrCmp $6 $4 0 loop_filter

         StrCpy $8 $7 $5 ;left part
         IntOp $6 $5 + $R3
         StrCpy $9 $7 "" $6 ;right part
         StrCpy $7 $8$3$9 ;re-join

         IntOp $R4 $R4 + 1
         StrCmp $2 all file_write1
         StrCmp $R4 $2 0 file_write2
         IntOp $R4 $R4 - 1

         IntOp $R5 $R5 + 1
         StrCmp $1 all file_write1
         StrCmp $R5 $1 0 file_write1
         IntOp $R5 $R5 - 1
         Goto file_write2

        file_write1:
         FileWrite $R0 $7 ;write modified line
         Goto loop_read

        file_write2:
         FileWrite $R0 $R2 ;write unmodified line
         Goto loop_read

        exit:
         FileClose $R0
         FileClose $R1

         SetDetailsPrint none
         Delete $0
         Rename $R6 $0
         Delete $R6
         SetDetailsPrint both

         Pop $R6
         Pop $R5
         Pop $R4
         Pop $R3
         Pop $R2
         Pop $R1
         Pop $R0
         Pop $9
         Pop $8
         Pop $7
         Pop $6
         Pop $5
         Pop $4
         Pop $3
         Pop $2
         Pop $1
         Pop $0
FunctionEnd


Function unix2dos
    ; strips all CRs
    ; and then converts all LFs into CRLFs
    ; (this is roughly equivalent to "cat file | dos2unix | unix2dos")
    ;
    ; usage:
    ;    Push "infile"
    ;    Push "outfile"
    ;    Call unix2dos
    ;
    ; beware that this function destroys $0 $1 $2

    ClearErrors

    Pop $2
    FileOpen $1 $2 w

    Pop $2
    FileOpen $0 $2 r

    Push $2 ; save name for deleting

    IfErrors unix2dos_done

    ; $0 = file input (opened for reading)
    ; $1 = file output (opened for writing)

unix2dos_loop:
    ; read a byte (stored in $2)
    FileReadByte $0 $2
    IfErrors unix2dos_done ; EOL
    ; skip CR
    StrCmp $2 13 unix2dos_loop
    ; if LF write an extra CR
    StrCmp $2 10 unix2dos_cr unix2dos_write

unix2dos_cr:
    FileWriteByte $1 13

unix2dos_write:
    ; write byte
    FileWriteByte $1 $2
    ; read next byte
    Goto unix2dos_loop

unix2dos_done:

    ; close files
    FileClose $0
    FileClose $1

    ; delete original
    Pop $0
    Delete $0

FunctionEnd

;;Function .onInstSuccess
;;  MessageBox MB_OK "You have successfully installed ${PRODUCT_NAME} ${PRODUCT_VERSION}. Use the desktop icon to start the program."
;;FunctionEnd


Function un.onUninstSuccess
 MessageBox MB_OK "You have successfully uninstalled ${PRODUCT_NAME} ${PRODUCT_VERSION}."
FunctionEnd


; convert forwardslash to backward slash.
Function ConvertForwardSlash
   Exch $R1
   Push $R2
   Push $R3
   
   StrCpy $R3 ""
   StrCpy $0 -1
  loop:
      IntOp $0 $0 + 1
      StrCpy $R2 $R1 1 $0
      StrCmp "$R2" "" done
      StrCmp "$R2" "/" backslash non_backslash
   backslash:
      StrCpy $R3 "$R3\"
      goto loop
   non_backslash:
      StrCpy $R3 "$R3$R2"
      goto loop
   done:
       StrCpy $R1 $R3
       Pop $R3
       Pop $R2
       Exch $R1
       
 FunctionEnd
 
 Function un.ConvertForwardSlash
   Exch $R1
   Push $R2
   Push $R3
   
   StrCpy $R3 ""
   StrCpy $0 -1
  loop:
      IntOp $0 $0 + 1
      StrCpy $R2 $R1 1 $0
      StrCmp "$R2" "" done
      StrCmp "$R2" "/" backslash non_backslash
   backslash:
      StrCpy $R3 "$R3\"
      goto loop
   non_backslash:
      StrCpy $R3 "$R3$R2"
      goto loop
   done:
       StrCpy $R1 $R3
       Pop $R3
       Pop $R2
       Exch $R1
       
 FunctionEnd
 
;; convert backward slash to forward slash.
Function ConvertSlash
   Exch $R1
   Push $R2
   Push $R3
   
   StrCpy $R3 ""
   StrCpy $0 -1
  loop:
      IntOp $0 $0 + 1
      StrCpy $R2 $R1 1 $0
      StrCmp "$R2" "" done
      StrCmp "$R2" "\" backslash non_backslash
   backslash:
      StrCpy $R3 "$R3/"
      goto loop
   non_backslash:
      StrCpy $R3 "$R3$R2"
      goto loop
   done:
       StrCpy $R1 $R3
       Pop $R3
       Pop $R2
       Exch $R1
       
 FunctionEnd
 
 Function un.ConvertSlash
   Exch $R1
   Push $R2
   Push $R3

   StrCpy $R3 ""
   StrCpy $0 -1
  loop:
      IntOp $0 $0 + 1
      StrCpy $R2 $R1 1 $0
      StrCmp "$R2" "" done
      StrCmp "$R2" "\" backslash non_backslash
   backslash:
      StrCpy $R3 "$R3/"
      goto loop
   non_backslash:
      StrCpy $R3 "$R3$R2"
      goto loop
   done:
       StrCpy $R1 $R3
       Pop $R3
       Pop $R2
       Exch $R1

 FunctionEnd

 
 
 
 function CheckCookie

   Push $R0
   
   ClearErrors
   ReadEnvStr $varHOME HOME
   IfErrors 0  +2
   StrCpy $varHOME "C:\"
   Push $varHOME
   Call ConvertForwardSlash
   Pop $varHOME
   StrCpy $R0 "$varHOME\.erlang.cookie"
   IfFileExists $R0 0 cookie_not_found
   Pop $R0
   cookie_not_found:
   push $1
   FileOpen $1 $R0 w 
   FileWrite $1 "erlangcookie"
   FileClose $1
   Pop $1
   Pop $R0

FunctionEnd
