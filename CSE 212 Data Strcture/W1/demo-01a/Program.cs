using demo_01a;

// Input & Output
Console.WriteLine("Hello World!");
Console.ReadLine();

// Variables & Expressions
int x = 500 * 100; // -> 50000
int y = 500 / 100; // -> 5
int z = 500 % 100; // -> 0 Returns the division remainder

// Conditionals
if (x <= y && x != z || y == z)
{
    // &&: and
    // ||: or
}

// Loops
while (x > 1)
{
    
}

do
{
    x++;
} while (x < 100000);

for (int index = 1000; index < y; index++)
{
    
}

// Arrays
// fixed array
    var array1 = new int [3];
    array1[0] = 1;
    array1[1] = 2;
    array1[2] = 3;
    
    var array2 = new[] { 1, 2, 3 };
    
    int[] array3 = [1, 2, 3];

// dynamic array(List)
    var list1 = new List<int>();

    var list2 = new List<int>{1, 2, 3};

// Functions

// Classes