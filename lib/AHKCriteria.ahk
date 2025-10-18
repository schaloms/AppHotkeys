#Requires AutoHotkey v2.0

AHK_EXE(file)
{
  return "ahk_exe " . file
}

AHK_HWND(hwnd)
{
  return Format("ahk_id {:d}", hwnd)
}

AHK_ID(id)
{
  return Format("ahk_id {:d}", id)
}

AHK_PID(pid)
{
  return Format("ahk_pid {:d}", pid)
}
