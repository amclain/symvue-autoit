#cs ----------------------------------------------------------------------------

 SYMETRIX SYMVUE THIRD-PARTY SOFTWARE AUTOMATION EXAMPLE
 v1.0.0
 
 Audience:   Control system designers & programmers.
 
 Difficulty: Advanced
            (Intermediate if you have prior programming experience.)
 
 This example script shows how it is possible for Symetrix SymVue to control
 third-party applications.
 
 In this example we'll have SymVue manage a few lighting presets in Daslight,
 a third-party lighting control application. A link to the free Daslight
 software is provided at the end of this comment section if you wish to see
 this example in action on your computer.
 
 The quality of code provided is of that which you would expect to find running
 on a commissioned system. Although this complicates the example, it shows how
 to provide error handling and other checks that make the script robust and
 transparent to the operator of the system. These sections of the script are
 commented to help you understand what they are for. Keep in mind that how
 you handle errors depends on the type of end-user that will use your system,
 so always think before you copy-paste.
 
 
 PREREQUISITES:
 
   - Intermediate to advanced experience with the Windows operating system.
   
   - Intermediate experience with Symetrix SymNet Composer, including
     creating and exporting SymVue control screens.
 
   - Prior programming or scripting experience is helpful, but not mandatory.
     If you are new to scripting, the important thing to remember is to be
	 patient. It is normal for it to take days or weeks to learn how a script
	 like this works and understand enough to be able to create your own.
	 Read the documentation, do the tutorials provided by AutoIt, use a search
	 engine, and feel free to experiment.
   
   - Read the manual.
     The AutoIt function and macro references explain how each scripting
	 command works. They have also provided tutorials on how to use the
	 scripting language. Links are provided at the end of this comment
	 section.
   
   - When in doubt, GOOGLE IT!
     Chances are that other people have run into the same problem you're
	 facing. Search engines will be able to point you to the AutoIt
	 documentation, as well as to forum posts from people who have
	 provided solutions to various scripting problems.
 
 
 SOFTWARE TO INSTALL:
 
   - Symetrix SymNet Composer
     http://www.symetrix.co/resources/downloads/
   
   - Daslight DVC2
     http://www.daslight.com/en/download.htm
 
   - AutoIt
     http://www.autoitscript.com/site/autoit/downloads/
	 
	 During installation, it is recommended to select the option
	 to edit .au3 scripts by default (not run them).
	 
   * You can open this file in the scripting editor once AutoIt is installed. *
   
 
 DEMONSTRATION:
 
   If you encounter problems, known issues are listed below.
 
   Make sure you have installed the software listed above.
   
   Before we begin, launch Daslight. In the menu bar, make sure that
   Options -> Disable the moving fader
   is NOT checked. If it is, you won't be able to watch the faders move.
   Also in the menu, make sure
   Windows -> Live
   is activated. This will disable the Scene and Editor tabs so that
   only the Live view shows. Go ahead and close Daslight. 
   
   Launch "SymVue Control Panel.svx" located in the example folder.
   
   The audio section is just for decoration. If you click on one of the
   lighting presets on the right, Daslight will launch if it is not already
   running. Your scene will activate in Daslight, the faders will move to
   the respective preset, and SymVue will be returned to focus. There is
   a setting in the configurable options below to allow the lighting changes
   to happen in the background, like how you would probably want them to on
   a real system.
   
   If you're feeling brave, create a new Daslight project, mess up the faders,
   and then click one of the SymVue lighting presets.
   
   
 
   Now that you see how the project behaves, it should be easier to understand
   what is happening in each part of the script below.
   
   This file is included into the "Recall Scene [Name].au3" child scripts, which
   are compiled to executables (.exe) in the Tools -> Build (F7) menu, and linked
   to the lighting buttons in SymVue.
   
   Messages from the scripts can be viewed by running the scripts in the SciTE
   editor by clicking Tools -> Go (F5).
 
 
 KNOWN ISSUES:
   
   Problem:  The lighting buttons in SymVue don't do anything when clicked.
   Solution: Try running one of the recall preset executables
   (Recall Scene Presenter.exe) by double clicking it. If that works, relink
   the command buttons in SymVue to the recall preset executables on your
   computer. For some reason certain computers don't like relative paths
   in SymVue.
 
 
 FILES:
 
   Lighting Automation.au3			- This file. The script that handles application automation.
   
   Lighting.dvc						- Daslight project file.
   
   Recall Scene House Lights.au3	- Child script that recalls the "House Lights" preset.
   
   Recall Scene House Lights.exe	- Executable used by SymVue to recall the "House Lights" preset.
   
   Recall Scene Presenter.au3		- Child script that recalls the "Presenter" preset.
   
   Recall Scene Presenter.exe		- Executable used by SymVue to recall the "Presenter" preset.
   
   Recall Scene Video.au3			- Child script that recalls the "Video" preset.
   
   Recall Scene Video.exe			- Executable used by SymVue to recall the "Video" preset.
   
   SymVue Control Panel.svx			- The standalone SymVue control panel that the operator of a system would have access to.
   
   SymVue Project.symx				- The SymNet Composer project used to create the SymVue control panel.
   
 
 THIS SCRIPT WAS TESTED ON THE FOLLOWING PLATFORMS:
 Windows XP SP3 32-bit
 
 ----------  LINKS  ----------
 
 Symetrix SymNet Composer download:
 http://www.symetrix.co/resources/downloads/
 
 Daslight DVC2 download:
 http://www.daslight.com/en/download.htm
 
 AutoIt function reference:
 http://www.autoitscript.com/autoit3/docs/functions.htm
 
 AutoIt macro reference:
 http://www.autoitscript.com/autoit3/docs/macros.htm
 
 AutoIt tutorials:
 http://www.autoitscript.com/autoit3/docs/
 
#ce ----------------------------------------------------------------------------

; -- CONFIGURABLE OPTIONS --

; When TRUE:
; This option brings the Daslight window into focus when performing actions, then
; returns SymVue to the active window. This is so you are able to see what is going
; on in the demonstration.
; When FALSE:
; This script behaves as it would in a production environment, controlling Daslight
; behind the scenes while SymVue remains the window in focus. This disables Then
; "Launching Daslight" splash screen.
;
; You'll need to recompile the executable scripts if you change this value.
$bringDaslightToFront = True

$scriptName = "SymVue Automation Script" ; The name this script displays on alerts to the user.

; Store the titles of the windows we'll be using frequently.
$symvue = "SymVue"
$daslight = "Daslight Virtual Controller"

; The file name of our Daslight project.
; NOTE: There seems to be a glitch in Daslight where file names longer than 8 characters
; that are opened from the shell (ShellExecute) show up in Daslight's title bar
; as the file's short name (MyProject.dvc becomes MyProj~1.dvc). This is something to keep
; in mind when searching its window title.
$daslightFileName = "Lighting"

; The extension is needed to open the file but doesn't show up in the application's title
; bar if "show file extensions" is disabled in the operating system.
$daslightFileExt  = ".dvc"

; Scene select button ID's
$presenterButton	= "[CLASS:Button; INSTANCE:25]"
$videoButton		= "[CLASS:Button; INSTANCE:24]"
$houseLightsButton	= "[CLASS:Button; INSTANCE:23]"

; -- END OF CONFIGURABLE OPTIONS --

; ------------------------------------------------------------------------------

; Scene selection.

; These values are passed to the RecallLightingScene function to determine
; which lighting scene should be recalled.
Const $scenePresenter	= 1
Const $sceneVideo		= 2
Const $sceneHouseLights	= 3

; ------------------------------------------------------------------------------

; Set the title match mode to match any substring in the title so file names
; that might be displayed in the title bar don't matter to the script.
; (e.g. "Composer 1" will match "SymNet Composer 1.0 - MyProject.symx").
; http://www.autoitscript.com/autoit3/docs/functions/AutoItSetOption.htm
Opt("WinTitleMatchMode", 2)

; http://www.autoitscript.com/autoit3/docs/functions/AutoItSetOption.htm#PixelCoordMode
Opt("PixelCoordMode", 0)

; The window title of our Daslight project.
; NOTE: The file extension doesn't show up in the title bar if file extensions are hidden
; by the operating system.
$daslightProject  = $daslightFileName
$filePath = @WorkingDir & "\" & $daslightFileName & $daslightFileExt ; Absolute path to the Daslight project file.

; This function recalls a lighting scene referenced in the "scene selection"
; section above.
Func RecallLightingScene($sceneToRecall)
   
   ; Make sure a scene was selected.
   If $sceneToRecall = 0 Then
	  ConsoleWrite("No scene was selected." & @LF)
	  Return -1;
   EndIf
   
   ; Check if Daslight is already running our project.
   If WinExists($daslightProject) = 0 Then
   
	  ; Our project is not running.
	  ; Is another Daslight project open?
	  If WinExists($daslight) = 1 Then
		 
		 ; Daslight is running, but our project isn't loaded.
		 ConsoleWrite("Detected an open instance of Daslight." & @LF)
		 
		 ; Let's close down this instance of Daslight.
		 ConsoleWrite("Attempting to close the Daslight application." & @LF)
		 WinActivate($daslight) ; Bring the window into focus.
		 Send("!fq") ; Type "Alt + f" (file), followed by "q" (quit).
		 
		 ; See if the save dialog box appears. Wait for 1 second.
		 If WinWaitActive("DASLIGHT VIRTUAL CONTROLLER", "Do you wish to save changes", 1) <> 0 Then
		 ConsoleWrite("Detected Daslight save dialog box. Selecting ""No"" button." & @LF)
		 send("!n") ; Type "Alt + n" (No).
		 EndIf
		 
		 ; Wait for the Daslight window to close.
		 If WinWaitClose($daslight, "", 10) = 0 Then
			ConsoleWrite("Could not close Daslight. Stopping script." & @LF)
			MsgBox(0, $scriptName, "Could not close Daslight; script will now stop." & @LF & "Manually close Daslight and try the script again." & @LF & "Check your task manager to make sure DVC2.exe isn't running.")
			Return -1;
		 Else
			; Give the operating system one more second to let the closed program be flushed out of RAM before we relaunch it.
			; Otherwise it gets picky and sometimes doesn't like to open up again.
			Sleep(1000) 
		 EndIf
	  EndIf
   
	  ; Daslight is not running.
	  ConsoleWrite("Opening the Daslight project file:" & @LF)
	  ConsoleWrite($filePath & @LF)
	  
	  If $bringDaslightToFront = True Then SplashTextOn($scriptName, "Launching Daslight...", 300, 200, -1, -1, 32, "", 16)
	  
	  ShellExecute($filePath) ; Use ShellExecute instead of Run because the operating system needs to reference which program can open the file.
	  
	  If WinWaitActive($daslight, "", 10) = 0 Then
		 SplashOff()
		 ConsoleWrite("Could not launch Daslight." & @LF)
		 MsgBox("Could not launch Daslight.")
	  Else
		 ConsoleWrite("The Daslight project launched." & @LF)
		 SplashOff()
		 
		 ; Click the Daslight splash screen to make it go away.
		 If WinWaitActive("[CLASS:SplashScreenExClass]", "", 3) <> 0 Then
			ControlClick("[CLASS:SplashScreenExClass]", "", "")
		 EndIf
	  EndIf
   EndIf
   
   ; Daslight is running our project.
   ConsoleWrite("The example Daslight project is running." & @LF)
   
   If $bringDaslightToFront = True Then WinActivate($daslight) ; Bring the Daslight window into focus if the option is enabled in the section above.
   
   ; Click the "Live" tab to make sure it's selected.
   ; Note: This class ID changes between computers. You may need to update this line to make the action work.
   ; The demonstration instructions have you lock Daslight in live mode to bypass this problem.
   ;
   ; Drag the Finder Tool in the AutoIt Window Info application over to the Daslight's Live tab to find its class
   ; on your computer.
   ; http://www.autoitscript.com/autoit3/docs/intro/controls.htm
   ControlClick("Daslight", "Live", "[CLASS:Afx:00400000:0:00010011:00000000:00000000; INSTANCE:1]", "left", 1, 12, 157)
   
   ; Make sure all lighting faders are shown in demo mode.
   ; This works if the "PAR 64" tab at the bottom of the screen is selected.
   If $bringDaslightToFront = True Then
	  ; Search for the white light beams on blue background icon above the second channel fader.
	  ; If it doesn't exist, the wrong panel is active.
	  $pixelCheck  = PixelChecksum(34, 7, 54, 27, 1, ControlGetHandle("Daslight", "", "[CLASS:Static; INSTANCE:7]"))
	  ; Search for white after fader #8.
	  $pixelCheck2 = PixelChecksum(245, 7, 265, 27, 1, ControlGetHandle("Daslight", "", "[CLASS:Static; INSTANCE:7]"))
	  ConsoleWrite("Pixel Check:  " & $pixelCheck & "   " & $pixelCheck2 & @LF)
	  If $pixelCheck <> 420119405 Or $pixelCheck2 <> 2712217121 Then
		 ; Click the "Display only the fixtures" button.
		 ; There are actually two different instances of the button depending on if you are on the "General Outputs"
		 ; tab or the "PAR 64" tab.
		 ConsoleWrite("Click." & @LF)
		 ControlClick("Daslight Virtual Controller", "", "[CLASS:Button; INSTANCE:28]")
		 ControlClick("Daslight Virtual Controller", "", "[CLASS:Button; INSTANCE:60]")
		 Sleep(250) ; Give the screen time to refresh before the next check.
	  EndIf
	  ; Double check. If certain features are active it can take two clicks to get to the right panel.
	  $pixelCheck = PixelChecksum(34, 7, 54, 27, 1, ControlGetHandle("Daslight", "", "[CLASS:Static; INSTANCE:7]"))
	  $pixelCheck2 = PixelChecksum(245, 7, 265, 27, 1, ControlGetHandle("Daslight", "", "[CLASS:Static; INSTANCE:7]"))
	  ConsoleWrite("Pixel Check:  " & $pixelCheck & "   " & $pixelCheck2 & @LF)
	  If $pixelCheck <> 420119405 Or $pixelCheck2 <> 2712217121 Then
		 ConsoleWrite("Click." & @LF)
		 ControlClick("Daslight Virtual Controller", "", "[CLASS:Button; INSTANCE:28]")
		 ControlClick("Daslight Virtual Controller", "", "[CLASS:Button; INSTANCE:60]")
	  EndIf
   EndIf
   
   ; Click the respective scene button.
   Switch $sceneToRecall
	  Case $scenePresenter
		 ControlClick($daslight, "", $presenterButton)
	  Case $sceneVideo
		 ControlClick($daslight, "", $videoButton)
	  Case $sceneHouseLights
		 ControlClick($daslight, "", $houseLightsButton)
	  Case Else
		 ConsoleWrite("Attempted to recall an unknown scene. Aborting." & @LF)
   EndSwitch
   
   If $bringDaslightToFront = True Then Sleep(6000) ; If demo mode is enabled, sleep several seconds so user can watch the changes.
   WinActivate($symvue) ; Bring the SymVue window back into focus.
   
   ConsoleWrite("Done." & @LF)
EndFunc
