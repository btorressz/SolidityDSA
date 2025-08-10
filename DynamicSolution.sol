// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicSolution {
    uint[] private data;

    // Function to add an element to the array
    function add(uint element) public {
        data.push(element);
    }

    // Function to get an element at a specific index
    function get(uint index) public view returns (uint) {
        require(index < data.length, "Index out of bounds");
        return data[index];
    }

    // Function to remove an element from the array
    // This removes the element by shifting all elements down, hence costly in terms of gas
    function remove(uint index) public {
        require(index < data.length, "Index out of bounds");
        
        for (uint i = index; i < data.length - 1; i++) {
            data[i] = data[i + 1];
        }
        data.pop();
    }

    // Function to return the entire array
    // Be careful with this in a real contract as it could run out of gas if the array is large
    function getAll() public view returns (uint[] memory) {
        return data;
    }

    // Function to get the length of the array
    function length() public view returns (uint) {
        return data.length;
    }
}
