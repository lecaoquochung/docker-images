package SortNumber;

import java.util.Arrays;

public class SortNumber {

  // build-in sort method
  public static void sort(int[] nums) {
    Arrays.sort(nums);
    for (int i = 0; i < nums.length; i++) {
      System.out.println(nums[i]);
    }
  }

  // Method to sort an array using Bubble Sort
  public static void bubbleSort(int[] nums) {
    int n = nums.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (nums[j] > nums[j + 1]) {
          // Swap nums[j] and nums[j + 1]
          int temp = nums[j];
          nums[j] = nums[j + 1];
          nums[j + 1] = temp;
        }
      }
    }

    // Print the sorted array
    for (int i = 0; i < nums.length; i++) {
      System.out.println(nums[i]);
    }
  }

  public static void main(String[] args) {
    int[] nums = {1, 10, 7, 3}; // Example array
    bubbleSort(nums); // Call the sort method
  }
}

// possible array sort algorithm
// 1. Bubble Sort
// Repeatedly compares adjacent elements and swaps them if they are in the wrong order.
// Simple but inefficient for large datasets.
// 2. Selection Sort
// Finds the smallest (or largest) element in the unsorted part of the array and swaps it with the first unsorted element.
// Inefficient for large datasets but easy to implement.
// 3. Insertion Sort
// Builds the sorted array one element at a time by inserting each element into its correct position.
// Efficient for small or nearly sorted datasets.
// 4. Merge Sort
// Divides the array into halves, recursively sorts them, and then merges the sorted halves.
// Efficient with a time complexity of O(n log n).
// 5. Quick Sort
// Selects a "pivot" element, partitions the array around the pivot, and recursively sorts the partitions.
// Very efficient for large datasets but can degrade to O(n²) in the worst case.
// 6. Heap Sort
// Builds a max heap (or min heap) from the array and repeatedly extracts the largest (or smallest) element.
// Time complexity is O(n log n).
// 7. Radix Sort
// Sorts numbers digit by digit, starting from the least significant digit.
// Works well for integers and has a time complexity of O(nk), where k is the number of digits.
// 8. Counting Sort
// Counts the occurrences of each element and uses this information to place elements in the correct position.
// Works only for integers and has a time complexity of O(n + k), where k is the range of input values.
// 9. Bucket Sort
// Divides the array into buckets, sorts each bucket individually (using another sorting algorithm), and then combines the buckets.
// Efficient for uniformly distributed data.
// 10. Shell Sort
// A variation of insertion sort that allows the exchange of far-apart elements.
// Uses a gap sequence to improve efficiency.
// 11. Cocktail Sort
// A variation of bubble sort that sorts in both directions alternately.
// Slightly more efficient than bubble sort.
// 12. Comb Sort
// Improves bubble sort by using a larger gap between compared elements.
// Reduces the gap over iterations.
// 13. Gnome Sort
// Similar to insertion sort but swaps elements to their correct position by moving backward.
// Simple but inefficient.
// 14. Pancake Sort
// Sorts the array by repeatedly flipping the largest unsorted element to the top and then to its correct position.
// Inefficient but interesting.
// 15. Cycle Sort
// Minimizes the number of writes by placing each element directly in its correct position.
// Useful for situations where memory writes are expensive.
// 16. Stooge Sort
// Recursively sorts the first two-thirds and last two-thirds of the array, then the first two-thirds again.
// Inefficient with a time complexity of O(n².709).
// 17. Bitonic Sort
// A parallel sorting algorithm that works by creating a bitonic sequence and then sorting it.
// Used in parallel computing.
// 18. Bozo Sort
// Randomly shuffles the array until it is sorted.
// Extremely inefficient and used only for educational purposes.
// 19. Bogo Sort
// Randomly permutes the array until it is sorted.
// Inefficient with a time complexity of O((n+1)!) in the worst case.
// 20. Sleep Sort
// Uses the time taken by threads to "sleep" to determine the order of elements.
// More of a conceptual algorithm than practical.
// 21. Spread Sort
// A hybrid sorting algorithm that combines distribution-based sorting with comparison-based sorting.
// Efficient for large datasets.
// 22. Smooth Sort
// A variation of heap sort that takes advantage of existing order in the array.
// More efficient than heap sort for nearly sorted data.
// 23. Timsort
// A hybrid sorting algorithm derived from merge sort and insertion sort.
// Used in Python and Java standard libraries.
// 24. Block Sort
// A stable sorting algorithm that uses blocks of data to improve efficiency.
// Similar to merge sort.
// 25. Brick Sort
// A variation of bubble sort that compares and swaps elements in a brick-like pattern.
// Also known as odd-even sort.
// 26. Burstsort
// A string sorting algorithm that uses buckets and tries to improve efficiency.
// Designed for sorting strings.
// 27. Bead Sort
// Simulates the natural process of beads falling under gravity to sort numbers.
// Works only for positive integers.
// 28. Binary Insertion Sort
// A variation of insertion sort that uses binary search to find the correct position for each element.
// Reduces comparisons but not swaps.
// 29. Cartesian Tree Sorting
// Uses a Cartesian tree to sort elements.
// Rarely used in practice.
// 30. Cocktail Shaker Sort
// Another name for cocktail sort (already explained above).
// 31. Cube Sort
// A parallel sorting algorithm that uses a hypercube structure.
// Used in distributed systems.
// 32. Flash Sort
// A distribution-based sorting algorithm that works well for uniformly distributed data.
// Time complexity is O(n) in the best case.
// 33. Fringe Sort
// A hybrid sorting algorithm that combines quicksort and merge sort.
// Efficient for large datasets.
// 34. Gapped Insertion Sort
// A variation of insertion sort that uses gaps to improve efficiency.
// Similar to shell sort.
// 35. Introsort
// A hybrid sorting algorithm that switches between quicksort, heapsort, and insertion sort based on the input size.
// Used in C++ standard libraries.
// 36. Library Sort
// A variation of insertion sort that uses gaps to improve efficiency.
// Also known as gapped insertion sort.
// 37. Odd-Even Sort
// A parallel sorting algorithm that compares and swaps odd and even indexed elements alternately.
// Used in parallel computing.
// 38. Patience Sorting
// A sorting algorithm inspired by the card game "Patience."
// Used in the longest increasing subsequence problem.
// 39. Pigeonhole Sort
// Places elements into "pigeonholes" based on their value and then collects them in order.
// Works only for integers.
// 40. Postman Sort
// A distribution-based sorting algorithm.
// Rarely used in practice.
// 41. Proxmap Sort
// Uses a mapping function to distribute elements into buckets.
// Efficient for certain datasets.
// 42. Quickselect
// A selection algorithm to find the k-th smallest element in an array.
// Related to quicksort.
// 43. Radix Exchange Sort
// A variation of radix sort that works recursively.
// Efficient for integers.
// 44. Recursive Insertion Sort
// A recursive implementation of insertion sort.
// Inefficient for large datasets.
// 45. Strand Sort
// A recursive sorting algorithm that repeatedly extracts sorted sublists.
// Inefficient for large datasets.
// 46. Topological Sort
// Sorts vertices of a directed acyclic graph (DAG) in topological order.
// Used in graph algorithms.
// 47. Tournament Sort
// Builds a tournament tree to find the smallest element and repeats the process.
// Inefficient compared to other algorithms.
// 48. Weak Heap Sort
// A variation of heap sort that uses a weak heap structure.
// More efficient than traditional heap sort.
// 49. Sorting Networks
// A parallel sorting algorithm that uses a fixed sequence of comparisons.
// Used in hardware implementations.
// 50. Spaghetti Sort
// Simulates sorting by the lengths of spaghetti strands.
// Conceptual and impractical.
