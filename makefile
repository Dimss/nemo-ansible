NAMESPACE := nemo

demo1-weight-native:
	# watch -n1 -d -c "oc exec $(oc get pods  | grep tkit | awk '{print $1}') -c tkit sh -- -c 'curl -s -H "Content-Type: application/json" http://identity/v1/system/info' | jq . -C "
	oc delete destinationrule identity
	oc delete destinationrule identity -n istio-system
	oc delete VirtualService identity
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags weight-native

demo1-weight-native-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags weight-native
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags identity

demo2-weight-identity-istio:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags weight-istio

demo2-weight-identity-istio-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags weight-istio
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags identity

demo3-weight-nvui-istio:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags nvui-weight-istio

demo3-weight-nvui-istio-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags nvui-weight-istio
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags ui

demo4-routing-header:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags nvui

demo4-routing-header-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags nvui
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags ui

demo5-lbhash:
	oc scale deployment identity --replicas=2
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags identity-lbhash
	# uuidgen
	# watch -n0.5 -d -c "curl -H 'x-app-test: user-app-123321' -s http://identity.nemo/v1/system/info | jq . -C "

demo5-lbhash-clean:
	oc scale deployment identity --replicas=1
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags identity-lbhash
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags identity

demo6-delay:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags delay

demo6-delay-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags delay
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags likes

demo7-abort:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags abort

demo7-abort-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags abort
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags likes

demo8-cb:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags cb
	oc scale deployment feed --replicas=2

demo8-cb-clean:
	oc scale deployment feed --replicas=1
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags cb
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags feed

demo9-mirror:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags mirror

demo9-mirror-clean:
	pgrep -f "telepresence -d tel" | xargs kill -9
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags mirror
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags feed

demo10-rbac:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags rbac
	oc adm policy add-scc-to-user anyuid -z feed-sa -n ${NAMESPACE}
	oc adm policy add-scc-to-user privileged -z feed-sa -n ${NAMESPACE}
	oc adm policy add-scc-to-user anyuid -z receiver-sa -n ${NAMESPACE}
	oc adm policy add-scc-to-user privileged -z receiver-sa -n ${NAMESPACE}

demo10-rbac-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags rbac
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags receiver
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags feed

demo11-filters:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags filters

demo11-filters-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags filters
