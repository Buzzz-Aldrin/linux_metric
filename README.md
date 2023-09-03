# Linux_metrics

Task
---
Write a script that will collect metrics from a remote computer and publish them as an html-page inside a docker container. 
The script should be run via ansible. Ansible should prepare the system and update the linux kernel.

Implementation
---
Let's select VirtualBox as a hypervisor and Linux Ubuntu 22.04 as a remote computer.
Select the metrics to be collected: date, kernel version, username, computer name, memory used, available memory, cache, disk usage, available disk space. 
Let's check the performance of the written script on the local computer. 
Next, set up an ssh connection to the remote computer, edit the /etc/sudoers file by adding the line %sudo ALL=(ALL:ALL) NOPASSWD:ALL to execute commands from the sudo user without entering a password.

Create and fill in the ansible.cfg and hosts files to connect Ansible to the remote computer. Split the playbook into several roles:
* kernel_update - downloads packages from the official repository and updates the kernel.
* linux apt_update - updates package lists, installs necessary add-ons to install Docker and collect metrics.
* docker_install - installs Docker, checks that the service is running, creates a docker user group and adds a user to it.
* script - runs a script. The result of a script is an html-page that is delivered to the remote computer.
* build - creates a dockerfile from the prepared template, creates a docker image, launches a docker container in detach mode, mounts the folder with the result of the script, forwards ports, and also checks the healthcheck of the running container.

For ease of use, all variables for each role are placed in a separate vars folder.
Once the playbook is up and running, you should see a success message. After opening a browser and writing the IP of the remote computer into the address bar (192.168.0.131 in my case), you should see the result of the work.

![1](https://github.com/Buzzz-Aldrin/linux_metrics/assets/125478918/99822b18-3ba3-4b61-8ee0-35e60c7e5534)

Let's choose Jenkins as the CI/CD tool. 
After installing Jenkins on the control computer and adding the necessary plugins, we will create an item, in which we will specify a link to the repository with the project, add the necessary credentials and configure trigger build to commit to github. 
To intercept the hook from local computer we will use webhookrelay service. 
After configuring the service and receiving a link to the hook from it, add it into the repository settings in the webhook section. 
After successfully connecting the link, we will make a change to the script and add another metric to track CPU use. 
After updating the script and making the changes in git, Jenkins will start building the project with the changes made. 
Refresh the browser page and verify that the changes were successfully made upon assembly completion.

![2](https://github.com/Buzzz-Aldrin/linux_metrics/assets/125478918/200f1c62-3893-488f-a342-ec1a245e2c8d)
