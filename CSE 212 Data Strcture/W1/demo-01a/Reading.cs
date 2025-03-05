// namespace demo_01a;
//
// public class Reading
// {
//     // Create a fixed array:
//     // An array can only store the same datatype variables
//         
//         // First method, Classic way. Best for create an empty array and you fill out later
//         private var numbers = new int [3]; // create 3 default values in the array, which are 0  
//         
//         numbers[0] = 1;
//         numbers[1] = 2;
//         numbers[2] = 3;
//         
//         // Second Method
//         var numbers = new[] {1, "2", 3};
//         
//         // Third Method, lastest one
//         private int[] numbers = [1, 2, 3]; // You need to know the datatype of contents first
//         
//     // Create a dynamic array: 
//     // In c#: using a 'List' object
//     
//         // First method, you already know about it!
//         private var numbers = new List<int>();
//         numbers.Add(1);
//         numbers.Add(2);
//         numbers.Add(3);
//         
//         // Second method, create the list with contents in the list
//         private var numbers = new List<int> { 1, 2, 3 };
//     
//     // Common Dynamic Array Operations in C#:
//         private int value = numbers[0]; // value = myList[index]
//                                // Gets the value at the specific index
//         
//         numbers.Add(3); // myList.Add(value)
//                        // Adds "value" to the next available index.
//         
//         numbers.Insert(0, 100); // myList.Insert(index, value)
//                                // Adds "value" to the specified index and moves subsequent items to the next index(right)
//                                
//         numbers.Remove(0); // myList.Remove(index)
//                           // Removes the item at the specified index and moves subsequent items to the previous index(Left)
//     
//         numbers.Count; // myList.Count
//                        // Return the size of the dynamic array
//                        
//         numbers.Capacity // myList.Capacity
//                          // Return the capacity of the dynamic array
//         
//         numbers.Count === 0 // myList.Count == 0 Returns true if the length of the dynamic array is zero
//         
//     // Looping through list or array
//         foreach (var item in myList)
//         {
//             Console.WriteLine(item);
//         }
//
//         for (var index = 0; index < myList.Count; index++) // List.Count
//         {
//            Console.WriteLine(myList[index]); 
//         }
//
//         for (var index = 0; index < myArray.Length; index++)
//         {
//             Console.WriteLine(myArray[index]);
//         }
//         
//             
// }
