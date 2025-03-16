public class LeadProcessor implements Database.Batchable<sObject> {
    
    // El método start que obtiene todos los registros de Lead
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // Esta consulta obtiene todos los registros de Lead
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }

    // El método execute que actualiza los registros de Lead
    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        for (Lead lead : scope) {
            // Actualiza el campo LeadSource a 'Dreamforce' para cada registro
            lead.LeadSource = 'Dreamforce';
        }
        // Realiza la actualización de los registros de Lead
        update scope;
    }

    // El método finish que se ejecuta al finalizar el batch
    public void finish(Database.BatchableContext bc) {
        // Opcionalmente, se pueden realizar acciones post-procesamiento
        System.debug('Batch job completed successfully.');
    }
}