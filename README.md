## Usage

Compile the non-default versions first:
```
FOUNDRY_PROFILE=0_6_x forge build
FOUNDRY_PROFILE=0_5_x forge build
```
Compile the default version last:
```
forge build
```


Install the dependency with specific version
```
FOUNDRY_PROFILE=0_6_x forge install openzeppelin-0_6_x=openzeppelin/openzeppelin-contracts@v3.4.2
```
```
forge install openzeppelin/openzeppelin-contracts-upgradeable
```
---