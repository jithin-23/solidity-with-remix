// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

//////////////////////////////////////////////////////
// 🔹 Approach 1: Using a Separate Contract to Track Payment
//////////////////////////////////////////////////////

// A standalone contract used just to store payment info
contract PaymentReceived {
    address public from;
    uint public amount;

    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }
}

contract Wallet1 {
    PaymentReceived public payment;

    function deposit() public payable {
        // ⚠️ Creates a new contract for each deposit (expensive in gas)
        payment = new PaymentReceived(msg.sender, msg.value);
    }
}

/*
🔍 Notes on Wallet1:
--------------------
✅ Advantages:
- Can isolate and encapsulate logic/data per payment (e.g., useful in modular or upgradable systems)
- Each `PaymentReceived` instance can act as a standalone record

❌ Disadvantages:
- Expensive gas cost due to deploying a contract on every deposit
- Not scalable for many payments
- Does not automatically store the actual ETH in the new PaymentReceived contract
- Overwrites `payment` each time (only latest is stored)

🧠 When to use:
- Only when you *really need* modular or on-chain isolated records with their own logic
- Rare for simple payment tracking
*/

//////////////////////////////////////////////////////
// 🔸 Approach 2: Using Structs to Track Payment
//////////////////////////////////////////////////////

contract Wallet2 {
    struct PaymentReceivedStruct {
        address from;
        uint amount;
    }

    PaymentReceivedStruct public payment;

    function deposit() public payable {
        // ✅ Structs are cheaper and simpler to use
        payment.amount = msg.value;
        payment.from = msg.sender;
    }
}

/*
🔍 Notes on Wallet2:
--------------------
✅ Advantages:
- Very low gas usage
- Clean, simple syntax
- Efficient for most payment tracking cases

❌ Disadvantages:
- Only one struct stored here; old data is overwritten (extend with array or mapping to store history)
- No isolated logic per payment (but usually not needed)

🧠 When to use:
- ✅ Best for simple tracking of payments
- ✅ Can be extended to `Payment[] public payments` or `mapping(address => Payment[])` for multiple users
- ✅ Most commonly used method in Solidity-based payment logs
*/

