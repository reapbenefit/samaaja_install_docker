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
git clone https://github.com/reapbenefit/samaaja_docker_install.git
cd samaaja_docker_install
```

---

## 📝 Step 2: Configure Environment Variables

Edit the `.env` file to set:

```env
MYSQL_ROOT_PASSWORD
SITE_NAME
SAMAAJA_BRANCH
```

---

## 🐳 Step 3: Build and Start the Containers

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

## 📄 License

MIT
