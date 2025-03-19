package SortNumber;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class SortNumberTest {

    @Test
    void testBubbleSort() {
        int[] nums = {5, 3, 8, 6, 2};
        int[] expected = {2, 3, 5, 6, 8};
        SortNumber.bubbleSort(nums);
        assertArrayEquals(expected, nums);
    }

    @Test
    void testBubbleSortWithDuplicates() {
        int[] nums = {4, 2, 2, 8, 4};
        int[] expected = {2, 2, 4, 4, 8};
        SortNumber.bubbleSort(nums);
        assertArrayEquals(expected, nums);
    }

    @Test
    void testBubbleSortWithEmptyArray() {
        int[] nums = {};
        int[] expected = {};
        SortNumber.bubbleSort(nums);
        assertArrayEquals(expected, nums);
    }

    @Test
    void testBubbleSortWithSingleElement() {
        int[] nums = {1};
        int[] expected = {1};
        SortNumber.bubbleSort(nums);
        assertArrayEquals(expected, nums);
    }

    @Test
    void testSort() {
        int[] nums = {9, 7, 5, 3, 1};
        int[] expected = {1, 3, 5, 7, 9};
        SortNumber.sort(nums);
        assertArrayEquals(expected, nums);
    }

    @Test
    void testSortWithNegativeNumbers() {
        int[] nums = {-3, -1, -7, -5};
        int[] expected = {-7, -5, -3, -1};
        SortNumber.sort(nums);
        assertArrayEquals(expected, nums);
    }
}