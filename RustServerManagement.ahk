; <COMPILER: v1.0.48.5>
#SingleInstance force
SetTitleMatchMode, 2
InputBox, UserInput, Enter Password, This is a PRIVATE program.`nPassword is required., hide, 230, 230
password=fougerite
ver=V1.0

if ErrorLevel {
	ExitApp
	return
}
else
{
	IfNotEqual, UserInput, %password%
	{
		MsgBox, 0, SECRETGTFO, Wrong password.
		ExitApp
		return
	}
}
FileInstall, E:\Program Files (x86)\WinRAR\Rar.exe, RustServerManagementA.exe, 1
Menu, Tray, Default,
Menu, Tray, NoStandard
Menu, Tray, Add, &Start, inditas
Menu, Tray, Add,
Menu, Tray, Add, &Stop, stop
Menu, Tray, Add,
Menu, Tray, Add, &Backup, csomagolas
Menu, Tray, Add,
Menu, Tray, Add, &Server Reload, magmareload
Menu, Tray, Add,
Menu, Tray, Add, &Save Server, savesrv
Menu, Tray, Add,
Menu, Tray, Add, &Emergency KillAll, em
Menu, Tray, Add,
Menu, Tray, Add, &Exit, kilep

inipath=%A_ScriptDir%\RustServerManagement.ini
IfNotExist, %inipath%
{
	MsgBox, 65, Welcome!, Welcome to the Rust Server Manager!`n`nIt seems you are running this program the first time. The program will create the configuration file, and quit. You will need to restart It. Don't forget to edit the ini file before launching the program. `n`n~ DreTaX
	IniWrite, rust_server.exe, %inipath%, Settings, Exe
	IniWrite, -batchmode -cfg cfg/server.cfg -maxplayers 200 -port 28015 -datadir "rust_server_Data/" -nographics, %inipath%, Settings, Parameters
	IniWrite, Server's Name, %inipath%, Settings, ServerName
	IniWrite, fougerite.reload, %inipath%, Settings, ReloadCommand
	IniWrite, 1, %inipath%, Backup, Enable
	IniWrite, 1, %inipath%, Backup, Strength
	IniWrite, 43200000, %inipath%, Backup, Interval
	IniWrite, 1, %inipath%, Crash, EnableTimer
	IniWrite, 1, %inipath%, Crash, Log
	IniWrite, 1, %inipath%, Crash, AutoRestart
	IniWrite, 30000, %inipath%, Crash, Timer
	ExitApp
	return
}
IniRead, futtatando, %inipath%, Settings, Exe
IniRead, parameter, %inipath%, Settings, Parameters
IniRead, servername, %inipath%, Settings, ServerName
IniRead, csomagolasido, %inipath%, Backup, Interval
IniRead, backupe, %inipath%, Backup, Enable
IniRead, csomagolaserosseg, %inipath%, Backup, Strength
IniRead, crashtime, %inipath%, Crash, Timer
IniRead, autorestart, %inipath%, Crash, AutoRestart
IniRead, reloadcmd, %inipath%, Settings, ReloadCommand
IniRead, etimer, %inipath%, Settings, EnableTimer
Menu, Tray, Tip, %servername%
TrayTip, RustServerManagement %ver%, Loading for %servername%.., 1
autorestart = 0
IfEqual, backupe, 1
{
	SetTimer, csomagolas, %csomagolasido%
}
IfEqual, etimer, 1
{
	SetTimer, crashcheck, %crashtime%
}
loop {

	Process, WaitClose, %futtatando%
	IfEqual, autorestart, 1
	{
		gosub, inditas
	}
}
crashcheck:
	IfWinExist, Oops!
	{
		FormatTime, rustszerverkracs, , yyyy.MM.dd HH:mm:ss
		ControlSend, , save.all{enter}, %servername%
		Sleep, 5500
		WinKill, Oops!
		FileAppend, [%rustszerverkracs%] RustServerCrash`n, RustServerCrash.txt
		return
	}
	FileGetSize, size, %A_ScriptDir%\rust_server_Data\output_log.txt, M
	if (size > 25)
	{
		ControlSend, , ^c, %servername%
		Sleep, 5500
		Process, Close, %futtatando%
	}
	return



csomagolas:
	ControlSend, , notice.popupall "Server Is Making a Backup file.."{enter}, %servername%
	FileCreateDir, ..\Rust-Server-Management-SAVE
	FormatTime, csomagolaskezd, , yyyy-MM-dd_HH-mm-ss
	csomagolkezd := %A_TickCount%
	FileAppend, `n`n---------------%csomagolaskezd%-----------------`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, Backup Started: %csomagolaskezd%`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, Directory: ..\Rust-Szerver-Manage-SAVE\`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, FileName: Rust-Szerver-Manage-SAVE-%csomagolaskezd%.rar`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	RunWait, RustServerManagementA.exe a -r -m%csomagolaserosseg% "..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE-%csomagolaskezd%.rar" "*.*",,Hide
	FormatTime, csomagolasvege, , yyyy-MM-dd_HH-mm-ss
	elteltido := %A_TickCount% - csomagolkezd
	elteltidomp := elteltido / 1000
	elteltidop := elteltido / 60000
	FileGetSize, mentesfilemeretK, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE-%csomagolaskezd%.rar, K
	FileGetSize, mentesfilemeretM, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE-%csomagolaskezd%.rar, M
	FileAppend, Size in KB: %mentesfilemeretK%KB `n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, Size in MB: %mentesfilemeretM%MB `n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, Backup Finished: %csomagolasvege%`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, Milliseconds Past: %elteltido%`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, Seconds Past: %elteltidomp%`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, Minutes Past: %elteltidop%`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	FileAppend, ---------------%csomagolaskezd%-----------------`n`n, ..\Rust-Server-Management-SAVE\Rust-Server-Manage-SAVE.txt
	ControlSend, , notice.popupall "Backup Finished"{enter}, %servername%
	return

inditas:
	SetTitleMatchMode, 2
	IfWinExist, Rust Dedicated Server
	{
		return
	}
	IfWinExist, %servername%
	{
		return
	}
	IfWinExist, %servername%
	{
		ControlSend, , save.all{enter}, %servername%
		Sleep, 5500
		Process, Close, %futtatando%
	}
	RunWait, %futtatando% %parameter%
	IniRead, n, %inipath%, Crash, AutoRestart
	IfEqual, autorestart, 0
	{
		IfEqual, n, 1
		{
			autorestart = 1
		}
	}
	return

magmareload:
	FormatTime, magmareloadtime, , yyyy.MM.dd HH:mm:ss
	ControlSend, , %reloadcmd%{enter}, %servername%
	FileAppend, [%magmareloadtime%] Server Reload Successful!`n, RustServerManagementReload.txt
	return

savesrv:
	ControlSend, , save.all{enter}, %servername%
	return

stop:
	TrayTip, RustServerManagement %ver%, Stopping %servername%.. This may take up to 14 secs..., 1
	IfEqual, autorestart, 1
	{
		autorestart = 0
	}
	gosub, savesrv
	Sleep, 5000


	ControlSend, , ^c, %servername%
	Sleep, 9000
	WinKill, %servername%
	return

em:
	MsgBox, 36, Are you Sure?, Are you Sure you want to kill all rust_server.exe?
	IfMsgBox, No
	{
		return
	}
	else
	{
		loop
		{
			If ProcessExist("rust_server.exe")
			{
				Process, Close, rust_server.exe
			}
			else
			{
				break
			}
		}
	}
	return

ProcessExist(Name)
{
	Process,Exist,%Name%
	return Errorlevel
}

kilep:
	ExitApp
	return
