// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PeopleSorter {
    struct Person {
        string name;
        uint height;
    }

    function sortPeople(string[] memory names, uint[] memory heights) public pure returns (string[] memory) {
        require(names.length == heights.length, "Arrays must have the same length");
        uint n = names.length;
        
        // Create an array of Person structs
        Person[] memory people = new Person[](n);
        for (uint i = 0; i < n; i++) {
            people[i] = Person(names[i], heights[i]);
        }
        
        // Sort the people array
        quickSort(people, int(0), int(n - 1));
        
        // Extract sorted names
        string[] memory sortedNames = new string[](n);
        for (uint i = 0; i < n; i++) {
            sortedNames[i] = people[i].name;
        }
        
        return sortedNames;
    }
    
    function quickSort(Person[] memory arr, int left, int right) private pure {
        int i = left;
        int j = right;
        if (i == j) return;
        uint pivot = arr[uint(left + (right - left) / 2)].height;
        while (i <= j) {
            while (arr[uint(i)].height > pivot) i++;
            while (pivot > arr[uint(j)].height) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }
}