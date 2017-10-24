public class OpportunitiesService {
    
    public static List<AggregateResult> selectAggregateAccountByName()
    {
        List<AggregateResult> opportunitiesList = new OpportunitiesSelector(true).selectAggregateAccountByName();
        return opportunitiesList;
    }

}