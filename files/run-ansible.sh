#!/bin/bash
#set -xve

WORKING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

source ${WORKING_DIR}/step-0-color.sh

source ${WORKING_DIR}/step-1-os.sh

if [ -n "${TARGET_SLAVE}" ]; then
  echo -e "${green} TARGET_SLAVE is defined ${happy_smiley} : ${TARGET_SLAVE} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : TARGET_SLAVE, use the default one ${NC}"
  export TARGET_SLAVE=albandri-test.misys.global.ad
  echo -e "${magenta} TARGET_SLAVE : ${TARGET_SLAVE} ${NC}"
fi

if [ -n "${TARGET_PLAYBOOK}" ]; then
  echo -e "${green} TARGET_PLAYBOOK is defined ${happy_smiley} : ${TARGET_PLAYBOOK} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : TARGET_PLAYBOOK, use the default one ${NC}"
  export TARGET_PLAYBOOK=jenkins-full.yml
  echo -e "${magenta} TARGET_PLAYBOOK : ${TARGET_PLAYBOOK} ${NC}"
fi

if [ -n "${DRY_RUN}" ]; then
  echo -e "${green} DRY_RUN is defined ${happy_smiley} : ${DRY_RUN} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : DRY_RUN, use the default one ${NC}"
  export DRY_RUN="--check"
  echo -e "${magenta} DRY_RUN : ${DRY_RUN} ${NC}"
fi

if [ -n "${DOCKER_RUN}" ]; then
  echo -e "${green} DOCKER_RUN is defined ${happy_smiley} : ${DOCKER_RUN} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : DOCKER_RUN, use the default one ${NC}"
  export DOCKER_RUN=""
  echo -e "${magenta} DOCKER_RUN : ${DOCKER_RUN} ${NC}"
fi

if [ -n "${ANSIBLE_INVENTORY}" ]; then
  echo -e "${green} ANSIBLE_INVENTORY is defined ${happy_smiley} : ${ANSIBLE_INVENTORY} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : ANSIBLE_INVENTORY, use the default one ${NC}"
  export ANSIBLE_INVENTORY="production"
  echo -e "${magenta} ANSIBLE_INVENTORY : ${ANSIBLE_INVENTORY} ${NC}"
fi

if [ -n "${ANSIBLE_INVENTORY_OUTPUT_DIR}" ]; then
  echo -e "${green} ANSIBLE_INVENTORY_OUTPUT_DIR is defined ${happy_smiley} : ${ANSIBLE_INVENTORY_OUTPUT_DIR} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : ANSIBLE_INVENTORY_OUTPUT_DIR, use the default one ${NC}"
  export ANSIBLE_INVENTORY_OUTPUT_DIR="out/" # default is ~/.ansible.log
  echo -e "${magenta} ANSIBLE_INVENTORY_OUTPUT_DIR : ${ANSIBLE_INVENTORY_OUTPUT_DIR} ${NC}"
fi

if [ -n "${JUNIT_OUTPUT_DIR}" ]; then
  echo -e "${green} JUNIT_OUTPUT_DIR is defined ${happy_smiley} : ${JUNIT_OUTPUT_DIR} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : JUNIT_OUTPUT_DIR, use the default one ${NC}"
  export JUNIT_OUTPUT_DIR="target"
  echo -e "${magenta} JUNIT_OUTPUT_DIR : ${JUNIT_OUTPUT_DIR} ${NC}"
fi

if [ -n "${ANSIBLE_CMD}" ]; then
  echo -e "${green} ANSIBLE_CMD is defined ${happy_smiley} : ${ANSIBLE_CMD} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : ANSIBLE_CMD, use the default one ${NC}"
  # if virtualenv is not used and there is system installation
  # of python3, it should be used
  if [[ -z $VIRTUAL_ENV ]]
  then
    #/usr/bin/ansible for RedHat
    #/usr/local/bin/ansible for Ubuntu
    if [ "${OS}" == "Ubuntu" ]; then
      ANSIBLE_CMD="${PYTHON_CMD} /usr/local/bin/ansible"
    else
      ANSIBLE_CMD="${PYTHON_CMD} /usr/bin/ansible"
    fi
  else
    ANSIBLE_CMD="ansible"
  fi
  export ANSIBLE_CMD
  echo -e "${magenta} ANSIBLE_CMD : ${ANSIBLE_CMD} ${NC}"
fi

if [ -n "${ANSIBLE_CMBD_CMD}" ]; then
  echo -e "${green} ANSIBLE_CMBD_CMD is defined ${happy_smiley} : ${ANSIBLE_CMBD_CMD} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : ANSIBLE_CMBD_CMD, use the default one ${NC}"

  # if virtualenv is not used and there is system installation
  # of python3, it should be used
  if [[ -z $VIRTUAL_ENV ]]
  then
    #/usr/bin/ansible-cmdb for RedHat
    #/usr/local/bin/ansible-cmdb for Ubuntu
    if [ "${OS}" == "Ubuntu" ]; then
      ANSIBLE_CMBD_CMD="/usr/local/bin/ansible-cmdb"
    else
      ANSIBLE_CMBD_CMD="/usr/bin/ansible-cmdb"
    fi
  else
    #ANSIBLE_CMBD_CMD="${VIRTUAL_ENV}/bin/ansible-cmdb"
    ANSIBLE_CMBD_CMD="ansible-cmdb"
  fi
  export ANSIBLE_CMBD_CMD
  echo -e "${magenta} ANSIBLE_CMBD_CMD : ${ANSIBLE_CMBD_CMD} ${NC}"
fi

if [ -n "${ANSIBLE_GALAXY_CMD}" ]; then
  echo -e "${green} ANSIBLE_GALAXY_CMD is defined ${happy_smiley} : ${ANSIBLE_GALAXY_CMD} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : ANSIBLE_GALAXY_CMD, use the default one ${NC}"
  # if virtualenv is not used and there is system installation
  # of python3, it should be used
  if [[ -z $VIRTUAL_ENV ]]
  then
    #/usr/bin/ansible-galaxy for RedHat
    #/usr/local/bin/ansible-galaxy for Ubuntu
    if [ "${OS}" == "Ubuntu" ]; then
      ANSIBLE_GALAXY_CMD="${PYTHON_CMD} /usr/local/bin/ansible-galaxy"
    else
      ANSIBLE_GALAXY_CMD="${PYTHON_CMD} /usr/bin/ansible-galaxy"
    fi
  else
    ANSIBLE_GALAXY_CMD="ansible-galaxy"
  fi
  export ANSIBLE_GALAXY_CMD
  echo -e "${magenta} ANSIBLE_GALAXY_CMD : ${ANSIBLE_GALAXY_CMD} ${NC}"
fi

if [ -n "${ANSIBLE_PLAYBOOK_CMD}" ]; then
  echo -e "${green} ANSIBLE_PLAYBOOK_CMD is defined ${happy_smiley} : ${ANSIBLE_PLAYBOOK_CMD} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : ANSIBLE_PLAYBOOK_CMD, use the default one ${NC}"
  # if virtualenv is not used and there is system installation
  # of python3, it should be used
  if [[ -z $VIRTUAL_ENV ]]
  then
    #/usr/bin/ansible-playbook for RedHat
    #/usr/local/bin/ansible-playbook for Ubuntu
    if [ "${OS}" == "Ubuntu" ]; then
      ANSIBLE_PLAYBOOK_CMD="${PYTHON_CMD} /usr/local/bin/ansible-playbook"
    else
      ANSIBLE_PLAYBOOK_CMD="${PYTHON_CMD} /usr/bin/ansible-playbook"
    fi
  else
    ANSIBLE_PLAYBOOK_CMD="ansible-playbook"
  fi
  export ANSIBLE_PLAYBOOK_CMD
  echo -e "${magenta} ANSIBLE_PLAYBOOK_CMD : ${ANSIBLE_PLAYBOOK_CMD} ${NC}"
fi

if [ -n "${ANSIBLE_LINT_CMD}" ]; then
  echo -e "${green} ANSIBLE_LINT_CMD is defined ${happy_smiley} : ${ANSIBLE_LINT_CMD} ${NC}"
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : ANSIBLE_LINT_CMD, use the default one ${NC}"
  # if virtualenv is not used and there is system installation
  # of python3, it should be used
  if [[ -z $VIRTUAL_ENV ]]
  then
    #/usr/bin/ansible-lint for RedHat
    #/usr/local/bin/ansible-lint for Ubuntu
    if [ "${OS}" == "Ubuntu" ]; then
      ANSIBLE_LINT_CMD="${PYTHON_CMD} /usr/local/bin/ansible-lint"
    else
      ANSIBLE_LINT_CMD="${PYTHON_CMD} /usr/bin/ansible-lint"
    fi
  else
    ANSIBLE_LINT_CMD="ansible-lint"
  fi
  export ANSIBLE_LINT_CMD
  echo -e "${magenta} ANSIBLE_LINT_CMD : ${ANSIBLE_LINT_CMD} ${NC}"
fi

echo -e "${cyan} =========== ${NC}"
echo -e "${green} Ansible vault password. ${NC}"
if [ -n "${ANSIBLE_VAULT_PASS}" ]; then
  echo -e "${green} ANSIBLE_VAULT_PASS is defined ${happy_smiley} : *** ${NC}"
  echo "${ANSIBLE_VAULT_PASS}" > vault.passwd || true
else
  echo -e "${red} ${double_arrow} Undefined build parameter ${head_skull} : ANSIBLE_VAULT_PASS, use the default one ${NC}"
  exit 1
fi

lsb_release -a

# DOCKER
export DOCKER_CLIENT_TIMEOUT=240
export COMPOSE_HTTP_TIMEOUT=2000

echo -e " ======= Running on ${TARGET_SLAVE} ${reverse_exclamation} ${NC}"
echo "USER : $USER"
echo "HOME : $HOME"
echo "WORKSPACE : $WORKSPACE"

echo "DOCKER_CLIENT_TIMEOUT : $DOCKER_CLIENT_TIMEOUT"
echo "COMPOSE_HTTP_TIMEOUT : $COMPOSE_HTTP_TIMEOUT"

#tomcat8 must be stop to no use same port
#${USE_SUDO} service tomcat8 stop || true

echo -e "${cyan} =========== ${NC}"
echo -e "${green} Checking ansible version ${NC}"

ansible --version | grep python || true
${ANSIBLE_CMD} --version || true
${ANSIBLE_GALAXY_CMD} --version || true

echo -e "${red} Configure workstation ${NC}"

if [ -d "${WORKSPACE}/ansible" ]; then
  cd "${WORKSPACE}/ansible"
  #Below workaround for ansible plugins in jenkins (vault not found)
  cp ansible.cfg vault.passwd ${WORKSPACE} || true
fi

echo -e "${cyan} =========== ${NC}"
echo -e "${green} Installing roles version ${NC}"
echo -e "${magenta} ${ANSIBLE_GALAXY_CMD} install -r requirements.yml -p ./roles/ --ignore-errors --force ${NC}"
${ANSIBLE_GALAXY_CMD} install -r requirements.yml -p ./roles/ --ignore-errors --force

export ANSIBLE_CONFIG=${WORKING_DIR}/ansible.cfg
export PROFILE_TASKS_SORT_ORDER=none
export PROFILE_TASKS_TASK_OUTPUT_LIMIT=all

echo -e "${cyan} =========== ${NC}"
echo -e "${green} Display setup ${NC}"
echo -e "${magenta} ${ANSIBLE_CMD} -m setup ${TARGET_SLAVE} -i inventory/${ANSIBLE_INVENTORY} -vvvv ${NC}"
${ANSIBLE_CMD} -m setup ${TARGET_SLAVE} -i inventory/${ANSIBLE_INVENTORY} -vvvv
RC=$?
if [ ${RC} -ne 0 ]; then
  echo ""
  echo -e "${red} ${head_skull} Sorry, ansible setup failed ${NC}"
  exit 1
else
  echo -e "${green} The ansible setup check completed successfully. ${NC}"
fi

#exit 0
