; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Amiga GCC"
#define MyAppVersion "6.4.1b"
#define MyAppPublisher "Stephen Moody"
#define MyAppURL "https://github.com/SteveMoody73/"
#define MinGWFolder "D:\Dev\Shell\msys64"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A2A32C01-A3FB-4AC6-9D9E-648DF42F756E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\amiga-gcc
DefaultGroupName={#MyAppName}
OutputBaseFilename=setup-amiga-gcc-{#MyAppVersion}-64
Compression=lzma
SolidCompression=yes
ChangesEnvironment=yes
DisableDirPage=no
SetupIconFile=icon.ico
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Icons]
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[Files]
Source: "{#MinGWFolder}\opt\amiga-gcc-64\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MinGWFolder}\mingw64\bin\libwinpthread-1.dll"; DestDir: "{app}\bin"; Flags: ignoreversion 
Source: "{#MinGWFolder}\mingw64\bin\libwinpthread-1.dll"; DestDir: "{app}\libexec\gcc\m68k-amigaos\{#MyAppVersion}"; Flags: ignoreversion 
Source: "{#MinGWFolder}\mingw64\bin\libwinpthread-1.dll"; DestDir: "{app}\m68k-amigaos\bin"; Flags: ignoreversion 
Source: "{#MinGWFolder}\mingw64\bin\libintl-8.dll"; DestDir: "{app}\bin"; Flags: ignoreversion 
Source: "{#MinGWFolder}\mingw64\bin\libintl-8.dll"; DestDir: "{app}\libexec\gcc\m68k-amigaos\{#MyAppVersion}"; Flags: ignoreversion 
Source: "{#MinGWFolder}\mingw64\bin\libintl-8.dll"; DestDir: "{app}\m68k-amigaos\bin"; Flags: ignoreversion 
Source: "{#MinGWFolder}\mingw64\bin\libgcc_s_dw2-1.dll"; DestDir: "{app}\bin"; Flags: ignoreversion 
Source: "{#MinGWFolder}\mingw64\bin\libgcc_s_dw2-1.dll"; DestDir: "{app}\libexec\gcc\m68k-amigaos\{#MyAppVersion}"; Flags: ignoreversion 
Source: "{#MinGWFolder}\mingw64\bin\libgcc_s_dw2-1.dll"; DestDir: "{app}\m68k-amigaos\bin"; Flags: ignoreversion 

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\bin"; \
    Check: NeedsAddPath(ExpandConstant('{app}\bin'))

[Code]
var
  OptionPage: TInputOptionWizardPage;
  
procedure InitializeWizard;
begin
  OptionPage := CreateInputOptionPage(wpSelectDir, 'Add to PATH?', '', '', False, False);
  OptionPage.Add('Add Amiga GCC tools to PATH?');

  OptionPage.Values[0] := True;
end;

function IsAddToPathSelected: Boolean;
begin
  Result := OptionPage.Values[0];
end;

function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if IsAddToPathSelected = True then
  begin
    if not RegQueryStringValue(
      HKEY_LOCAL_MACHINE,
      'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
      'Path', OrigPath)
    then begin
      Result := True;
      exit;
    end;
    { look for the path with leading and trailing semicolon }
    { Pos() returns 0 if not found }
    Result :=
      (Pos(';' + UpperCase(Param) + ';', ';' + UpperCase(OrigPath) + ';') = 0) and
      (Pos(';' + UpperCase(Param) + '\;', ';' + UpperCase(OrigPath) + ';') = 0); 
  end;
end;
