# Devops Exercise

This project shows deploying a containerized application using **Docker, Terraform, AWS EC2, ECR, and GitHub Actions**.

The system includes:

* **Frontend**: React
* **Backend**: Rust API
* **Cache**: Redis
* **Infra**: AWS EC2 (provisioned using Terraform)
* **CI/CD**: GitHub Actions for pushing images to ECR

## Current Architecture

The application is deployed on a single EC2 instance using Docker Compose.

```
User → EC2 (Public IP)
         ├── Frontend (Nginx container)
         ├── API (Rust container)
         └── Redis (container)
```

* The frontend is accessed via port **3000**
* The backend runs on port **8080**
* Redis runs internally within the Docker bridge network

# Containerization & Networking

All services are containerized and orchestrated using **docker-compose**.

* The **API connects to Redis** using Docker DNS:

  ```
  redis:6379
  ```
* The **frontend communicates with backend** via:

  ```
  http://localhost:8080
  ```

This setup ensures service-to-service communication inside Docker while exposing only required ports externally.

# Infrastructure Setup

Terraform is used to provision:

* **EC2 instance (t2.micro)** for hosting the app
* **Security Group** allowing:

  * SSH (22)
  * HTTP (80)
  * API (8080)
* **ECR repositories** for storing Docker images

A **user data script** bootstraps the instance by:

* Installing Docker & Docker Compose

# CI/CD Pipeline

GitHub Actions automates build and deployment.

### Flow:

1. Code is pushed to GitHub
2. Pipeline builds Docker images for API and frontend
3. Images are pushed to **Amazon ECR**
4. Pipeline SSHs into EC2 and restarts Docker services

# Current Limitations

While functional, the current setup has constraints:

* Single EC2 → **single point of failure**
* No load balancing or auto scaling
* Redis is not managed or persistent
* Public exposure of backend port (8080)
* No HTTPS or domain
* Deployment via SSH is not scalable

# Security Improvements (Next phases)

To make the system more secure:

* Restrict SSH access to specific IPs instead of `0.0.0.0/0`
* Remove public access to backend port (8080) and route internally
* Attach IAM role to EC2
* Introduce HTTPS using ALB or Nginx with SSL
* Store sensitive configs in **AWS Secrets Manager**

# 🚀 Future Enhancements

To evolve this into a production-grade system:

## High Availability

* Move from EC2 to **ECS Fargate**
* Use **Application Load Balancer (ALB)** for routing
* Replace Redis container with **ElastiCache (Multi-AZ)**

### Frontend Optimization

* Host frontend on **S3 + CloudFront**
* Enable CDN caching and global delivery

### CI/CD Improvements

* Implement **blue-green deployments**
* Add rollback strategies

### Observability

* Integrate **CloudWatch logs and metrics**

👉 ECS + ALB production architecture
👉 or a strong DevOps portfolio project write-up

Just tell me 👍

