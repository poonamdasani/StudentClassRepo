public class MyAccountController 
{
    public String selectedBillingCity { get; set; }
    public String selectedBillingState { get; set; }
    public String selectedBillingCountry { get; set; }
    public List<Account> accountList { get; set; }
    
    public MyAccountController () 
    {
        search();
    }
    
    public void search() 
    {
        accountList = AccountsService.get100AccountRecords(selectedBillingCity,selectedBillingState,selectedBillingCountry);
    }
}