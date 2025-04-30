public class DeleteFlaggedLeads {
     @InvocableMethod(
 
    )
    public static List<LeadResponse> getLeads(
        List<LeadRequest> requests
    ) {
        Decimal CO2saved;
        Long scaledWhole;
        Integer NumberOfLeadsToDelete;
        LeadRequest req = new LeadRequest();
        System.debug('Test-->'+req.value);
        System.debug('TEST2-->'+requests[0].Value);
        Set<String> flagLeads = new Set<String>();
        if (requests[0].Value != null && requests[0].Value.toLowerCase().contains('delete')) {
            flagLeads.add('dead');
        }
        Long heapBefore = Limits.getHeapSize();
        List<Lead> leadsToDelete = [SELECT Id, Name,Flagged_For_Cleanup__c
                                    FROM Lead 
                                    WHERE Flagged_For_Cleanup__c = true];
        

        if (!leadsToDelete.isEmpty()) {
              Long heapAfter = Limits.getHeapSize();       
              Long sizeInBytes = heapAfter - heapBefore;
              Double sizeInMB = sizeInBytes / 1048576.0;
              System.debug('leadsToUpdate'+leadsToDelete);
              NumberOfLeadsToDelete =leadsToDelete.Size();
              //delete leadsToDelete;
              CO2saved = sizeInMB * 0.0005;
              scaledWhole= (CO2saved * 1000000).round();
              scaledWhole=scaledWhole==0?1:scaledWhole;
             Emissions__c emission = new Emissions__c();
				emission.Object_Name__c = 'Lead';
				emission.Records_Deleted__c = NumberOfLeadsToDelete;
				emission.CO2_Saved__c = scaledWhole;
			insert emission;
        }        
        
        String Output='By Deleting '+NumberOfLeadsToDelete+' Lead Records, You have helped prevent the emission of '+scaledWhole+' Kg carbon dioxide';
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