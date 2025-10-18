#Requires AutoHotkey v2.0

#Include <AHKCriteria>
#Include <AutoToolTip>
#Include <ErrMsg>
#Include <Paths>

LaunchApp(title, directory, file, waitCriteria:="")
{
  AutoToolTip("Starting " title " ...")

  try
  {
    return LaunchProcess(directory, file, waitCriteria)
  }
  catch as e
  {
    path := PathAppend(directory, file)
    ErrMsg(Format("Failed to start '{}'.`n`nPath:`t{}", title, path), e)
    return 0
  }
}

LaunchProcess(directory, file, waitCriteria:="")
{
  if waitCriteria = ""
  {
    waitCriteria := AHK_EXE(file)
  }

  workingDir := (directory = "") ? PathGetUserProfileDir() : directory
  path := PathAppend(directory, file)

  Run(path, workingDir, "", &pid)
  WinWait(waitCriteria)
  WinActivate() ; activate last found window

  return pid
}
