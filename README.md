### Automate Deployment with Terraform and Ansible  

Welcome to Week 2 of the **DevOps CV Challenge**! This week, you’ll be diving into the exciting world of **Infrastructure as Code (IaC)** and **Configuration Management (CM)**. Get ready to use **Terraform** for provisioning cloud infrastructure and **Ansible** for configuring and deploying your application and monitoring stacks. By the end of this task, you'll not only gain hands-on experience automating infrastructure but also learn how to seamlessly integrate multiple tools to create a fully automated deployment pipeline..  

---

### **Task Overview**  

You will:
1. **Prebuild and push Docker images for the application stack from Week 1..**
2. **Design and provision cloud infrastructure using Terraform.**
3. **Use Terraform to:**
   - Trigger Ansible playbooks for:
     - Deploying the application stack.
     - Deploying the monitoring stack.
     - Configuring routing with Traefik or Nginx.
   - Automatically generate the `inventory.ini` file for Ansible.  
4. **Set up application and monitoring stacks using Ansible roles.**

The final deployment will be tested by running:
```bash
terraform apply -auto-approve
```
This command should provision the infrastructure, deploy all services, and configure routing automatically.

---

### **Components**  

#### **1. Application Stack(Same app as Week 1)**
- **Frontend:** A React application.
- **Backend:** A FastAPI service.
- **Database:** PostgreSQL.
- **Reverse Proxy:** Traefik or Nginx (for routing between services).

You must prebuild the Docker images for the **Frontend** and **Backend** and push them to your public Docker Hub repositories:  
- Example frontend image: `docker.io/<your_username>/frontend:latest`  
- Example backend image: `docker.io/<your_username>/backend:latest`  

The application stack Ansible role will pull these images from Docker Hub.

---

#### **2. Monitoring Stack**
- **Prometheus** for metrics collection.
- **Grafana** for visualization (configured with dashboards for cAdvisor and Loki).
- **cAdvisor** for container-level metrics.
- **Loki** for log aggregation.
- **Promtail** for log collection.

---

#### **3. Deployment Workflow**
- **Terraform:**  
  - Provisions the cloud infrastructure (e.g., server instance, networking).
  - Generates the Ansible inventory file (`inventory.ini`) dynamically.  
  - Triggers Ansible playbooks.  

- **Ansible:**  
  - Configures the server environment.  
  - Creates a shared Docker network.  
  - Deploys the application and monitoring stacks by pulling prebuilt images from Docker Hub and running them via Docker Compose.  
  - Configures Traefik or Nginx for routing across all services.

---

### **What You Need to Do**  

#### **Step 1: Prebuild Docker Images**  
1. Build the Docker images for the **Frontend** and **Backend** applications(Same app as Week 1).
2. Push the images to your public Docker Hub repositories.  

#### **Step 2: Design the Architecture**
1. Create an architecture diagram for the deployment, showing how the application and monitoring stacks interact.  
2. Ensure your design accounts for:  
   - Shared Docker networks.  
   - Routing between services.  

#### **Step 3: Write Terraform and Ansible Configurations**
1. **Terraform:**  
   - Provision cloud infrastructure (e.g., a VM instance).  
   - Automatically generate the Ansible inventory file (`inventory.ini`).  
   - Trigger Ansible playbooks.  

2. **Ansible:**  
   - Use roles to:
     - Configure the server environment.
     - Set up and run the **Application Stack** (using Docker Compose).
     - Set up and run the **Monitoring Stack** (using Docker Compose).
     - Configure routing with Traefik.

---

### **Submission Requirements**  
- **Docker Hub Links:**  
  Provide the links to your prebuilt Docker images.  
- **Repository:**  
  Push your Terraform and Ansible code to your GitHub repository and share the link.  
- **Architecture Diagram:**  
  Upload the diagram as an image file in the repository.
- **Documentation:**
  Write a detailed blog post documenting your approach, the architecture, and the deployment process. The blog should include the architecture diagram and provide insights   into the tools used, the challenges faced, and how you overcame them. Publish the post on any blog platform of your choice (e.g., Medium, Dev.to, personal blog).
  Share the link to your blog post in the submission.

Submit your project via this [submission form](https://forms.gle/QYkvXSAJeLziX5CFA)

---

### **How Testing Will Be Done**
1. The reviewers will clone your repository.  
2. Run:
   ```bash
   terraform apply -auto-approve
   ```
3. This command should:
   - Provision the infrastructure.
   - Automatically deploy both the application and monitoring stacks.
   - Configure routing for all services.  

4. The following will be verified:  
   - Application accessibility through the reverse proxy.  
   - Monitoring dashboards in Grafana (including cAdvisor and Loki).  

---

### **Deadline**
All submissions are due by **Sunday, 11:59 PM**.  

Good luck, and happy automating!
