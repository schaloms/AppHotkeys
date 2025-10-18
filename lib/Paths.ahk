#Requires AutoHotkey v2.0

PathGetUserProfileDir(default:="C:\Users\schaloms")
{
  path := EnvGet("USERPROFILE")
  return path != "" ? path : default
}

PathGetProgramFilesDir(default:="C:\Program Files")
{
  path := EnvGet("ProgramFiles")
  return path != "" ? path : default
}

PathGetProgramFilesx86Dir(default:="C:\Program Files (x86)")
{
  path := EnvGet("ProgramFiles(x86)")
  return path != "" ? path : default
}

PathMakeRelative(path)
{
  if StrLen(path) = 0
  {
    return path
  }
  if SubStr(path, 1, 1) == "\"
  {
    return SubStr(path, 2) ; removing leading backslash
  }
  if SubStr(path, 2, 1) == ":"
  {
    return SubStr(path, 4) ; remove leading drive and backslash
  }
  return path
}

PathAppend(path, segment)
{
  if StrLen(path) = 0
  {
    return PathMakeRelative(segment)
  }
  if SubStr(path, -1, 1) != "\"
  {
    return path . "\" . PathMakeRelative(segment)
  }
  return path . PathMakeRelative(segment)
}

PathInUserProfileDir(relativePath)
{
  return PathAppend(PathGetUserProfileDir(), relativePath)
}

PathInUserProgramsDir(relativePath)
{
  return PathInUserProfileDir(PathAppend("AppData\Local\Programs\", relativePath))
}

PathInProgramFilesDir(relativePath)
{
  return PathAppend(PathGetProgramFilesDir(), relativePath)
}

PathInProgramFilesx86Dir(relativePath)
{
  return PathAppend(PathGetProgramFilesx86Dir(), relativePath)
}
