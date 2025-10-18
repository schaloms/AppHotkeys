#Requires AutoHotkey v2.0

#Include <AutoToolTip>
#Include <WindowTitle>
#Include <WindowMatcher>

WindowSwitchActive(groupIndicator, windowIds, direction:="next")
{
  static lastWindowIds := []
  static lastActivatedId := 0

  idToActivate := 0
  msg := ""

  ; check if we're still switching windows in the same group as before
  if WindowIdsEqualIgnoreOrder(windowIds, lastWindowIds)
  {
    ; ignore current Z-order, work with the windows in order the previous call
    windowIds := lastWindowIds
  }
  else
  {
    ; new or changed window group - save current Z-order
    lastWindowIds := windowIds.Clone()
    ; start with the currently active window when it's in this group
    lastActivatedId := WindowFindActiveId(windowIds) ; 0 when not in group
  }

  if windowIds.Length = 0
  {
    msg := Format("[{} | no switchable windows in group]", groupIndicator)
  }
  else if windowIds.Length = 1
  {
    msg := Format("{}`n[{} | 1 switchable window in group]",
                  WindowTitleClipped(AHK_HWND(windowIds[1])),
                  groupIndicator)

    idToActivate := windowIds[1]
    WinActivate(idToActivate)
  }
  else
  {
    ; determine index of last activated window in the current group
    currentIndex := WindowGetIndex(windowIds, lastActivatedId )
    if currentIndex = 0
    {
      ; last activated window not found in group - use 1st window instead
      newIndex := 1
    }
    else
    {
      if direction = "prev"
      {
        ; determine preceding window in Z-order
        newIndex := (currentIndex > 1) ? currentIndex - 1 : windowIds.Length
      }
      else if direction = "next"
      {
        ; determine next window in Z-order
        newIndex := (currentIndex < windowIds.Length) ? currentIndex + 1 : 1
      }
      else
      {
        ; use last activated window
        newIndex := currentIndex
      }
    }

    idToActivate := windowIds[newIndex]
    WinActivate(idToActivate)

    msg := Format("{}`n[{} | {:d} switchable windows in group]",
                  WindowTitleClipped(windowIds[newIndex]),
                  groupIndicator,
                  windowIds.Length)
  }

  lastActivatedId := idToActivate

  if msg != ""
  {
    AutoToolTip(msg)
  }
}
