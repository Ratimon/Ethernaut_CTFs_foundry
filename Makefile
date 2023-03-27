# spin node
anvil-node:
	anvil --chain-id 1337

anvil-node-auto:
	anvil --chain-id 1337 --block-time 5

1-deploy-fallback:
	forge script DeployFallbackScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

1-solve-fallback:
	forge script SolveFallbackScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

1-cast-fallback-balance:
	cast balance 0x8464135c8f25da09e49bc8782676a84730c318bc \

1-unit:
	forge test --match-path test/1_Fallback.t.sol -vvv

2-deploy-fallout:
	FOUNDRY_PROFILE=0_6_x forge script DeployFalloutScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

2-solve-fallout:
	FOUNDRY_PROFILE=0_6_x forge script SolveFalloutScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

2-unit:
	forge test --match-path test-0_6_x/2_Fallout.t.sol -vvv

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

11-deploy-elevator:
	forge script DeployElevatorScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

11-solve-elevator:
	forge script SolveElevatorScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

11-unit:
	forge test --match-path test/11_Elevator.t.sol -vvv

21-deploy-shop:
	forge script DeployShopScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

21-unit:
	forge test --match-path test/21_Shop.t.sol -vvv
	
cast-owner:
	cast call 0x8464135c8f25da09e49bc8782676a84730c318bc \
  	"owner()(address)" \

cast-top:
	cast call 0x8464135c8f25da09e49bc8782676a84730c318bc \
  	"top()(bool)" \

define local_network
http://127.0.0.1:$1
endef