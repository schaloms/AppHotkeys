#Requires AutoHotkey v2.0

#Include <AHKCriteria>
#Include <AutoToolTip>
#Include <ErrMsg>
#Include <Paths>

LaunchApp(title, directory, file, params:="", waitCriteria:="")
{
  AutoToolTip("Starting " title " ...")

  try
  {
    return LaunchProcess(directory, file, params, waitCriteria)
  }
  catch as e
  {
    path := PathAppend(directory, file)
    ErrMsg(Format("Failed to start '{}'.`n`nPath:`t{}`nParams:`t{}", title, path, params), e)
    return 0
  }
}

LaunchProcess(directory, file, params:="", waitCriteria:="")
{
  if waitCriteria = ""
  {
    waitCriteria := AHK_EXE(file)
  }

  workingDir := (directory = "") ? PathGetUserProfileDir() : directory

  cmd := PathAppend(directory, file)
  if params != ""
  {
    cmd .= " " . params
  }

  Run(cmd, workingDir, "", &pid)
  WinWait(waitCriteria)
  WinActivate() ; activate last found window

  return pid
}
