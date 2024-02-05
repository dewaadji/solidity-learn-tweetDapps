// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Calculator {
    uint result = 0;

    function add(uint num) public {
        result += num;    
    } 

    function subtract(uint num) public {
        result -= num;
    }

    function multiply(uint num) public {
        result *= num;
    }

    function get() public view returns(uint) {
        return result;
    }
}