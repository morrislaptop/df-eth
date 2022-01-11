// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;
pragma experimental ABIEncoderV2;

import "./DarkForestCore.sol";

// This code has not been professionally audited, therefore I cannot make any promises about
// safety or correctness. Use at own risk.
contract DarkForestPlayer {

    DarkForestCore immutable public coreContract;
    address public owner;

    struct Move {
        uint256[2] _a;
        uint256[2][2] _b;
        uint256[2] _c;
        uint256[13] _input;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller not owner");
        _;
    }

    constructor(address _owner, DarkForestCore _coreContract) {
        owner = _owner;
        coreContract = _coreContract;
    }

    // call and throw
    fallback(bytes calldata payload) external payable returns (bytes memory)  {
        (bool success, bytes memory result) = address(coreContract).call{value: msg.value}(payload);
        require(success, string(result));
        return result;
    }

    // delegeate call function
    // fallback() external payable {
    //     assembly {
    //         let _target := sload(0)
    //         calldatacopy(0x0, 0x0, calldatasize())
    //         let result := delegatecall(gas(), _target, 0x0, calldatasize(), 0x0, 0)
    //         returndatacopy(0x0, 0x0, returndatasize())
    //         switch result case 0 {revert(0, 0)} default {return (0, returndatasize())}
    //     }
    // }

    // raw call fucntion
    // function setA_ASM(uint _val) public returns (uint answer) {
    //     bytes4 sig = bytes4(keccak256("setA(uint256)"));
    //     assembly {
    //         // move pointer to free memory spot
    //         let ptr := mload(0x40)
    //         // put function sig at memory spot
    //         mstore(ptr,sig)
    //         // append argument after function sig
    //         mstore(add(ptr,0x04), _val)

    //         let result := call(
    //           15000, // gas limit
    //           sload(dc_slot),  // to addr. append var to _slot to access storage variable
    //           0, // not transfer any ether
    //           ptr, // Inputs are stored at location ptr
    //           0x24, // Inputs are 36 bytes long
    //           ptr,  //Store output over input
    //           0x20) //Outputs are 32 bytes long
            
    //         if eq(result, 0) {
    //             revert(0, 0)
    //         }
            
    //         answer := mload(ptr) // Assign output to answer var
    //         mstore(0x40,add(ptr,0x24)) // Set storage pointer to new space
    //     }
    // }

    // abi call function
    // function initializePlayer(
    //     uint256[2] memory _a,
    //     uint256[2][2] memory _b,
    //     uint256[2] memory _c,
    //     uint256[8] memory _input
    // ) external onlyOwner returns (uint256) {
    //     return coreContract.initializePlayer(_a, _b, _c, _input);
    // }

    function move(
        uint256[2] memory _a,
        uint256[2][2] memory _b,
        uint256[2] memory _c,
        uint256[13] memory _input
    ) public onlyOwner returns (uint256) {
        return coreContract.move(_a, _b, _c, _input);
    }

    function batchMove(Move[] memory _moves) public onlyOwner returns (uint256) {
        for (uint i = 0; i < _moves.length; i++) {
            coreContract.move(_moves[i]._a, _moves[i]._b, _moves[i]._c, _moves[i]._input);
        }
    }

    function batchMove2(
        uint256[2][] memory _as,
        uint256[2][2][] memory _bs,
        uint256[2][] memory _cs,
        uint256[13][] memory _inputs
    ) public onlyOwner returns (uint256) {
        for (uint i = 0; i < _as.length; i++) {
            coreContract.move(_as[i], _bs[i], _cs[i], _inputs[i]);
        }
    }

    /**
     * function move(
        uint256[2] memory _a,
        uint256[2][2] memory _b,
        uint256[2] memory _c,
        uint256[13] memory _input
    ) public notPaused returns (uint256) {
     */
    // function batchMove() {

    // }
}
