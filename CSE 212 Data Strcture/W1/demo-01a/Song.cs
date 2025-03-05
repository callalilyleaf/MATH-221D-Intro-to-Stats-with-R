namespace demo_01a;

public class Song
{
    public void main(String[] args)
    {
        List<int> list = new List<int> { 1, 2, 3 };
        Console.WriteLine(list.Count);
        
        // Add name & length properties
        list.Insert(0, 123);

        // Add play method
        void play()
        {
            foreach (int i in list)
            {
                Console.WriteLine($"Song Index{i}, Song Number{list[i]}");
            }
        }
    }

}