# Istio recipes

### Setup demo environment
- Install pipenv for Python3 (if your python version is not 3.6, update Pipefile with correct version for your environment)
- `pipenv install`
- `pipenv run ansible-playbook site.yml --extra-vars "namespace=REPLACE_WITH_NAMESPACE run_prereq=true"`

Architecture


### Istio traffic shifting/routing
- K8S native RR routing
```
make demo1-weight-native       # run to deploy
make demo1-weight-native-clean # run to remove
```
- Istio weight routing for backends system (REST)
```
make demo2-weight-identity-istio       # run to deploy
make demo2-weight-identity-istio-clean # run to remove
```
- Istio weight routing for frontend SPA, Static HTML, etc..
```
make demo3-weight-nvui-istio             # run to deploy
make demo3-weight-nvui-istio-clean       # run to remove
```
- Istio routing based on HTTP headers  
```
make demo4-routing-header             # run to deploy
make demo4-routing-header-clean       # run to remove
```
- Istio Load balancer - Consistent Hash (header/source ip)
```
make demo5-lbhash             # run to deploy
make demo5-lbhash-clean       # run to remove
# for testing: uuidgen
# for testing: watch -n0.5 -d -c "curl -H 'x-app-test: REPLACE_WITH_UUID' -s http://identity.nemo/v1/system/info | jq . -C "
```

### Istio traffic resilience
- Istio fault injection - delays
```
make demo6-delay             # run to deploy
make demo6-delay-clean       # run to remove
```
- Istio fault injection - abort
```
make demo7-abort             # run to deploy
make demo7-abort-clean       # run to remove
```
-Istio circuit breaker    
```
make demo8-cb             # run to deploy
make demo8-cb-clean       # run to remove
```
- Istio traffic mirroring & debugging
```
make demo9-mirror             # run to deploy
make demo9-mirror-clean       # run to remove
```

### Istio authorization
- RBAC
```
make demo10-rbac            # run to deploy
make demo10-rbac-clean      # run to remove
```

### Istio Envoy filters
- Envoy Lua filter
```
make demo11-filters      # run to deploy
make demo11-filters      # run to remove
```
