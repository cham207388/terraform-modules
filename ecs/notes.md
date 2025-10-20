# Note

## Public IP

```bash
# Get the task ENI and its public IP
aws ecs list-tasks --cluster Learn-Gitlab-Prod \
| jq -r '.taskArns[]' \
| xargs -I {} aws ecs describe-tasks --cluster Learn-Gitlab-Prod --tasks {} \
| jq -r '.tasks[].attachments[] | select(.type=="ElasticNetworkInterface") | .details[] | select(.name=="networkInterfaceId") | .value' \
| xargs -I {} aws ec2 describe-network-interfaces --network-interface-ids {} \
| jq -r '.NetworkInterfaces[].Association.PublicIp'
```