# spin node
anvil-node:
	anvil --chain-id 1337

anvil-node-auto:
	anvil --chain-id 1337 --block-time 15

1-deploy-fallback:
	forge script DeployFallbackScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

1-solve-fallback:
	forge script SolveFallbackScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

1-unit:
	forge test --match-path test/1_Fallback.t.sol -vvv

2-deploy-fallout:
	FOUNDRY_PROFILE=0_6_x forge script DeployFalloutScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

2-solve-fallout:
	FOUNDRY_PROFILE=0_6_x forge script SolveFalloutScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

2-unit:
	FOUNDRY_PROFILE=0_6_x  forge test --match-path test-0_6_x/2_Fallout.t.sol -vvv

3-deploy-coinflip:
	forge script DeployCoinFlipScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

3-solve-coinflip:
	forge script SolveCoinFlipScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

3-unit:
	forge test --match-path test/3_CoinFlip.t.sol -vvv
	
4-deploy-telephone:
	forge script DeployTelephoneScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

4-solve-telephone:
	forge script SolveTelephoneScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

4-unit:
	forge test --match-path test/4_Telephone.t.sol -vvv

6-deploy-delegation:
	forge script DeployDelegationScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

6-unit:
	forge test --match-path test/6_Delegation.t.sol -vvv

7-deploy-force:
	forge script DeployForceScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

7-solve-force:
	forge script SolveForceScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

7-unit:
	forge test --match-path test/7_Force.t.sol -vvv

8-deploy-vault:
	forge script DeployVaultScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

8-unit:
	forge test --match-path test/8_Vault.t.sol -vvv

9-deploy-king:
	forge script DeployKingScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

9-unit:
	forge test --match-path test/9_King.t.sol -vvv

10-deploy-reentrance:
	FOUNDRY_PROFILE=0_6_x forge script DeployReentranceScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

10-solve-reentrance:
	FOUNDRY_PROFILE=0_6_x forge script SolveReentranceScript --rpc-url $(call local_network,8545)  -vvv --broadcast; \

10-solve-reentrance2:
	FOUNDRY_PROFILE=0_6_x forge script SolveReentranceTwoScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

10-unit:
	FOUNDRY_PROFILE=0_6_x  forge test --match-path test-0_6_x/10_Reentrance.t.sol -vvv

10-snapshot:
	FOUNDRY_PROFILE=0_6_x  forge snapshot --match-path test-0_6_x/10_Reentrance.t.sol -vvv

11-deploy-elevator:
	forge script DeployElevatorScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

11-solve-elevator:
	forge script SolveElevatorScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

11-unit:
	forge test --match-path test/11_Elevator.t.sol -vvv

12_DeployPrivacy:
	forge script DeployPrivacyScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

12-unit:
	forge test --match-path test/12_Privacy.t.sol -vvv

13-deploy-gatekeeperone:
	forge script DeployGatekeeperOneScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

13-unit:
	forge test --match-path test/13_GatekeeperOne.t.sol -vvv

15-deploy-naughtcoin:
	forge script DeployNaughtCoinScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

15-unit:
	forge test --match-path test/15_NaughtCoin.t.sol -vvv

17-deploy-recovery:
	forge script DeployRecoveryScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

17-unit:
	forge test --match-path test/17_Recovery.t.sol -vvv

18-deploy-magicnumber:
	forge script DeployMagicNumberScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

18-unit:
	forge test --match-path test/18_MagicNumber.t.sol -vvv

# 19-deploy-aliencodex:
# 	FOUNDRY_PROFILE=0_5_x forge script DeployAlienCodexScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

19-unit:
	forge test --match-path test/19_AlienCodex.t.sol -vvv

20-deploy-denial:
	forge script DeployDenialScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

#  --block-gas-limit 1000000 
20-unit:
	forge test --gas-report  --match-path test/20_Denial.t.sol -vvv

21-deploy-shop:
	forge script DeployShopScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

21-solve-shop:
	forge script SolveShopScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

21-unit:
	forge test --match-path test/21_Shop.t.sol -vvv

23-deploy-dextwo:
	forge script DeployDexTwoScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

23-unit:
	forge test --match-path test/23_Dextwo.t.sol -vvv

cast-pretty:
	cast cast pretty-calldata \

cast-fallback-balance:
	cast balance 0x8464135c8f25da09e49bc8782676a84730c318bc \
	
cast-owner:
	cast call 0x8464135c8f25da09e49bc8782676a84730c318bc \
  	"owner()(address)" \

cast-top:
	cast call 0x8464135c8f25da09e49bc8782676a84730c318bc \
  	"top()(bool)" \

cast-price:
	cast call 0x8464135c8f25da09e49bc8782676a84730c318bc \
  	"price()(uint)" \

cast-balanceOF:
	cast call 0x8464135c8f25da09e49bc8782676a84730c318bc \
  	"balanceOf(address)(uint)" \
	0x663F3ad617193148711d28f5334eE4Ed07016602\

cast-balance:
	cast balance 0x8464135c8f25da09e49bc8782676a84730c318bc \

cast-solver:
	cast balance 0x663F3ad617193148711d28f5334eE4Ed07016602 \

cast-attacker:
	cast balance 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC \

cast-withdraw:
	cast send 0x663F3ad617193148711d28f5334eE4Ed07016602 \
	"withdrawETH(address,uint256)" 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC 3400000000000000000 --from \
	0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

define local_network
http://127.0.0.1:$1
endef