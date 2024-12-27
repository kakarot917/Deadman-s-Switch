//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Switch {
    uint256 public lastCheckedIn;
    address public immutable owner;
    uint256 public constant checkInInterval = 10;
    address public constant successor =
        0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    constructor() {
        lastCheckedIn = block.timestamp;
        owner = msg.sender;
    }

    function deposit() public payable {
        (bool success, ) = address(this).call{value: msg.value}("");
        require(success, "Failed to send Ether");
    }

    function stillAlive() public {
        require(msg.sender == owner, "You are not the owner");
        lastCheckedIn = block.timestamp;
    }

    function transferAllMoneyIfOwnerIsDead() public {
        require(
            block.timestamp > lastCheckedIn + checkInInterval,
            "Owner is still alive"
        );
        (bool success, ) = successor.call{value: address(this).balance}("");
        require(success, "Failed to send Ether");
    }
}
