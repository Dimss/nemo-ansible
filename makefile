NAMESPACE := nemo

demo-weight-native:
	# watch -n1 -d -c "oc exec $(oc get pods  | grep tkit | awk '{print $1}') -c tkit sh -- -c 'curl -s -H "Content-Type: application/json" http://identity/v1/system/info' | jq . -C "
	oc delete destinationrule identity
	oc delete destinationrule identity -n istio-system
	oc delete VirtualService identity
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags weight-native

demo-weight-native-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags weight-native
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags identity

demo-weight-identity-istio:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags weight-istio

demo-weight-identity-istio-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags weight-istio
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags identity

demo-weight-nvui-istio:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags nvui-weight-istio

demo-weight-nvui-istio-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags nvui-weight-istio
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags ui

demo-routing-header:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags nvui

demo-routing-header-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags nvui
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags ui

demo-lbhash:
	oc scale deployment identity --replicas=2
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags identity-lbhash
	# uuidgen
	# watch -n0.5 -d -c "curl -H 'x-app-test: user-app-123321' -s http://identity.nemo/v1/system/info | jq . -C "

demo-lbhash-clean:
	oc scale deployment identity --replicas=1
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags identity-lbhash
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags identity

demo-delay:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags delay

demo-delay-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags delay
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags likes

demo-abort:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags abort

demo-abort-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags abort
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags likes

demo-cb:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags cb
	oc scale deployment feed --replicas=2

demo-cb-clean:
	oc scale deployment feed --replicas=1
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags cb
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags feed

demo-mirror:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags mirror

demo-mirror-clean:
	pgrep -f "telepresence -d tel" | xargs kill -9
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags mirror
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags feed

demo-filters:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags filters

demo-filters-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags filters
