/**
 * 자식 항목 수수료 0원 처리
 */
function fnChildPriceChange(grid, itemIndex, dataRow, field){
	var pricecnt = grid.getValue(itemIndex,"pricecnt")
    var chieldValue = grid.getChildren(itemIndex);
	grid.expand(itemIndex,true);
	for(var j=0; j<chieldValue.length; j++){
 	   if(j < pricecnt){
 	   		grid.setValue(chieldValue[j],"itemprice",0);
 	   } else {
 			grid.setValue(chieldValue[j],"itemprice",grid.getValue(chieldValue[j],"price"));
 	   }
    }
}


function fnRePrice(gridView, dataProvider){
	var getCnt = dataProvider.getRowCount();
	
    if (getCnt > 0) {
       for (var i =0; i < getCnt ; i++) {
           if (gridView.getValue(i,"pricecnt") > 0) {
               var pricecnt = gridView.getValue(i,"pricecnt");
        	   var chieldValue = gridView.getChildren(i);
               for(var j=0; j<chieldValue.length; j++){
            	   if(j < pricecnt){
            	   		gridView.setValue(chieldValue[j],"itemprice",0);
            	   } else {
            			gridView.setValue(chieldValue[j],"itemprice",gridView.getValue(chieldValue[j],"price"));
            	   }
               }
           }
       }
       gridView.commit();
   }
}