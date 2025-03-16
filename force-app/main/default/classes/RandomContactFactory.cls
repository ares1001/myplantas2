public class RandomContactFactory {
    //Metodo estatico publico que genera una lista de contactos
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String commonLastName){
        //Crear una lista vacia de contactos
    List<Contact> contacts = new List<Contact>();
        
        //Bucle para generar contactos con nombres unicos
        for (Integer i =0; i<numberOfContacts; i ++){
            
            //Crear un nuevo contacto con un nombre unico y un apellido
        Contact newContact = new Contact (
        FirstName = 'Prueba' + i,
        LastName= commonLastName
        );
        //Agregar el contacto a la lista
        contacts.add(newContact);
        }
        
        //Devolver la lista de contactos generados
    return contacts;
    }

}