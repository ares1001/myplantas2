trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    // List to store tasks to be inserted
    List<Task> tasksToInsert = new List<Task>();

    // Iterate over each opportunity in the Trigger context
    for (Opportunity opp : Trigger.new) {
        // Check if the opportunity stage is "Closed Won"
        if (opp.StageName == 'Closed Won') {
            // Create a new task associated with this opportunity
            Task newTask = new Task();
            newTask.Subject = 'Follow Up Test Task';
            newTask.WhatId = opp.Id; // Associate the task with the opportunity
            newTask.Status = 'Not Started'; // Default status for the task
            tasksToInsert.add(newTask); // Add the task to the list
        }
    }

    // Perform a bulk insert of all tasks if there are any to insert
    if (!tasksToInsert.isEmpty()) {
        insert tasksToInsert;
    }
}