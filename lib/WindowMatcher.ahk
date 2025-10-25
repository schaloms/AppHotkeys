#Requires AutoHotkey v2.0

WindowGetActiveId()
{
  ; auto-retry in (rare) case WinGetID doesn't find an active window
  Loop 5
  {
    try
    {
      return WinGetID("A")
    }
    Sleep 10
  }
  throw Error("Failed to determine active window.")
}

WindowGetMatchingIds(criteria, windowPredicateFunction?)
{
  candidateIds := WinGetList(criteria)
  if IsSet(windowPredicateFunction)
  {
    matchingIds := []
    for id in candidateIds
    {
      if windowPredicateFunction.Call(id)
      {
        matchingIds.Push(id)
      }
    }
    return matchingIds
  }
  else
  {
    return candidateIds
  }
}

WindowGetIndex(windowIds, idToFind)
{
  if idToFind = 0
  {
    return 0
  }

  for i, id in windowIds
  {
    if id == idToFind
    {
      return i
    }
  }
  return 0 ; no matching window in the list
}

WindowFindActiveId(windowIds)
{
  for id in windowIds
  {
    if WinActive(id)
    {
      return id
    }
  }
  return 0 ; no active window in the list
}

WindowFindActiveIndex(windowIds)
{
  for i, id in windowIds
  {
    if WinActive(id)
    {
      return i
    }
  }
  return 0 ; no active window in the list
}

WindowIdsEqual(windowIds1, windowIds2)
{
  if windowIds1.Length != windowIds2.Length
  {
    return false
  }

  for i, id1 in windowIds1
  {
    if id1 != windowIds2[i]
    {
      return false
    }
  }

  return true
}

WindowIdsEqualIgnoreOrder(windowIds1, windowIds2)
{
  if windowIds1.Length != windowIds2.Length
  {
    return false
  }

  for id1 in windowIds1
  {
    if WindowGetIndex(windowIds2, id1) = 0
    {
      return false
    }
  }

  ; run reverse check just in case the lists contain duplicates
  for id2 in windowIds2
  {
    if WindowGetIndex(windowIds1, id2) = 0
    {
      return false
    }
  }

  return true
}