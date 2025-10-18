#Requires AutoHotkey v2.0

ErrMsg(msg, err?)
{
  if IsSet(err)
  {
    text := Format("{1}`n`nReason:`t{2}`nFile:`t{3}`nLine:`t{4}`nWhat:`t{5}",
                   msg, err.Message, err.File, err.Line, err.What)
  }
  else
  {
    text := msg
  }

  MsgBox(text, "Error", "OK Icon!")
}