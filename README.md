# Samaaja Docker Setup

This guide helps you set up the [Samaaja](https://github.com/reapbenefit/Samaaja) Frappe app in a Dockerized environment.

---

## 🧱 Prerequisites

- Docker and Docker Compose installed
- A domain or IP address (optional for local setup)
- Basic familiarity with Docker and Unix-based systems

---

## 📁 Project Structure

```
samaaja-install/
├── Dockerfile
├── docker-compose.yaml
├── .env
├── entrypoint.sh
└── README.md
```

---

## ⚙️ Step 1: Clone This Repository

```bash
git clone https://github.com/reapbenefit/samaaja_install_docker.git
cd samaaja_install_docker
```

---

## 📝 Step 2: Configure Environment Variables

Edit the `.env` file to set below variables.
Refer [Samaaja](https://github.com/reapbenefit/Samaaja) documentation for the latest stable branch name
```env
MYSQL_ROOT_PASSWORD
SITE_NAME
SAMAAJA_BRANCH
```

---

## 🐳 Step 3: Build and Start the Containers
⚠️ Line Endings (Important for Windows Users) Ensure your Git is configured to use Unix-style line endings (LF) for compatibility with Docker and shell scripts.

```bash
docker-compose up --build
```

This will:
- Start the MariaDB and Redis containers
- Build the Frappe app container
- Automatically create the site and install the Samaaja app

---

## 🚀 Step 4: Access the Site

Once the setup completes, go to:

```
http://<site-name>:8000
```

Or use your public IP/domain if deploying remotely.

---
## 🛠️ Step 5 Samaaja Post-Installation Setup

Once you've successfully installed Samaaja using Docker, follow these **post-installation steps** to complete the setup:

### ✅ Step 1: Enable Energy Point Rule

1. Log in to your Frappe/Samaaja site.
2. Search for and open **Energy Point Rule** in the Awesome Bar.
3. Ensure that it is **enabled**.

### ✅ Step 2: Setup Samaaja via UI

1. Go to **Samaaja Settings**.
2. Click the button **"Setup Samaaja"**.

> This triggers the backend setup logic and completes initial configuration.

---

## 📦 Notes

- To rebuild from scratch: `docker-compose down -v && docker-compose up --build`
- Logs are printed in the console. You can inspect logs with:
  ```bash
  docker-compose logs -f frappe
  ```

---

## 🛠️ Troubleshooting

- **MySQL root error:** Ensure your `.env` file is loaded and matches the password in `docker-compose.yaml`.
- **App not found:** Check that `SAMAJA_BRANCH` is correct and `get-app` is pulling properly.
- **Supervisor error:** Use `bench restart` instead of `supervisorctl`.

---

## 🧹 Cleanup

To remove all containers and volumes:

```bash
docker-compose down -v
```

---

## 🙏 Credits

- [Frappe Framework](https://github.com/frappe/frappe)
- [Samaaja](https://github.com/reapbenefit/Samaaja) by FOSS United / ReapBenefit and maintained by [Impactyaan](https://impactyaan.com)

---
## 📬 Questions or Issues?
For any questions, issues, or support, please contact us at:
📧 contact@impactyaan.org

## 📄 License

MIT
