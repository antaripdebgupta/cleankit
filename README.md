# **Cleankit**

Cleankit is a lightweight and efficient command-line tool that helps developers quickly clean boilerplate code and customize metadata (such as title and description) for **React**, **Next.js**, and **Remix** projects. Designed to save time, Cleankit works with a single command to organize projects after downloading a framework or library. It automates the removal of unnecessary files and code, making it faster and easier than manual cleanup, so developers can focus on building features instead of setting up the basics.

---

## **Features**

- 🚀 **Remove Boilerplate**: Automatically delete unnecessary files and folders from React, Next.js, and Remix projects.
- ✏️ **Update Metadata**: Modify the title, description, and other metadata of your project for personalization.
- 🏃 **Run Projects Easily**: Automatically start the project after cleaning if desired.
- 🔧 **Framework Detection**: Detects the framework of your project (React, Next.js, Remix) based on the `package.json` file.
- 🖥️ **Single Command**: Run the tool globally from any directory with a simple `cleankit` command.

---

## **Installation**

### **Install Using Installer Script**

Run the following command to install Cleankit globally:

```bash
curl -s https://raw.githubusercontent.com/antaripdebgupta/cleankit/refs/heads/main/install.sh | sudo bash
```

## **Usage**

### **1. Run Cleankit**

To clean a project, simply navigate to the project directory and run:

```bash
cleankit
```

### **2. Steps**

1. The script will prompt you to enter the path of your project (default is the current directory).
2. It will automatically detect whether the project is React, Next.js, or Remix.
3. Confirm if you want to clean the boilerplate files.
4. Optionally, customize your metadata like title and description.
5. Run the project directly after cleaning.

## Supported Frameworks

- **React**
- **Next.js**
- **Remix**

## License

This project is licensed under the [MIT License](LICENSE). See the LICENSE file for details.

## Contact

If you have any questions or need support, feel free to reach out via [GitHub Issues](https://github.com/antaripdebgupta/cleankit/issues).
