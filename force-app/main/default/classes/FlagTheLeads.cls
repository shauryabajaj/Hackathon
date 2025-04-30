public with sharing class FlagTheLeads  {
    @InvocableMethod(
 
    )
    public static List<LeadResponse> getLeads(
        List<LeadRequest> requests
    ) {
        LeadRequest req = new LeadRequest();
        System.debug('Test-->'+req.value);
        System.debug('TEST2-->'+requests[0].Value);
        Set<String> flagLeads = new Set<String>();
        if (requests[0].Value != null && requests[0].Value.toLowerCase().contains('dead')) {
            flagLeads.add('dead');
        }
        if (requests[0].Value != null && requests[0].Value.toLowerCase().contains('unqualified')) {
            flagLeads.add('unqualified');
        }
        if (requests[0].Value != null && requests[0].Value.toLowerCase().contains('rejected')) {
            flagLeads.add('rejected');
        }
        List<Lead> leadsToUpdate = [SELECT Id, Name,Flagged_For_Cleanup__c
                                    FROM Lead 
                                    WHERE Status IN :flagLeads];
        System.debug('leadsToUpdate'+leadsToUpdate);

        if (!leadsToUpdate.isEmpty()) {
          
        for (Lead l : leadsToUpdate) {
            l.Flagged_For_Cleanup__c = true;
        }

        update leadsToUpdate;
        }        
        System.debug('leadsToUpdate2-->'+leadsToUpdate[0].Flagged_For_Cleanup__c);
        
        
        String Output='Leads are flagged';
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