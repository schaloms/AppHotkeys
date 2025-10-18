#Requires AutoHotkey v2.0

WindowTitle(hwndOrCriteria, maxLen:=0)
{
  try
  {
    title := WinGetTitle(hwndOrCriteria)
  }
  catch
  {
    title := "<unknown>"
  }

  if maxLen > 0 && StrLen(title) > maxLen
  {
    title := SubStr(title, 1, maxLen) . " ..."
  }
  return title
}

WindowTitleClipped(hwndOrCriteria)
{
  return WindowTitle(hwndOrCriteria, 80)
}