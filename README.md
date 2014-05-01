# Symetrix SymVue Automation

An example using Symetrix SymVue to control third-party applications.

## Website

[http://sourceforge.net/projects/symvue-autoit/](http://sourceforge.net/projects/symvue-autoit/)

## Documentation

```c
/*
 SYMETRIX SYMVUE THIRD-PARTY SOFTWARE AUTOMATION EXAMPLE
 v1.0.0
 
 Website:	 http://sourceforge.net/projects/symvue-autoit/

 Video:		 http://www.youtube.com/watch?v=qp_YY7tIiCs
 
 Audience:	 Control system designers & programmers.
 
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
 
   Lighting Automation.au3
   - This file. The script that handles application automation.
   
   Lighting.dvc
   - Daslight project file.
   
   Recall Scene House Lights.au3
   - Child script that recalls the "House Lights" preset.
   
   Recall Scene House Lights.exe
   - Executable used by SymVue to recall the "House Lights" preset.
   
   Recall Scene Presenter.au3
   - Child script that recalls the "Presenter" preset.
   
   Recall Scene Presenter.exe
   - Executable used by SymVue to recall the "Presenter" preset.
   
   Recall Scene Video.au3
   - Child script that recalls the "Video" preset.
   
   Recall Scene Video.exe
   - Executable used by SymVue to recall the "Video" preset.
   
   SymVue Control Panel.svx
   - The standalone SymVue control panel that the operator of a system would have access to.
   
   SymVue Project.symx
   - The SymNet Composer project used to create the SymVue control panel.
   
 
 THIS SCRIPT WAS TESTED ON THE FOLLOWING PLATFORMS:
 Windows XP Professional SP3		(32-bit)
 Windows XP Professional x64 SP2	(64-bit)
 Windows 7  Professional SP1		(64-bit)
 
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

 Article: Are my AutoIt EXEs really infected?
 Some virus scanners trigger a false positive. If you don't want to download the
 .exe files, you can build them yourself by opening the .au3 files in the SciTE
 editor and pressing F7.
 http://www.autoitscript.com/forum/topic/34658-are-my-autoit-exes-really-infected/
*/
```
