export const sleep = (time: number) => {
  return new Promise<void>((resolve) => {
    setTimeout(() => {
      resolve()
    }, time)
  })
}

export const getRefreshStatusText = (refreshStatus: RefreshStatus) => {
  let promptText = '下拉刷新'
  switch (refreshStatus) {
    case RefreshStatus.Drag:
      promptText = '下拉刷新'
      break
    case RefreshStatus.OverDrag:
      promptText = '松开立即刷新...'
      break
    case RefreshStatus.Refresh:
      promptText = '正在刷新'
      break
  }
  return promptText
}

