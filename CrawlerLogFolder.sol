// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrawlerLogFolder {
    function minOperations(string[] memory logs) public pure returns (int) {
        int depth = 0;
        
        for (uint i = 0; i < logs.length; i++) {
            string memory op = logs[i];
            
            if (keccak256(bytes(op)) == keccak256(bytes("../"))) {
                if (depth > 0) {
                    depth--;
                }
            } else if (keccak256(bytes(op)) != keccak256(bytes("./"))) {
                depth++;
            }
        }
        
        return depth;  // Return the depth as the number of steps to return to the main folder
    }
}
