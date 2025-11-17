# Mini RunRun – GitOps Application Deployment**

## project Overview**

Mini RunRun is a simplified end-to-end DevSecOps project designed to demonstrate how modern software deployments can be automated using **containerization, GitOps, CI/CD pipelines, and Kubernetes orchestration**.
The application consists of a lightweight **frontend** and **backend API**, packaged into containers and deployed through a fully automated GitOps workflow.

---

## Challenge**

Traditional deployment workflows often involve manual steps, inconsistent environments, and poor traceability.
Teams face issues like:

* Repeated configuration drift
* Manual fixes after deployments
* Unreliable rollbacks
* No continuous validation of configurations
* Slow turnaround on changes

The goal was to implement a **consistent, automated, self-healing GitOps workflow** that ensures deployments are reproducible and version-controlled.

---

## Solution**

Mini RunRun implements a standardized GitOps model using:

* **Docker** for containerizing services
* **Helm** for packaging Kubernetes deployments
* **ArgoCD** for GitOps-based delivery
* **GitHub Actions** for CI validation
* **Kubernetes (K3s)** for environment orchestration
* **Prometheus + Grafana** for monitoring

All infrastructure and application changes flow through Git, ensuring traceability and safe rollouts.

---

## Key Features**

### 1. Containerized Microservices**

* Lightweight backend API (health endpoint)
* Simple frontend UI
* Built and tested locally before deployment

### 2. GitOps Deployment with ArgoCD**

* Automatic sync on every commit
* Auto-heal & auto-prune enabled
* Full revision history of cluster state
* Rollback support

### 3. Helm-Based Kubernetes Configuration**

* Centralized chart for deployments
* Controlled replica count
* Configurable image repository and tags
* Declarative templates

### 4. CI Workflow (GitHub Actions)**

* Helm linting
* YAML validation
* Manifest rendering checks
* Repository structure checks

### 5. Monitoring & Observability**

* Prometheus for metrics collection
* Grafana for dashboards
* Port-forward access for local testing

---

## **Architecture Diagram 

--
               ┌────────────┐
               │ Developer   │
               └──────┬─────┘
                      │ git push
   ┌──────────────────┴───────────────────┐
   │                                      │
┌──▼────────────┐                 ┌───────────────┐
│ GitHub Actions│  CI Validation  │ GitHub Repo   │
└──┬────────────┘                 └───────┬──────┘
   │                                      │
   │ watches repo                         │
   │                                      │
┌──▼──────────┐           pull changes   ┌─▼─────────────┐
│   ArgoCD    │────────────────────────► │ Kubernetes     │
│  (GitOps)   │         sync + deploy    │ Cluster (K3s)  │
└──┬──────────┘                          └─┬─────────────┘
   │ monitoring                             │
   │                                         │
┌──▼──────────┐                        ┌────▼─────┐
│ Prometheus  │                        │ Grafana  │
└─────────────┘                        └──────────┘
```



If you want it **even simpler**, **even more like your examples**, or want a **short version**, just tell me.
