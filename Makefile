# spin node
anvil-node:
	anvil --chain-id 1337

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

4-deploy-telephone:
	forge script DeployTelephoneScript --rpc-url $(call local_network,8545)  -vvvv --broadcast; \

4-unit:
	forge test --match-path test/4_Telephone.t.sol -vvv
	
cast-owner:
	cast call 0x8464135c8f25da09e49bc8782676a84730c318bc \
  	"owner()(address)" \

define local_network
http://127.0.0.1:$1
endef