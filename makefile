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
