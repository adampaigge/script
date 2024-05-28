Shared Libraries
================

## scriptconsensus

The purpose of this library is to make the verification functionality that is critical to Script's consensus available to other applications, e.g. to language bindings.

### API

The interface is defined in the C header `scriptconsensus.h` located in  `src/script/scriptconsensus.h`.

#### Version

`scriptconsensus_version` returns an `unsigned int` with the API version *(currently at an experimental `0`)*.

#### Script Validation

`scriptconsensus_verify_script` returns an `int` with the status of the verification. It will be `1` if the input script correctly spends the previous output `scriptPubKey`.

##### Parameters
- `const unsigned char *scriptPubKey` - The previous output script that encumbers spending.
- `unsigned int scriptPubKeyLen` - The number of bytes for the `scriptPubKey`.
- `const unsigned char *txTo` - The transaction with the input that is spending the previous output.
- `unsigned int txToLen` - The number of bytes for the `txTo`.
- `unsigned int nIn` - The index of the input in `txTo` that spends the `scriptPubKey`.
- `unsigned int flags` - The script validation flags *(see below)*.
- `scriptconsensus_error* err` - Will have the error/success code for the operation *(see below)*.

##### Script Flags
- `scriptconsensus_SCRIPT_FLAGS_VERIFY_NONE`
- `scriptconsensus_SCRIPT_FLAGS_VERIFY_P2SH` - Evaluate P2SH ([BIP16](bips/bip-0016.mediawiki)) subscripts
- `scriptconsensus_SCRIPT_FLAGS_VERIFY_DERSIG` - Enforce strict DER ([BIP66](bips/bip-0066.mediawiki)) compliance
- `scriptconsensus_SCRIPT_FLAGS_VERIFY_NULLDUMMY` - Enforce NULLDUMMY ([BIP147](bips/bip-0147.mediawiki))

##### Errors
- `scriptconsensus_ERR_OK` - No errors with input parameters *(see the return value of `scriptconsensus_verify_script` for the verification status)*
- `scriptconsensus_ERR_TX_INDEX` - An invalid index for `txTo`
- `scriptconsensus_ERR_TX_SIZE_MISMATCH` - `txToLen` did not match with the size of `txTo`
- `scriptconsensus_ERR_DESERIALIZE` - An error deserializing `txTo`
- `scriptconsensus_ERR_AMOUNT_REQUIRED` - Input amount is required if WITNESS is used
