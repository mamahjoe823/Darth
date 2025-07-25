import { Cl } from "@stacks/transactions";
import { describe, expect, it } from "vitest";

/*
  The `simnet` and `accounts` objects are created by the `vitest-environment-clarinet` package
  and are globally available in your tests. See `vitest.config.ts` for details.
*/

const contract_name = "public-pledges";

describe("public-pledges contract", () => {
  // Get the accounts from the simnet configuration.
  const deployer = accounts.get("deployer")!;
  const user1 = accounts.get("wallet