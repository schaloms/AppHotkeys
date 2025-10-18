#Requires AutoHotkey v2.0

AutoToolTip(msg, timeout:=2000)
{
  ToolTip(msg)

  /* auto-hide the tooltip after the specified timout (negative value to run only once) */
  SetTimer(() => ToolTip(), -timeout)
}

