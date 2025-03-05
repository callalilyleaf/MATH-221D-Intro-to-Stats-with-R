using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Numerics;

class Program
{
    static Dictionary<int, BigInteger> memo = new Dictionary<int, BigInteger>();

    // 🔹 Recursive Factorial with Memoization
    static BigInteger FactorialRecursive(int n)
    {
        if (n <= 1) return 1;

        if (memo.ContainsKey(n)) return memo[n];

        memo[n] = n * FactorialRecursive(n - 1);
        return memo[n];
    }

    // 🔹 Iterative Factorial
    static BigInteger FactorialIterative(int n)
    {
        BigInteger result = 1;
        for (int i = 2; i <= n; i++)
            result *= i;
        return result;
    }

    static void Main()
    {
        Random rand = new Random();
        int[] testNumbers = new int[50];

        // Generate 50 random numbers between 1 and 50,000
        for (int i = 0; i < 50; i++)
            testNumbers[i] = rand.Next(1, 15001);

        Console.WriteLine("Benchmarking Factorial Calculations...\n");

        // Measure Recursive with Memoization Time
        Stopwatch stopwatch = Stopwatch.StartNew();
        foreach (var num in testNumbers)
            FactorialRecursive(num);
        stopwatch.Stop();
        Console.WriteLine($"Recursive with Memoization Time: {stopwatch.ElapsedMilliseconds} ms");

        // Measure Iterative Time
        stopwatch.Restart();
        foreach (var num in testNumbers)
            FactorialIterative(num);
        stopwatch.Stop();
        Console.WriteLine($"Iterative Time: {stopwatch.ElapsedMilliseconds} ms");
    }
}