# Getting Started

1. Clone the repository
```bash
git clone github.com/xbaro/soc_vc.git
```

2. Move to the project folder
```bash
cd soc_vc
```

3. Create the folders for the data
```bash
mkdir -p _data/data
```

4. Create the storage file for Letsencrypt certificates
```bash
touch _data/acme.json
chmod 600 _data/acme.json
```

5. Open the file ```config/traefik.toml``` and modify the **ACME credentials** and the **docker domain**.

6. Open the file ```docker_compose.yml``` and modify the label **traefik.frontend.rule** to the domain that will be used.

7. Start the server
```bash
docker_compose up -d
```
