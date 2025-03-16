public class AddPrimaryContact implements Queueable {
    // Variables de instancia
    private Contact contactToInsert;
    private String stateAbbreviation;

    // Constructor que acepta un sObject de Contact y una cadena para la abreviatura del estado
    public AddPrimaryContact(Contact contact, String state) {
        this.contactToInsert = contact;
        this.stateAbbreviation = state;
    }

    // Método execute: se ejecuta cuando se pone en cola el trabajo
    public void execute(QueueableContext context) {
        // Consultar un máximo de 200 cuentas con la abreviatura de estado especificada
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :stateAbbreviation LIMIT 200];

        // Lista para los nuevos contactos
        List<Contact> contactsToInsert = new List<Contact>();

        // Crear un nuevo contacto para cada cuenta usando el método clone()
        for (Account account : accounts) {
            Contact newContact = (Contact) contactToInsert.clone();
            newContact.AccountId = account.Id;  // Asociar el contacto a la cuenta
            contactsToInsert.add(newContact);
        }

        // Insertar los contactos en una sola operación DML
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}