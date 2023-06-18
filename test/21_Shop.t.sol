// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployShopScript} from "@script/21_DeployShop.s.sol";

import {Shop} from "@main/21_Shop.sol";
import {ShopAttacker} from "@main/21_ShopAttacker.sol";

contract ShopTest is Test, DeployShopScript {
    address public deployer;
    address public attacker = address(11);

    ShopAttacker shopAttacker;

    function setUp() public {
        vm.label(attacker, "Attacker");
        vm.deal(attacker, 1 ether);

        DeployShopScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq(shopChallenge.price(), 100);

        shopAttacker = new ShopAttacker(address(shopChallenge));
        shopAttacker.attack();

        assertEq(shopChallenge.price(), 10);

        vm.stopPrank();
    }
}
