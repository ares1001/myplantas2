public class AccountProcessor {
    // Método anotado con @future que cuenta y actualiza los contactos
    @future
    public static void countContacts(Set<Id> accountIds) {
        // Crear un mapa para almacenar el número de contactos por cuenta
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();

        // Consulta para contar los contactos asociados con las cuentas dadas
        List<AggregateResult> contactCounts = [
            SELECT AccountId, COUNT(Id) contactCount
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ];

        // Recorrer los resultados y llenar el mapa
        for (AggregateResult ar : contactCounts) {
            contactCountMap.put((Id) ar.get('AccountId'), (Integer) ar.get('contactCount'));
        }

        // Crear una lista de cuentas para actualizar el campo Number_Of_Contacts__c
        List<Account> accountsToUpdate = new List<Account>();

        // Recorrer los Ids de las cuentas para actualizar el número de contactos
        for (Id accountId : accountIds) {
            // Si hay un número de contactos, lo establecemos, si no, 0
            Integer contactCount = contactCountMap.containsKey(accountId) ? contactCountMap.get(accountId) : 0;
            accountsToUpdate.add(new Account(Id = accountId, Number_Of_Contacts__c = contactCount));
        }

        // Realizar la actualización de las cuentas
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}