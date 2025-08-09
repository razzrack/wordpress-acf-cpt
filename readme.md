# WordPress with ACF & CPT via Docker

This repository provides a Dockerized WordPress setup integrated with Advanced Custom Fields (ACF) and Custom Post Types (CPT). It's designed for developers seeking a streamlined local development environment for WordPress projects.

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)


### If Not Using Docker (Manual Install):

To manually install WordPress and its dependencies, you'll need the following:

1. **Web Server**: Apache or Nginx
2. **PHP**: PHP 7.4 or higher
3. **MySQL**: MySQL 5.6 or higher
4. **WordPress**: The latest version of WordPress
5. **Additional PHP Extensions**: `zip`, `gd`, `mbstring`, `mysqli`, etc.

### Clone the Repository

```bash
git clone https://github.com/therizdhan/wordpress-acf-cpt.git
cd wordpress-acf-cpt
```

### Configure Environment Variables

Copy the example environment file:
```bash
cp .env-example .env
```

Edit the .env file to set your desired environment variables, such as database credentials and site information.

### Build and Start the Containers

```bash
docker-compose up --build
```

This command will:
- Build the Docker images as defined in the Dockerfile.
- Start the containers as per the configuration in docker-compose.yml.

Note: For Windows, Do this

- Remove file Dockerfile, because it for Mac/Linux
- Rename file Dockerfile.windows to Dockerfile
- Update init.sh file from CRLF to LF via Text Editor (Visual Studio Code or Notepad or Text Editor you always use)

### Access WordPress

Once the containers are up and running, you can access your WordPress site at:

```bash
http://localhost:8000
```

## 🔧 Features
- WordPress Setup: A ready-to-use WordPress installation.
- ACF Integration: Advanced Custom Fields plugin pre-installed for enhanced content management.
- CPT Support: Custom Post Types configured for flexible content structures.
- Elementor Support: Elementor page builder pre-installed for easy drag-and-drop page design.
- Initialization Script: An init.sh script that:
  - Waits for the MySQL database to be ready.
  - Creates the database if it doesn't exist.
  - Sets appropriate permissions for the wp-content directory.
  - Generates the wp-config.php file with necessary configurations.
  - Installs WordPress if not already installed.

## 🛠 Customization
- Custom Post Types (CPT): Define your custom post types in the functions.php file or via the ACF interface.
- ACF Fields: Create and manage custom fields through the WordPress admin panel under the ACF menu.
- Elementor Page Builder: Elementor allows you to design custom layouts for your WordPress site using a visual drag-and-drop editor.

### How to Use Elementor
1. Install Elementor:
   Elementor is already installed in this project. You can access it from the WordPress dashboard to activate it.
2. Create or Edit Pages with Elementor:
   - Go to your WordPress dashboard.
   - Navigate to Pages > Add New or select an existing page.
   - Click the Edit with Elementor button to launch the Elementor editor.
   - Use the drag-and-drop interface to add widgets, sections, and templates to design your page.
   - Customize the layout with visual settings and publish your page.
3. Customize Elementor Widgets:
   Elementor offers a wide variety of widgets that allow you to add complex content elements like headings, images, buttons, videos, forms, and more. Customize each widget's settings from the panel on the left side of the editor.
4. Elementor Templates:
   You can create and save page templates for re-use. To use templates, click the folder icon in the Elementor editor and select from pre-designed templates or save your current design as a template for later use.

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
