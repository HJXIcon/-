
拖到一两千的时候出现bug
上拉加载更多出现问题，有些cell不见了

cell没有被循环利用



/// 问题在返回cell的时候

if indexPath.item == itemCount - 1 {
itemCount += 30
collectionView.reloadData()
}

return cell

最后的一个cell没有返回
不能在这里上拉加载更多！！

