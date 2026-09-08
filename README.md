# upwind-pr-block-demo

Tiny AstralJays lab for **Upwind PR blocking**.

- `main` is intentionally clean (baseline).
- Open a PR from `introduce-findings` to introduce **bad SCA** + **bad IaC**.
- Upwind checks `Upwind-Code-Sca` and `Upwind-Code-Iac` should fail when enforcement + required checks are enabled.

## Enablement checklist

1. Connect this repo in Upwind: **Code → Organizations & Repositories**
2. Set enforcement rules: **Code → Management** (Source code + IaC domains)
3. GitHub branch ruleset on `main`: require `Upwind-Code-Sca` and `Upwind-Code-Iac`
4. Open PR from `introduce-findings` → merge should block

Findings only **introduced** by the PR count toward block — not what already exists on `main`.
