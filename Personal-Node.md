## First step

```shell
az account set --subscription "1e12321e-10cc-4ba1-af96-643b3ca05ace"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/1e12321e-10cc-4ba1-af96-643b3ca05ace"

# Set this to .zprofile

export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""
```

