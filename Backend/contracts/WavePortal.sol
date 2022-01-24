// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal{
    //@dev total count of waves 
    uint256 totalWaves;
    //0xC22Be3DEC72e0e67d6D49E5763206b1511665Fd7
    uint256 private seed;
    mapping(address=>uint256) public lastWavedAt;
    string public won;
    event NewWave(address indexed from, uint256 timestamp, string message);

    constructor() payable{
        console.log("Follow Ritual!! Hellow World");

         seed = (block.timestamp + block.difficulty) % 100;
    }

    struct Waves{
        address waver;
        string message;
        uint256 timestamp;
    }

    Waves[] waves;

    function wave(string memory _message) public{
        
        require(lastWavedAt[msg.sender]+ 15 seconds < block.timestamp, "Wait 15 ms");
        won = "loose";
        totalWaves++;
         lastWavedAt[msg.sender] = block.timestamp;
        console.log("%s has waved", msg.sender);

        waves.push(Waves(msg.sender, _message, block.timestamp));

        seed = (block.timestamp + block.difficulty + seed)%100;
        console.log("Random # generated: %d", seed);

        if(seed < 50){
            won = "win";
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(prizeAmount <= address(this).balance, "Trying to withdraw more money than the contract has."); 
            (bool success, ) = (msg.sender).call{value:prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
         emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns(Waves[] memory){
        return waves; 
    }

    function getTotalWaves() public view returns(uint256){
        console.log("we have %d total waves!", totalWaves);
        return totalWaves;
    }
}

// @author Hardik Singh //