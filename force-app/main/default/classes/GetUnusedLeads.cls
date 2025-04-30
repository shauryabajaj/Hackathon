public with sharing class GetUnusedLeads  {
    @InvocableMethod(
 
    )
    public static List<LeadResponse> getLeads(
        List<LeadRequest> requests
    ) {
        Integer deadLeads=0;
        Integer UnqualifiedLeads=0;
        Integer RejectedLeads=0;
        Integer val=0;
        String output = '';
        Set<String> statuses = new Set<String>{'Rejected', 'Dead', 'Unqualified'};
        List<lead> leadlist  = [select id,Status from lead where status IN : statuses];
        for(Lead l:leadlist){
            if(l.Status=='Rejected'){
                RejectedLeads++;
            }
            if(l.Status=='Dead'){
                deadLeads++;
            }
            if(l.Status=='Unqualified'){
                UnqualifiedLeads++;
            }
            
            val++;
        }
		output = 'Total Number of Unused Leads are: ' + val + ':\n';
			if (deadLeads > 0) {
    			output += 'Dead Leads: ' + deadLeads + '\n';
				}
        if (UnqualifiedLeads > 0) {
    			output += 'UnqualifiedLeads Leads: ' + UnqualifiedLeads + '\n';
				}
        if (RejectedLeads > 0) {
    			output += 'RejectedLeads Leads: ' + RejectedLeads + '\n';
				}

       LeadResponse response = new LeadResponse();
        //response.countLeads = val;
        response.countLeads = output;
       return new List<LeadResponse>{ response };
    }

  
    
    public class LeadRequest {
        @InvocableVariable()
        public String value;
    }

     public class LeadResponse {
 		@InvocableVariable()
        //public integer countLeads;
        public String countLeads;
    }
}