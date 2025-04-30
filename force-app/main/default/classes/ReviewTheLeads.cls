public class ReviewTheLeads {
     @InvocableMethod(
 
    )
    public static List<LeadResponse> getLeads(
        List<LeadRequest> requests
    ) {
        Integer NumberOfLeadsToDelete;
        LeadRequest req = new LeadRequest();
        System.debug('Test-->'+req.value);
        System.debug('TEST2-->'+requests[0].Value);
        Set<String> flagLeads = new Set<String>();
        if (requests[0].Value != null && requests[0].Value.toLowerCase().contains('review')) {
            flagLeads.add('dead');
        }
        
        List<Lead> leadsToReview = [SELECT Id, Name,Flagged_For_Cleanup__c,Status,Company, PartnerAccount.Name
                                    FROM Lead 
                                    WHERE Flagged_For_Cleanup__c = true];
        

        if (!leadsToReview.isEmpty()) {
              System.debug('leadsToUpdate'+leadsToReview);
              NumberOfLeadsToDelete =leadsToReview.Size();
              //delete leadsToDelete;
            
        }        
        String Output ='';
        //String Output='By Deleting '+NumberOfLeadsToDelete+' Lead Records, You have helped prevent the emission of '+scaledWhole+' Kg carbon dioxide';
        LeadResponse response = new LeadResponse();
        //response.countLeads = val;
        response.countLeads = Output;
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