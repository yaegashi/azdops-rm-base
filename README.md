# dx2devops-rm-azdshared

## Deploy

```
$ azd env new shared1
$ azd env set DB_TYPE mysql
$ azd env set MS_TENANT_ID XXXXXXXX
$ azd env set MS_CLIENT_ID XXXXXXXX
$ azd env set MS_CLIENT_SECRET XXXXXXXX
$ azd provision
```
