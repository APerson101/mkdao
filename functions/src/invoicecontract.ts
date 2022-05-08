import { Client, ContractId, ContractCreateFlow } from "@hashgraph/sdk";

export async function deployInvoiceContract(clientel: Client): Promise<ContractId> {
  // create Invoice
  const contractByteCode = process.env.invoicebytecode || '';
  var invoiceContract = (await (await new ContractCreateFlow()
    .setBytecode(contractByteCode)
    .setGas(100_000)
    .execute(clientel)).getReceipt(clientel)).contractId;
  console.log(` new invoice contract is: ${invoiceContract} `);
  return invoiceContract!;
}