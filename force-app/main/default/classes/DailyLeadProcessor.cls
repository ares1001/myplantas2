public class DailyLeadProcessor implements Schedulable {

    public void execute(SchedulableContext ctx) {
        // Buscar los primeros 200 Leads con LeadSource vacío
        List<Lead> leadsToUpdate = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = NULL LIMIT 200];

        // Si hay registros, actualizar su LeadSource a 'Dreamforce'
        for (Lead lead : leadsToUpdate) {
            lead.LeadSource = 'Dreamforce';  // Actualizamos el campo LeadSource con 'Dreamforce'
        }

        // Actualizamos los registros en la base de datos
        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }
}