import { Client, ContractId, ContractCreateFlow } from "@hashgraph/sdk";

export async function deployInvoiceContract(creatorClient: Client): Promise<ContractId> {
  // create Invoice
  const invoicecontractByteCode = process.env.invoicebytecode || '';
  var invoiceContract = (await (await new ContractCreateFlow()
    .setBytecode(invoicecontractByteCode)
    .setGas(100_000)
    .execute(creatorClient)).getReceipt(creatorClient)).contractId;
  console.log(` new invoice contract is: ${invoiceContract} `);
  return invoiceContract!;
}