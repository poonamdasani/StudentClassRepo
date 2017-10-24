public with sharing class AccountsOppAmountController {
    
    public class CustomObject{
        String accountName{get; set;}
        Double amount{get; set;}
        public String getAccountName(){
            return accountName;
        }
        public double getAmount(){
            return amount;
        }
    }
    
    public List<CustomObject> getList(){
        List<CustomObject> customObjectList = new List<customObject>();
        List<AggregateResult> groupedResult = OpportunitiesService.selectAggregateAccountByName();
        for(AggregateResult result: groupedResult ) {
            customObject cobject = new customObject();
            cobject.accountName = (String)result.get('Name');
            cobject.amount = (Double)result.get('sum');
            customObjectList .add(cobject);
        }
        return customObjectList ;
    }
}