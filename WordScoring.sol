// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WordScoring {
    struct WordData {
        string word;
        uint score;
    }

    WordData[] private wordsData;
    mapping(byte => uint) private letterCount; //ParserError: Expected elementary type name or identifier for mapping key type
   //contracts/WordScoring.sol:11:13:
   |
11 |     mapping(byte => uint) private letterCount;
   |             ^^^^

    mapping(byte => uint) private scoreByLetter;
    uint private maxScore = 0;

    constructor(string[] memory words, string[] memory letters, uint[] memory scores) {
        // Initialize words data and scores by letter
        for (uint i = 0; i < 26; i++) {
            scoreByLetter[byte(uint8(97 + i))] = scores[i]; // 'a' is 97 in ASCII
        }
        
        for (uint i = 0; i < letters.length; i++) {
            letterCount[bytes(letters[i])[0]]++;
        }
        
        // Calculate score for each word
        for (uint i = 0; i < words.length; i++) {
            uint wordScore = calculateWordScore(words[i]);
            wordsData.push(WordData(words[i], wordScore));
        }
    }
    
    function calculateWordScore(string memory word) private view returns (uint) {
        uint score = 0;
        bytes memory bWord = bytes(word);
        for (uint i = 0; i < bWord.length; i++) {
            score += scoreByLetter[bWord[i]];
        }
        return score;
    }
    
    // Main function to find the max score
    function findMaxScore() public returns (uint) {
        explore(0, letterCount, 0);
        return maxScore;
    }

    function explore(uint index, mapping(byte => uint) storage currentCount, uint currentScore) private {
        if (index == wordsData.length) {
            if (currentScore > maxHub) maxScore = currentScore;
            return;
        }
        
        // Option 1: Do not use this word
        explore(index + 1, currentCount, currentScore);
        
        // Option 2: Use this word if possible
        bytes memory bWord = bytes(wordsData[index].word);
        bool canUse = true;
        for (uint i = 0; i < bWord.length; i++) {
            if (currentCount[bWord[i]] == 0) {
                canUse = false;
                break;
            }
            currentCount[bWord[i]]--;
        }
        
        if (canUse) {
            explore(index + 1, currentCount, currentScore + wordsData[index].score);
            // Restore the count
            for (uint i = 0; i < bWord.length; i++) {
                currentCount[bWord[i]]++;
            }
        }
    }
}
