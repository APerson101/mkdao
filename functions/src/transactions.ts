import { Client, ContractCreateFlow } from "@hashgraph/sdk";

export async function deployTransactionsContract(creatorClient: Client) {
  const transactionsbytecode = process.env.invoicebytecode || '';
  var invoiceContract = (await (await new ContractCreateFlow()
    .setBytecode(transactionsbytecode)
    .setGas(100_000)
    .execute(creatorClient)).getReceipt(creatorClient)).contractId;
  console.log(` new transactions contract is: ${invoiceContract} `);
  return invoiceContract!;
}