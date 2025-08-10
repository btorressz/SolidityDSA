// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayPatching {
    function minPatches(int[] memory nums, uint n) public pure returns (uint) {
        uint patches = 0;
        uint x = 0; // This will track the maximum sum we can form
        uint i = 0;
        
       while( x < n ){
      if( i < nums.length && uint(nums[i]) <= x + 1){  // Convert int to uint here
        x += uint(nums[i]);   // And again here
         i++;
     } else {
        x += 2 * (x + 1);    // and also in this line
        patches++;           
    }
}
        
        return patches;
    }
}
