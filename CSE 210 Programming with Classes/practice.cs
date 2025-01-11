using System;

public class Menu
{
    private Journal journal;
    private PromptManager promptManager;

    public Menu()
    {
        journal = new Journal();
        promptManager = new PromptManager();
    }

    // Method to display menu options and handle the user's selection
    public void DisplayOptions()
    {
        while (true)
        {
            Console.WriteLine("Choose an option:");
            Console.WriteLine("1. Add new journal entry");
            Console.WriteLine("2. Display all entries");
            Console.WriteLine("3. Exit");

            string choice = Console.ReadLine();
            switch (choice)
            {
                case "1":
                    AddNewEntry();
                    break;
                case "2":
                    journal.DisplayEntries();
                    break;
                case "3":
                    return;
                default:
                    Console.WriteLine("Invalid option. Please try again.");
                    break;
            }
        }
    }

    // Method to add a new journal entry
    private void AddNewEntry()
    {
        string prompt = promptManager.GetRandomPrompt();  // Get a random prompt
        Entry entry = new Entry();
        entry.CreateEntry(prompt);  // Create a new entry
        journal.AddEntry(entry);  // Add the entry to the journal
    }
}
