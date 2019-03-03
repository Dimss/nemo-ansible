NAMESPACE := nemo

demo-routing-header:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE}" --tags nvui

demo-routing-header-clean:
	pipenv run ansible-playbook demos.yml --extra-vars "namespace=${NAMESPACE} state=absent" --tags nvui
	pipenv run ansible-playbook site.yml --extra-vars "namespace=${NAMESPACE}" --tags ui

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
