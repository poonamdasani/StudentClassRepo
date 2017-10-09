public class AccountsTrigger extends fflib_SObjectDomain {

    public AccountsTrigger(List<Account> sObjectList) {
        super(sObjectList);
    }

    public void updateOpportunityActivity(fflib_SObjectUnitOfWork uow) {

        for(Account account : (List<Account>) Records) {
            account.Description = 'Domain classes rock!';
            uow.registerDirty(account);
        }
    }
}